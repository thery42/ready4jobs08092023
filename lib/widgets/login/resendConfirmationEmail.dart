import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready4jobs/widgets/constants.dart';

class ResendConfirmationEmailButton extends StatefulWidget {
  @override
  _ResendConfirmationEmailButtonState createState() =>
      _ResendConfirmationEmailButtonState();
}

class _ResendConfirmationEmailButtonState
    extends State<ResendConfirmationEmailButton> {
  bool _isSendingEmail = false;
  bool _isVisible = true;

  Future<void> _resendConfirmationEmail() async {
    setState(() {
      _isSendingEmail = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        // Vous pouvez également afficher un message de succès ici si nécessaire.
      }
    } catch (e) {
      print('Erreur lors du renvoi de l\'e-mail de confirmation : $e');
      // Vous pouvez afficher un message d'erreur ici si nécessaire.
    }

    setState(() {
      _isVisible = false; // Hide the button after it's pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible,
      child: ElevatedButton(
        onPressed: _isSendingEmail ? null : () {
          _resendConfirmationEmail();
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF04CAE9),
          onPrimary: Color(0xFF04CAE9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: _isSendingEmail
              ? SizedBox(
            width: 10.0,
            height: 10.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          )
              : Text(
            'Renvoyer l\'e-mail de confirmation',
            style: kTitleTextStyle,
          ),
        ),
      ),
    );
  }
}
