// Ce widget est utilisé pour saisir un mot de passe lors de l'inscription.
// Il s'agit d'un champ de texte personnalisé (WhiteTextField) spécifique au mot de passe,
// avec la possibilité de masquer le mot de passe.
// Le widget reçoit un TextEditingController pour gérer les saisies, un booléen pour indiquer si le champ est en focus,
// et une fonction de validation personnalisée pour vérifier si le mot de passe saisi est valide.
// Le widget effectue plusieurs vérifications sur le mot de passe saisi, telles que la longueur minimale,
// la présence de lettres majuscules, de lettres minuscules, de chiffres et de caractères spéciaux.
// Si le mot de passe ne passe pas l'une de ces vérifications, une erreur de validation est affichée.
// Si la valeur du champ est valide, la méthode de validation renvoie 'null', indiquant qu'il n'y a pas d'erreur de validation.
// L'icône de suffixe permet de basculer l'affichage du mot de passe entre masqué et visible.
// Cette classe est utile pour valider et sécuriser la saisie de mots de passe lors de l'inscription des utilisateurs.


import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  PasswordFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // Appel dispose sur les FocusNode lorsque vous avez terminé
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteTextField(
      controller: widget.controller,
      focusNode: _passwordFocusNode,
      isFieldFocused: widget.isFieldFocused,
      labelText: widget.isFieldFocused ? null : 'Mot de passe',
      validator: (value) {
        final password = value ?? '';

        if (password.isEmpty) {
          return 'Veuillez entrer un mot de passe';
        }

        if (password.length < 8) {
          return 'Le mot de passe doit comporter au moins 8 caractères';
        }

        final uppercaseLetters = RegExp(r'[A-Z]');
        if (!uppercaseLetters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins une lettre majuscule';
        }

        final lowercaseLetters = RegExp(r'[a-z]');
        if (!lowercaseLetters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins une lettre minuscule';
        }

        final digits = RegExp(r'[0-9]');
        if (!digits.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins un chiffre';
        }

        final specialCharacters = RegExp(r'[!@#$%^&*]');
        if (!specialCharacters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins un des caractères spéciaux suivants : !@#\$%^&*';
        }

        // Le mot de passe est valide
        return widget.validator?.call(value);
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}



/*
// MISE A JOUR LE 22/07/2023
import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  PasswordFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // Appel dispose sur les FocusNode lorsque vous avez terminé
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteTextField(
      controller: widget.controller,
      focusNode: _passwordFocusNode,
      isFieldFocused: widget.isFieldFocused,
      labelText: widget.isFieldFocused ? null : 'Mot de passe',
      validator: (value) {
        final password = value ?? '';

        if (password.isEmpty) {
          return 'Veuillez entrer un mot de passe';
        }

        if (password.length < 8) {
          return 'Le mot de passe doit comporter au moins 8 caractères';
        }

        final uppercaseLetters = RegExp(r'[A-Z]');
        if (!uppercaseLetters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins une lettre majuscule';
        }

        final lowercaseLetters = RegExp(r'[a-z]');
        if (!lowercaseLetters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins une lettre minuscule';
        }

        final digits = RegExp(r'[0-9]');
        if (!digits.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins un chiffre';
        }

        final specialCharacters = RegExp(r'[!@#$%^&*]');
        if (!specialCharacters.hasMatch(password)) {
          return 'Le mot de passe doit contenir au moins un des caractères spéciaux suivants : !@#\$%^&*';
        }

        // Le mot de passe est valide
        return widget.validator?.call(value);
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
 */