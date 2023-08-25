import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: kWelcomeButtonColor,
      ),
      child: Text(
        'Se connecter',
        style: kWelcomeButtonBlackTextStyle,
      ),
    );
  }
}