import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready4jobs/services/file_downloader_utils.dart';
import 'package:ready4jobs/services/permission_utils.dart';

// Constante pour l'option de téléchargement dans le menu.
const int TELECHARGER_MENU_ITEM_VALUE = 3;

// Widget d'entrée pour le menu de téléchargement.
class TelechargerPopupMenuEntry extends PopupMenuEntry<int> {
  @override
  double get height => 0;

  @override
  bool represents(int? value) => value == TELECHARGER_MENU_ITEM_VALUE;

  @override
  _TelechargerPopupMenuEntryState createState() => _TelechargerPopupMenuEntryState();
}

// État du widget d'entrée de menu de téléchargement.
class _TelechargerPopupMenuEntryState extends State<TelechargerPopupMenuEntry> {

  // Récupère l'URL de téléchargement depuis Firestore pour un utilisateur donné.
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

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      value: TELECHARGER_MENU_ITEM_VALUE,
      onTap: () async {

        if (!await PermissionUtils.requestStoragePermission()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Permission de stockage refusée."),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

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
        String? downloadUrl = await _getDownloadUrlFromFirestore(userId);
        if (downloadUrl != null) {
          try {
            await FileDownloaderUtils.downloadFile(context, downloadUrl);


            // Notification de succès
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Téléchargement réussi!"),
                duration: Duration(seconds: 3),
              ),
            );

          } catch (e) {
            print("Erreur lors du téléchargement du fichier: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Erreur lors du téléchargement du fichier."),
                duration: Duration(seconds: 3),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Impossible de récupérer l'URL de téléchargement."),
              duration: Duration(seconds: 3),
            ),
          );
        }
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
          "Télécharger",
          style: TextStyle(color: kPopupMenuPointsColor),
        ),
      ),
    );
  }
}
