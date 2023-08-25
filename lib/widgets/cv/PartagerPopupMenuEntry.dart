import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Import modifié pour share_plus
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready4jobs/widgets/constants.dart';

class PartagerPopupMenuEntry extends PopupMenuEntry<int> {
  @override
  double get height => 48;

  @override
  bool represents(int? value) => value == 1;

  @override
  _PartagerPopupMenuEntryState createState() => _PartagerPopupMenuEntryState();
}

class _PartagerPopupMenuEntryState extends State<PartagerPopupMenuEntry> {

  Future<String?> _getDownloadUrlFromFirestore(String userId) async {
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
        throw Exception("URL not found in Firestore.");
      }
    } catch (e) {
      print("Error getting URL from Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de la récupération de l'URL depuis Firestore."),
          duration: Duration(seconds: 3),
        ),
      );
      return null;
    }
  }

  Future<void> _shareDocument() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("L'utilisateur n'est pas connecté."),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    String userId = currentUser.uid;
    try {
      String? downloadUrl = await _getDownloadUrlFromFirestore(userId);
      if (downloadUrl != null) {
        Share.share(downloadUrl);
      }
    } catch (e) {
      print("Error sharing document: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors du partage du document."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      value: 1,
      child: GestureDetector(
        onTap: () async {
          await _shareDocument();
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.6,
              ),
            ),
          ),
          child: Text(
            "Partager",
            style: TextStyle(color: kPopupMenuPointsColor),
          ),
        ),
      ),
    );
  }
}
