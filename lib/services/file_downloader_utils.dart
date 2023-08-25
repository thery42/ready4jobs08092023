import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FileDownloaderUtils {

  static Future<void> downloadFile(BuildContext context, String url) async {
    String? savePath;

    // Obtenez le dossier d'application.
    final directory = await getApplicationDocumentsDirectory();
    if (directory == null) {
      _showSnackBar(context, "Erreur lors de la détermination de l'emplacement de sauvegarde");
      return;
    }

    // Créez un sous-dossier "Téléchargements" pour votre application (si nécessaire).
    final downloadsDirectory = Directory('${directory.path}/Téléchargements');
    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create();
    }

    // Spécifiez le nom du fichier.
    final fileName = url.split('/').last;
    savePath = "${downloadsDirectory.path}/$fileName";

    final File? downloadedFile = await FileDownloader.downloadFile(
      url: url,
      name: savePath,
      onProgress: (filePath, progress) {
        print("Download progress for $filePath: $progress%");
      },
      onDownloadCompleted: (filePath) {
        print("Download completed: $filePath");
      },
      onDownloadError: (error) {
        _showSnackBar(context, "Erreur lors du téléchargement du fichier: $error");
      },
    );

    if (downloadedFile == null) {
      _showSnackBar(context, "Il y a eu un problème lors du téléchargement du fichier");
    }
  }

  static Future<String?> getDownloadUrlFromFirestore(String userId) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('cvs')
          .doc(userId)
          .collection('uploaded_docs')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('url')) {
        return data['url'] as String;
      } else {
        print("URL not found in Firestore.");
        return null;
      }
    } catch (e) {
      print("Error getting URL from Firestore: $e");
      return null;
    }
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
