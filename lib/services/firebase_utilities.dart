import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;

Future<void> uploadChatImageToFirebase(GlobalKey key) async {
  final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage();
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  final now = DateTime.now();
  final fileName = 'entretien_${now.toIso8601String()}.png';

  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    print('Failed to upload entretien image: User is not signed in.');
    return;
  }

  final reference = FirebaseStorage.instance.ref().child('entretiens').child(userId).child(fileName);

  UploadTask uploadTask = reference.putData(buffer);

  try {
    await uploadTask.whenComplete(() async {
      // Once the image is uploaded, get its URL
      final imageUrl = await reference.getDownloadURL();

      // Print the generated imageUrl for verification
      print('Generated imageUrl: $imageUrl');

      // Save to Firestore
      FirebaseFirestore.instance
          .collection('entretiens')
          .doc(userId)
          .collection('uploaded_docs')
          .add({'url': imageUrl, 'name': fileName, 'timestamp': FieldValue.serverTimestamp() });

      print('Entretien image uploaded to Firebase Storage and reference added to Firestore.');
    });
  } catch (e) {
    print('Failed to upload entretien image: $e');
  }
}

class FirebaseManager {
  Future<void> uploadTextToFirebase(String userId, String extractedText) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cv_text')
          .add({'text': extractedText});
    } catch (e) {
      // Gérez les erreurs d'envoi vers Firebase
    }
  }
}

class FirebaseUtils {
  static void listenToCVUploads() {
    FirebaseFirestore.instance.collection('cvs').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          String cvPath = change.doc.data()?['path'];
          // Appeler la fonction d'extraction de texte avec cvPath depuis ici.
        }
      }
    });
  }
}