import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 1; // You can adjust this factor
    double buttonHeight = screenHeight * 0.06; // You can adjust this factor

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          } catch (e) {
            print("Erreur lors de la déconnexion : $e");
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kButtonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonBorderRadius),
            ),
          ),
        ),
        child: Text(
          'Se déconnecter',
          style: TextStyle(
            color: kButtonTextColor,
          ),
        ),
      ),
    );
  }
}
