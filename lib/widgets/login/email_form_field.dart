import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class LoginEmailFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  LoginEmailFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  _LoginEmailFormFieldState createState() => _LoginEmailFormFieldState();
}

class _LoginEmailFormFieldState extends State<LoginEmailFormField> {
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Construction du widget LoginEmailFormField");
    return Semantics(
      // Ajout d'une étiquette sémantique pour les lecteurs d'écran
      label: 'Email de connexion',
      child: WhiteTextField(
        controller: widget.controller,
        focusNode: _emailFocusNode,
        isFieldFocused: widget.isFieldFocused,
        labelText: widget.isFieldFocused ? null : 'Email de connexion',
        hintText: 'Entrez votre email de connexion', // Ajout d'une indication pertinente pour le champ
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
      return 'Veuillez entrer un email de connexion';
    } else if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un email de connexion valide';
    } else {
      return null;
    }
  }
}
