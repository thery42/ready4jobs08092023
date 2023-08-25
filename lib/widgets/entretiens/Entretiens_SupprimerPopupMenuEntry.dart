import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EntretiensSupprimerPopupMenuEntry extends PopupMenuEntry<int> {
  late final String imageUrl;

  EntretiensSupprimerPopupMenuEntry({required this.imageUrl});

  @override
  double get height => 48;

  @override
  bool represents(int? value) => value == 2;

  @override
  _SupprimerPopupMenuEntryState createState() => _SupprimerPopupMenuEntryState();
}

class _SupprimerPopupMenuEntryState extends State<EntretiensSupprimerPopupMenuEntry> {
  Future<void> supprimerDocument() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('L\'utilisateur n\'est pas connecté. Veuillez vous connecter pour effectuer cette action.');
        return;
      }
      String userId = user.uid;
      print('User ID : $userId');

      FirebaseFirestore.instance
          .collection('entretiens')
          .doc(userId)
          .collection('uploaded_docs')
          .where('url', isEqualTo: widget.imageUrl)
          .get()
          .then((QuerySnapshot querySnapshot) {
        print('Nombre de documents trouvés : ${querySnapshot.docs.length}');
        querySnapshot.docs.forEach((doc) {
          print('Tentative de suppression du document avec ID: ${doc.id}');
          doc.reference.delete();
        });
      }).catchError((error) {
        print("Erreur lors de la récupération des documents : $error");
      });
    } catch (e) {
      print('Une erreur s\'est produite lors de la suppression du document : $e');
    }
  }

  Future<void> supprimerFichier() async {
    if (!(widget.imageUrl.startsWith('gs://') || widget.imageUrl.startsWith('https://'))) {
      print('URL de Firebase Storage invalide : ${widget.imageUrl}');
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.refFromURL(widget.imageUrl).delete();
      print('Fichier supprimé avec succès dans Firebase Storage');
    } catch (e) {
      print('Erreur lors de la suppression du fichier dans Firebase Storage : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      value: 2,
      child: InkWell(
        onTap: () {
          supprimerFichier().then((_) {
            supprimerDocument();
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Une erreur est survenue !')));
          });
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
            "Supprimer",
            style: TextStyle(color: kPopupMenuPointsColor),
          ),
        ),
      ),
    );
  }
}
