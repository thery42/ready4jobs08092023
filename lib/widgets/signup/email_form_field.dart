// Ce widget est utilisé pour saisir une adresse e-mail lors de l'inscription.
// Il s'agit d'un champ de texte personnalisé (WhiteTextField) spécifique à l'e-mail,
// avec la possibilité d'afficher une indication pertinente ("Entrez votre email") lorsque le champ est vide.
// Le widget reçoit un TextEditingController pour gérer les saisies, un booléen pour indiquer si le champ est en focus,
// et une fonction de validation personnalisée pour vérifier si l'e-mail saisi est valide.
// Si aucune fonction de validation n'est fournie, le widget utilise une validation par défaut pour vérifier
// que l'e-mail a un format valide en utilisant une expression régulière.
// Le widget ajoute également une étiquette sémantique pour les lecteurs d'écran afin d'améliorer l'accessibilité.


import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  EmailFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  EmailFormFieldState createState() => EmailFormFieldState();
}

class EmailFormFieldState extends State<EmailFormField> {
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Ajout d'une étiquette sémantique pour les lecteurs d'écran
      label: 'Email',
      child: WhiteTextField(
        controller: widget.controller,
        focusNode: _emailFocusNode,
        isFieldFocused: widget.isFieldFocused,
        labelText: widget.isFieldFocused ? null : 'Email',
        hintText: 'Entrez votre email', // Ajout d'une indication pertinente pour le champ
        validator: widget.validator ?? emailValidator,
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
      ),
    );
  }

  String? emailValidator(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un email';
    } else if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    } else {
      return null;
    }
  }
}




/*
// MISE A JOUR LE 22/07/2023
import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class EmailFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  EmailFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  EmailFormFieldState createState() => EmailFormFieldState();
}

class EmailFormFieldState extends State<EmailFormField> {
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Ajout d'une étiquette sémantique pour les lecteurs d'écran
      label: 'Email',
      child: WhiteTextField(
        controller: widget.controller,
        focusNode: _emailFocusNode,
        isFieldFocused: widget.isFieldFocused,
        labelText: widget.isFieldFocused ? null : 'Email',
        hintText: 'Entrez votre email', // Ajout d'une indication pertinente pour le champ
        validator: widget.validator ?? emailValidator,
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
      ),
    );
  }

  String? emailValidator(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un email';
    } else if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    } else {
      return null;
    }
  }
}

 */