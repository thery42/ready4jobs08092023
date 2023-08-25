import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class EmailInputWidget extends StatelessWidget {
  final TextEditingController controller;

  EmailInputWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: EMAIL_TEXT_COLOR,  // Utilisation de la constante pour la couleur du texte
        fontSize: EMAIL_TEXT_FONT_SIZE,  // Utilisation de la constante pour la taille de la police
      ),
      decoration: InputDecoration(
        labelText: EMAIL_TITLE_TEXT,
        labelStyle: TextStyle(
          fontSize: EMAIL_TITLE_FONT_SIZE,
          color: EMAIL_TITLE_COLOR,
        ),
        hintText: 'Entrez votre email',
        hintStyle: TextStyle(
          color: EMAIL_TEXT_COLOR,  // Utilisation de la constante pour la couleur du texte d'astuce
          fontSize: EMAIL_TEXT_FONT_SIZE,  // Utilisation de la constante pour la taille de la police d'astuce
        ),
        suffixIcon: Icon(
          EMAIL_TRAILING_ICON,
          size: EMAIL_TRAILING_ICON_SIZE,
          color: EMAIL_TRAILING_ICON_COLOR,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une adresse e-mail';
        }
        return null;
      },
    );
  }
}