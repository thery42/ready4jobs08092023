// Ce widget est utilisé pour saisir et confirmer un mot de passe lors de l'inscription.
// Il s'agit d'un champ de texte personnalisé (WhiteTextField) avec la possibilité de masquer le mot de passe.
// Le widget reçoit un TextEditingController pour gérer les saisies, un booléen pour indiquer si le champ est en focus,
// et une fonction de validation pour vérifier si la confirmation du mot de passe correspond au mot de passe principal.
// Lorsque l'utilisateur entre un mot de passe, la fonction de validation compare le mot de passe principal
// avec la confirmation du mot de passe et affiche un message d'erreur en cas de non-correspondance.
// L'icône de suffixe permet de basculer l'affichage du mot de passe entre masqué et visible.


import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  const ConfirmPasswordFormField({
    Key? key,
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  }) : super(key: key);

  @override
  ConfirmPasswordFormFieldState createState() => ConfirmPasswordFormFieldState();
}

class ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  late bool _obscureText;
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    // Appel dispose sur les FocusNode lorsque vous avez terminé
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteTextField(
      controller: widget.controller,
      focusNode: _confirmPasswordFocusNode,
      isFieldFocused: widget.isFieldFocused,
      labelText: widget.isFieldFocused ? null : 'Confirmez le mot de passe',
      validator: (value) {
        final password = widget.controller.text;
        final confirmPassword = value ?? '';

        if (confirmPassword.isEmpty) {
          return 'Veuillez confirmer le mot de passe';
        }

        if (password != confirmPassword) {
          return 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
        }

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

class ConfirmPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  const ConfirmPasswordFormField({
    Key? key,
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  }) : super(key: key);

  @override
  ConfirmPasswordFormFieldState createState() => ConfirmPasswordFormFieldState();
}

class ConfirmPasswordFormFieldState extends State<ConfirmPasswordFormField> {
  late bool _obscureText;
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    // Appel dispose sur les FocusNode lorsque vous avez terminé
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteTextField(
      controller: widget.controller,
      focusNode: _confirmPasswordFocusNode,
      isFieldFocused: widget.isFieldFocused,
      labelText: widget.isFieldFocused ? null : 'Confirmez le mot de passe',
      validator: (value) {
        final password = widget.controller.text;
        final confirmPassword = value ?? '';

        if (confirmPassword.isEmpty) {
          return 'Veuillez confirmer le mot de passe';
        }

        if (password != confirmPassword) {
          return 'Le mot de passe et la confirmation du mot de passe ne correspondent pas';
        }

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