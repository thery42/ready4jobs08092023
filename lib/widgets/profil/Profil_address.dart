import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class AddressInputWidget extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController postalCodeController;
  final TextEditingController cityController;

  AddressInputWidget({
    required this.addressController,
    required this.postalCodeController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: addressController,
          keyboardType: TextInputType.streetAddress,
          style: TextStyle(
            color: ADDRESS_TEXT_COLOR,
            fontSize: ADDRESS_TEXT_FONT_SIZE,
          ),
          decoration: InputDecoration(
            labelText: ADDRESS_TITLE_TEXT,
            labelStyle: TextStyle(
              fontSize: ADDRESS_TITLE_FONT_SIZE,
              color: ADDRESS_TITLE_COLOR,
            ),
            hintText: 'Adresse postale',
            hintStyle: TextStyle(
              color: ADDRESS_TEXT_COLOR,
              fontSize: ADDRESS_TEXT_FONT_SIZE,
            ),
            suffixIcon: Icon(
              ADDRESS_TRAILING_ICON,
              size: ADDRESS_TRAILING_ICON_SIZE,
              color: ADDRESS_TRAILING_ICON_COLOR,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer une adresse postale';
            }
            return null;
          },
        ),
        SizedBox(height: 16), // Espacement entre les champs
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: postalCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Accepter uniquement les chiffres
                style: TextStyle(
                  color: ADDRESS_TEXT_COLOR,
                  fontSize: ADDRESS_TEXT_FONT_SIZE,
                ),
                decoration: InputDecoration(
                  labelText: 'Code Postal',
                  labelStyle: TextStyle(
                    fontSize: ADDRESS_TITLE_FONT_SIZE,
                    color: ADDRESS_TITLE_COLOR,
                  ),
                  hintText: 'Code postal',
                  hintStyle: TextStyle(
                    color: ADDRESS_TEXT_COLOR,
                    fontSize: ADDRESS_TEXT_FONT_SIZE,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un code postal';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 16), // Espacement entre les champs
            Expanded(
              flex: 3,
              child: TextFormField(
                controller: cityController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: ADDRESS_TEXT_COLOR,
                  fontSize: ADDRESS_TEXT_FONT_SIZE,
                ),
                decoration: InputDecoration(
                  labelText: 'Ville',
                  labelStyle: TextStyle(
                    fontSize: ADDRESS_TITLE_FONT_SIZE,
                    color: ADDRESS_TITLE_COLOR,
                  ),
                  hintText: 'Ville',
                  hintStyle: TextStyle(
                    color: ADDRESS_TEXT_COLOR,
                    fontSize: ADDRESS_TEXT_FONT_SIZE,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une ville';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
