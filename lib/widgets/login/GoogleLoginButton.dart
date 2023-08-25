import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleLoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/google.png', height: 25, width: 25),
          SizedBox(width: 10),
          Text(
            'Se connecter avec Google',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    );
  }
}
