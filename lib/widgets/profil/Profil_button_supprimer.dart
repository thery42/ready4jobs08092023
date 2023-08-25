import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:ready4jobs/pages/sign_up_page.dart';


class DeleteButton extends StatelessWidget {
  const DeleteButton();

  Future<void> deleteUserAccount() async {
    // Get current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // 1. Delete user data from Firebase database.
      FirebaseFirestore.instance.collection('users').doc(currentUser.uid).delete();

      // 2. Delete user files from Firebase storage if any.
      // Assuming there's a user_files directory for each user
      FirebaseStorage.instance.ref('user_files/${currentUser.uid}').listAll().then((res) {
        for (var item in res.items) {
          item.delete();
        }
      });

      // 3. Delete the user account from Firebase Authentication.
      await currentUser.delete();
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(
              'Toutes les données seront effacées et ne pourront être récupérées. Voulez-vous continuer?'),
          actions: <Widget>[
            TextButton(
              child: Text('Refuser'),
              onPressed: () {
                Navigator.of(context).pop(false);  // Return false
              },
            ),
            TextButton(
              child: Text('Valider'),
              onPressed: () {
                Navigator.of(context).pop(true);  // Return true
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 1;
    double buttonHeight = screenHeight * 0.06;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          bool shouldDelete = await _showConfirmationDialog(context);
          if (shouldDelete) {
            try {
              await deleteUserAccount();

              // Redirect the user to the SignUpPage
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
              );

            } catch (e) {
              // Handle any errors, maybe show a snackbar or a dialog
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error deleting account: $e'),
              ));
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kDeleteButtonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDeleteButtonBorderRadius),
            ),
          ),
        ),
        child: Text(
          'Supprimer mon compte',
          style: TextStyle(
            color: kDeleteButtonTextColor,
          ),
        ),
      ),
    );
  }
}
