import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class NameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  NameInputWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: NAME_INPUT_TEXT_ALIGN,
      style: NAME_INPUT_TEXT_STYLE,
      decoration: NAME_INPUT_DECORATION,
    );
  }
}