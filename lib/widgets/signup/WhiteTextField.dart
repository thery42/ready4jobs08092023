// Ce widget est utilisé pour afficher un champ de texte blanc personnalisé avec des options supplémentaires.
// Le widget accepte plusieurs paramètres pour personnaliser le champ de texte, tels que le contrôleur (controller) pour gérer les saisies,
// un booléen (isFieldFocused) pour indiquer si le champ est en focus, un labelText pour étiqueter le champ,
// un validateur pour vérifier les saisies, un keyboardType pour spécifier le type de clavier à afficher,
// un booléen (obscureText) pour masquer le texte saisi (mot de passe), un suffixIcon pour ajouter une icône à la fin du champ,
// et un focusNode pour gérer le focus du champ.
// Le paramètre 'hintText' est également inclus pour ajouter une indication pertinente lorsque le champ est vide.
// Le 'focusNode' est passé au TextFormField pour gérer le focus et les interactions du champ.
// Le widget est utilisé pour créer un champ de saisie personnalisé avec des options de personnalisation pour améliorer l'interface utilisateur de l'application.

import 'package:flutter/material.dart';

class WhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? hintText;// Add the 'focusNode' parameter here

  const WhiteTextField({
    Key? key,
    required this.controller,
    required this.isFieldFocused,
    required this.labelText,
    required this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.focusNode,
    this.hintText,// Include the 'focusNode' parameter in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode, // Pass the 'focusNode' to TextFormField
        onTap: () {
          // ...
        },
        validator: validator,
        decoration: InputDecoration(
          labelText: isFieldFocused ? null : labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          // ...
        ),
      ),
    );
  }
}


/*
// MISE A JOUR LE 22/07/2023
import 'package:flutter/material.dart';

class WhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? hintText;// Add the 'focusNode' parameter here

  const WhiteTextField({
    Key? key,
    required this.controller,
    required this.isFieldFocused,
    required this.labelText,
    required this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.focusNode,
    this.hintText,// Include the 'focusNode' parameter in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode, // Pass the 'focusNode' to TextFormField
        onTap: () {
          // ...
        },
        validator: validator,
        decoration: InputDecoration(
          labelText: isFieldFocused ? null : labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          // ...
        ),
      ),
    );
  }
}

 */