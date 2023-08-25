import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ready4jobs/widgets/app_scaffold.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';
import 'package:ready4jobs/widgets/PasswordResetPage/constants.dart';




class PasswordResetPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final Key? key;

  PasswordResetPage({this.key}) : super(key: key);

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );

      // Show a SnackBar indicating the email was sent successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Un email de réinitialisation de mot de passe a été envoyé à ${_emailController.text}. Veuillez vérifier votre boîte de réception.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle errors if necessary
      print('Erreur lors de l\'envoi de l\'email de réinitialisation du mot de passe: ');

      // Show a SnackBar indicating an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur s\'est produite lors de l\'envoi de l\'email de réinitialisation du mot de passe. Veuillez réessayer plus tard.'),
          backgroundColor: Colors.red,
        ),
      );
      return;  // Return here to prevent the page from closing on error
    }

    // Close the page after a short delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(title: 'Réinitialiser le mot de passe'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 80), // Add a SizedBox to reduce space between AppBar and Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Entrez votre adresse email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _resetPassword(context),

              child: Text(
                'Réinitialiser le mot de passe',
                style: kWelcomeButtonBlackTextStyle,
              ),
              style: ElevatedButton.styleFrom(
                primary: kWelcomeButtonColor,
                maximumSize: Size(80, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}