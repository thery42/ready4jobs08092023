import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/forgot-password'); // New route for the password reset page
        },
        child: Text(
          'Mot de passe oublié ?',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
