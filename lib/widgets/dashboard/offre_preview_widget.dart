import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/dashboard/dashboard_constants.dart';

class OffrePreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 4),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kOffreButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kOffreBorderRadius),
              side: kOffreBorderSide,
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 80)),
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(1)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/profil');
        },
        child: Center(  // Ajout du widget Center
          child: Text(
            'Profil',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kOffreFontFamily,
              fontSize: kOffreFontSize,
              color: kOffreTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
