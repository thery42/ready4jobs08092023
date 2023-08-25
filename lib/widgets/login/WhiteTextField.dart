

/*
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
  final String? hintText;

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
    this.hintText,
  }) : super(key: key) {
    print("WhiteTextField a été créé");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onTap: () {
          print("TextFormField a été tapé");
        },
        validator: (value) {
          if (validator != null) {
            String? validationResult = validator!(value);
            print("Résultat de la validation : $validationResult");
            return validationResult;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: isFieldFocused ? null : labelText,
          hintText: hintText,
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