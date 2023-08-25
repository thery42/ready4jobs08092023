// Ce widget est utilisé pour afficher un bouton d'inscription avec le texte "Inscription".
// Le bouton est un ElevatedButton (bouton surélevé) avec une couleur de fond personnalisée (Color(0xFF04CAE9)).
// Lorsque l'utilisateur appuie sur le bouton, la fonction 'onPressed' passée en paramètre est appelée.
// Le style du bouton est personnalisé en utilisant ButtonStyle pour définir la couleur de fond.
// Le texte du bouton est défini comme "Inscription" avec une police de caractères 'Inter' et une taille de police de 12.
// Ce widget est utile pour afficher un bouton d'inscription avec un style personnalisé dans l'interface utilisateur de l'application.


import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF04CAE9)),
      ),
      onPressed: onPressed,
      child: Text(
        'Inscription',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
