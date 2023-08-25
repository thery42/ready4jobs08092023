// Ce widget est utilisé pour afficher un bouton d'inscription avec Google.
// Le bouton est un ElevatedButton (bouton surélevé) contenant une image de logo Google et du texte "S'inscrire avec Google".
// Lorsque l'utilisateur appuie sur le bouton, la fonction 'onPressed' passée en paramètre est appelée.
// Le style du bouton est personnalisé en utilisant ElevatedButton.styleFrom pour définir la couleur de fond en blanc.
// Ce widget est utile pour faciliter l'inscription des utilisateurs en utilisant leur compte Google.


import 'package:flutter/material.dart';

class GoogleSignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleSignUpButton({required this.onPressed});

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
            'S\'inscrire avec Google',
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
