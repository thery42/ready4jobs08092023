import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/signup/whiteTextField.dart';

class LoginPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  LoginPasswordFormField({
    required this.controller,
    required this.isFieldFocused,
    required this.validator,
  });

  @override
  LoginPasswordFormFieldState createState() => LoginPasswordFormFieldState();
}

class LoginPasswordFormFieldState extends State<LoginPasswordFormField> {
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
          return 'Veuillez entrer votre mot de passe';
        }

        // Vous pouvez ajouter d'autres vérifications spécifiques pour la page de login si nécessaire

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
