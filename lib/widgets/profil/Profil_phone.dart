import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class PhoneInputWidget extends StatelessWidget {
  final TextEditingController controller;

  PhoneInputWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: PHONE_TEXT_COLOR,
        fontSize: PHONE_TEXT_FONT_SIZE,
      ),
      decoration: InputDecoration(
        labelText: PHONE_TITLE_TEXT,
        labelStyle: TextStyle(
          fontSize: PHONE_TITLE_FONT_SIZE,
          color: PHONE_TITLE_COLOR,
        ),
        hintText: 'Entrez votre numéro de téléphone',
        hintStyle: TextStyle(
          color: PHONE_TEXT_COLOR,
          fontSize: PHONE_TEXT_FONT_SIZE,
        ),
        suffixIcon: Icon(
          PHONE_TRAILING_ICON,
          size: PHONE_TRAILING_ICON_SIZE,
          color: PHONE_TRAILING_ICON_COLOR,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer un numéro de téléphone';
        }
        return null;
      },
    );
  }
}
