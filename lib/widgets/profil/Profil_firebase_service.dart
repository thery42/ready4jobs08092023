import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  static Future<void> deleteProfilePictureFromFirestore(String userId) async {
    try {
      CollectionReference pictures = FirebaseFirestore.instance.collection('profile_pictures');
      DocumentReference userDoc = pictures.doc(userId);
      DocumentSnapshot docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        await userDoc.delete();
        print("Document deleted successfully from Firestore.");
      } else {
        print("No document found in Firestore.");
      }
    } catch (e) {
      print('Error deleting document from Firestore: $e');
    }
  }

  static Future<void> deletePreviousProfilePicture(BuildContext context, String userId) async {
    try {
      final storage = FirebaseStorage.instance;
      final folderRef = storage.ref().child('profile_pictures/$userId');
      final listResult = await folderRef.listAll();

      if (listResult.items.isEmpty) {
        print('No files to delete.');
        return;
      }

      final fileRef = listResult.items.first;
      await fileRef.delete();

      print("File deleted successfully.");
    } catch (e) {
      print('Error during deletion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the profile picture.')),
      );
    }
  }

  static Future<void> uploadProfilePicture(BuildContext context, File imageFile, String userId) async {
    try {
      final storage = FirebaseStorage.instance;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final originalFileName = imageFile.path.split('/').last;
      final uniqueFileName = 'profile_$timestamp.${originalFileName.split('.')[1]}';

      final profilePictureRef = storage.ref().child('profile_pictures/$userId/$uniqueFileName');
      final uploadTask = profilePictureRef.putFile(imageFile);

      print("Starting upload...");

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });

      final taskSnapshot = await uploadTask;
      print('Upload complete!');

      final downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('Download URL: $downloadUrl');

      print("Adding document to Firestore...");




      FirebaseFirestore.instance
          .collection('profile_pictures')
          .doc(userId)
          .collection('uploaded_docs')
          .add({'url': downloadUrl, 'name': uniqueFileName, 'timestamp': FieldValue.serverTimestamp() });

      print('Profile photo uploaded successfully. Download URL: $downloadUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile photo uploaded successfully!')),
      );
    } catch (e) {
      print('Error during upload: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while uploading the profile photo.')),
      );
    }
  }

  static Future<void> saveSelectedSectorMetier(String userId, String selectedSector) async {
    try {
      // Saving the selected job to Firebase
      await FirebaseFirestore.instance
          .collection('metier')
          .doc(userId)
          .set({'selectedSector': selectedSector});
      print('Métier sauvegardé sur Firebase : $selectedSector');
    } catch (e) {
      print('Erreur lors de la sauvegarde sur Firebase : $e');
    }
  }
}



