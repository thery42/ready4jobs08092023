import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'dart:async';

import 'dart:io';


class EntretienEndButton extends StatelessWidget {
  final void Function() onPressed;
  final User? user;


  EntretienEndButton({required this.onPressed, this.user});

  Future<File?> getCachedEntretiens(String fileName) async {
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

  Future<File> cacheEntretiens(File entretiensFile, String fileName) async {
    final cacheDir = await getTemporaryDirectory();
    final targetFile = File('${cacheDir.path}/$fileName');

    // Optionnel : avant la copie, vérifiez si le fichier est un PDF valide (vous aurez besoin d'une méthode pour le faire).

    return entretiensFile.copy(targetFile.path);
  }

  // Enregistre dans Firestore
  Future<void> uploadentretiens(BuildContext context, File file, String userId) async {
    try {
      final storage = FirebaseStorage.instance;

      // Génère un nom de fichier unique
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final originalFileName = file.path.split('/').last;
      final uniqueFileName = '${originalFileName.split('.')[0]}_$timestamp.${originalFileName.split('.')[1]}';

      final entretiensRef = storage.ref().child('entretiens/$userId/$uniqueFileName');
      final uploadTask = entretiensRef.putFile(file);
      final taskSnapshot = await uploadTask;
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Enregistre dans Firestore
      FirebaseFirestore.instance
          .collection('entretiens')
          .doc(userId)
          .collection('uploaded_docs')
          .add({'url': downloadUrl, 'name': uniqueFileName, 'timestamp': FieldValue.serverTimestamp() });

      print('entretiens téléchargé avec succès. URL de téléchargement: $downloadUrl');

      // Met en cache l'entretiens
      await cacheEntretiens (file, uniqueFileName);

      // Affiche un message de réussite à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('entretiens téléchargé avec succès!')),
      );
    } catch (e) {
      // Affiche un message d'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite lors du téléchargement du entretiensRef.')),
      );

      print('Une erreur s\'est produite lors du téléchargement du entretiensRef: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kEndButtonPadding,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          kEndButtonText,
          style: TextStyle(
            color: kEndButtonTextColor, // Ajout de la couleur de texte
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: kEndButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: kEndButtonBorderRadius, // Arrondissement des angles
          ),
        ),
      ),
    );
  }
}
