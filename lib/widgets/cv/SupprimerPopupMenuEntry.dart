import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import the Firebase Storage package
import 'package:ready4jobs/widgets/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SupprimerPopupMenuEntry extends PopupMenuEntry<int> {
  final String downloadUrl;

  SupprimerPopupMenuEntry({required this.downloadUrl});

  @override
  double get height => 48; // Set the desired height for your PopupMenuItem.

  @override
  bool represents(int? value) => value == 2; // Check if the entry represents the given value.

  @override
  _SupprimerPopupMenuEntryState createState() => _SupprimerPopupMenuEntryState();
}

class _SupprimerPopupMenuEntryState extends State<SupprimerPopupMenuEntry> {
  // Fonction pour supprimer le document
  void supprimerDocument() async {
    try {
      // Vérifie si l'utilisateur est connecté
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Si l'utilisateur n'est pas connecté, affiche un message d'erreur ou redirige vers l'écran de connexion
        print('L\'utilisateur n\'est pas connecté. Veuillez vous connecter pour effectuer cette action.');
        return;
      }

      String userId = user.uid; // Get the authenticated user's ID
      print('User ID : $userId'); // Print User ID

      // Get the document ID to delete
      FirebaseFirestore.instance
          .collection('cvs')
          .doc(userId)
          .collection('uploaded_docs')
          .where('url', isEqualTo: widget.downloadUrl)
          .get()
          .then((QuerySnapshot querySnapshot) {
        print('Nombre de documents trouvés : ${querySnapshot.docs.length}');
        querySnapshot.docs.forEach((doc) {
          print('Trying to delete document with ID: ${doc.id}');
          doc.reference.delete(); // Delete the document
        });
      })
          .catchError((error) {
        print("Erreur lors de la récupération des documents : $error");
      });

    } catch (e) {
      print('Une erreur s\'est produite lors de la suppression du document : $e');
    }
  }

  // Fonction pour supprimer le fichier
  void supprimerFichier() async {
    FirebaseStorage storage = FirebaseStorage.instance; // Get an instance of the Firebase Storage

    try {
      await storage.refFromURL(widget.downloadUrl).delete(); // Delete the file
      print('Fichier supprimé avec succès dans Firebase Storage');
    } catch(e) {
      print('Erreur lors de la suppression du fichier dans Firebase Storage : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      value: 2,
      child: InkWell(
        onTap: () {
          supprimerDocument(); // Supprimer le document Firestore
          supprimerFichier(); // Supprimer le fichier Firebase Storage
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black, // Border color
                width: 1.6, // Border width
              ),
            ),
          ),
          child: Text(
            "Supprimer",
            style: TextStyle(color: kPopupMenuPointsColor),
          ),
        ),
      ),
    );
  }
}
