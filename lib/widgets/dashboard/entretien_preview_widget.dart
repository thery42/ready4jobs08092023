import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/dashboard/dashboard_constants.dart';

class EntretienPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kOriginalEntretienButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kEntretienBorderRadius),
              side: kEntretienBorderSide,
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(1)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/entretiens');
        },
        child: Center(  // Ajout du widget Center
          child: Text(
            'Entretiens',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kEntretienFontFamily,
              fontSize: kEntretienFontSize,
              color: kEntretienTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
