/*

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


void main() {
  // ...
  FirebaseUtils.listenToCVUploads();
}

class FirebaseUtils {
  static void listenToCVUploads() {
    print("Listening to CV uploads...");
    FirebaseFirestore.instance.collectionGroup('uploaded_docs').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          String? userId = change.doc.reference.parent.parent?.id;
          String cvPath = change.doc.data()?['path'];
          print("New CV added for user $userId, path: $cvPath");
          handleNewCVAdded(userId!, cvPath);
        }
      }
    });
  }
}

void handleNewCVAdded(String userId, String cvPath) {
  String pdfPath = join('/cvs', userId, 'uploaded_docs', cvPath);
  print("Full PDF path: $pdfPath");
  extractAndSaveTextFromPdf(userId, pdfPath);
}

Future<void> extractAndSaveTextFromPdf(String userId, String pdfPath) async {
  try {
    print("Extracting text from PDF: $pdfPath");
    final doc = await PDFDoc.fromFile(File(pdfPath));
    final text = await doc.text;
    print("Extracted text: $text");
    saveTextToFirestore(userId, text);
    print("Text extracted and saved to Firestore.");
  } catch (error) {
    print("Error extracting text from PDF: $error");
  }
}

void saveTextToFirestore(String userId, String extractedText) {
  FirebaseAuth auth = FirebaseAuth.instance;

  if (auth.currentUser != null) {
    print("Saving text to Firestore for user: $userId");
    FirebaseFirestore.instance
        .collection('cvs')
        .doc(userId)
        .collection('extracted_text')
        .add({
      'text': extractedText,
      'timestamp': FieldValue.serverTimestamp()
    })
        .then((_) {
      print("Text saved successfully");
    })
        .catchError((error) {
      print("Error saving text: $error");
    });
  } else {
    print("User is not authenticated. Cannot save text to Firestore.");
  }
}
*/