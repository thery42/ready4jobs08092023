import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class FileManager {
  // Télécharge un fichier à partir de l'URL spécifiée et l'enregistre localement.
  // Si un chemin de destination est fourni, le fichier sera enregistré à cet emplacement.
  // Renvoie le chemin complet du fichier téléchargé en cas de succès, sinon renvoie null en cas d'erreur.
  Future<String?> downloadFile(String url, {String? destPath}) async {
    try {
      final filename = path.basename(url);
      var bytes = await http.readBytes(Uri.parse(url));

      print('Bytes length: ${bytes.length}');

      if (bytes.length == 0) {
        // Si le fichier est vide, générer une exception.
        throw Exception('Erreur lors du téléchargement du fichier, fichier vide.');
      }

      String dir = destPath ?? (await getApplicationDocumentsDirectory()).path;
      File file = new File(path.join(dir, filename));
      await file.writeAsBytes(bytes);
      print('File path: ${file.path}');

      // Si tout s'est bien passé, on renvoie le chemin du fichier
      return file.path;
    } catch (e) {
      print('Une erreur est survenue lors du téléchargement du fichier : $e');
      // En cas d'erreur, on renvoie null
      return null;
    }
  }

  // Renomme un fichier en utilisant un nouveau nom de fichier spécifié.
  // Renvoie le nouveau chemin complet du fichier après le renommage.
  Future<String> renameFile(String oldPath, String newFileName) async {
    String dir = path.dirname(oldPath);
    File file = new File(path.join(dir, newFileName));
    File oldFile = File(oldPath);
    await oldFile.rename(file.path);
    return file.path;
  }

  // Supprime le fichier spécifié.
  Future<void> deleteFile(String path) async {
    File file = File(path);
    await file.delete();
  }
}
