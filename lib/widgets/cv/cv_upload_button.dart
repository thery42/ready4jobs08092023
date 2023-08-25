import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:path_provider/path_provider.dart';

class CVUploadButton extends StatefulWidget {
  final User? user;

  CVUploadButton({Key? key, this.user}) : super(key: key);

  @override
  _CVUploadButtonState createState() => _CVUploadButtonState();
}

class _CVUploadButtonState extends State<CVUploadButton> {
  double desiredWidth = 80.0;
  double desiredHeight = 120.0;

  Future<File?> getCachedCV(String fileName) async {
    final cacheDir = await getTemporaryDirectory();
    final cachedFile = File('${cacheDir.path}/$fileName');

    if (await cachedFile.exists()) {
      // Vérifie si le cache est ancien et, dans ce cas, le supprime.
      final cacheCreationDate = await cachedFile.lastModified();
      final durationSinceCache = DateTime.now().difference(cacheCreationDate);
      if (durationSinceCache > Duration(days: 7)) {  // Cache plus vieux que 7 jours
        await cachedFile.delete();
        return null;
      }
      return cachedFile;
    }
    return null;
  }

  Future<File> cacheCV(File cvFile, String fileName) async {
    final cacheDir = await getTemporaryDirectory();
    final targetFile = File('${cacheDir.path}/$fileName');

    // Optionnel : avant la copie, vérifiez si le fichier est un PDF valide (vous aurez besoin d'une méthode pour le faire).

    return cvFile.copy(targetFile.path);
  }

  Future<void> uploadCV(File file, String userId) async {
    try {
      final storage = FirebaseStorage.instance;

      // Génère un nom de fichier unique
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final originalFileName = file.path.split('/').last;
      final uniqueFileName = '${originalFileName.split('.')[0]}_$timestamp.${originalFileName.split('.')[1]}';

      final cvRef = storage.ref().child('cvs/$userId/$uniqueFileName');
      final uploadTask = cvRef.putFile(file);
      final taskSnapshot = await uploadTask;
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Enregistre dans Firestore
      FirebaseFirestore.instance
          .collection('cvs')
          .doc(userId)
          .collection('uploaded_docs')
          .add({'url': downloadUrl, 'name': uniqueFileName, 'timestamp': FieldValue.serverTimestamp() });

      print('CV téléchargé avec succès. URL de téléchargement: $downloadUrl');

      // Met en cache le CV
      await cacheCV(file, uniqueFileName);

      // Affiche un message de réussite à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('CV téléchargé avec succès!')),
      );
    } catch (e) {
      // Affiche un message d'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite lors du téléchargement du CV.')),
      );

      print('Une erreur s\'est produite lors du téléchargement du CV: $e');
    }
  }

  Future<void> chooseCVAndUpload() async {
    try {
      print('ID utilisateur: ${widget.user?.uid}');

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        final file = File(result.files.first.path!);
        final fileSizeInBytes = file.lengthSync();

        // Ici, je fixe la limite à 2 Mo. Vous pouvez ajuster cette valeur selon vos besoins.
        const maxFileSizeInBytes = 2 * 1024 * 1024;

        if (fileSizeInBytes > maxFileSizeInBytes) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('La taille du CV dépasse la limite autorisée de 2 Mo. Veuillez choisir un fichier plus petit.')),
          );
          return;
        }

        if (widget.user == null || widget.user?.uid == null) {
          print('L\'utilisateur n\'est pas authentifié');
          return;
        }

        await uploadCV(file, widget.user!.uid);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite lors de la sélection du fichier.')),
      );

      print('Une erreur s\'est produite lors de la sélection du fichier: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return buildCustomButton(context, chooseCVAndUpload);
  }
}
