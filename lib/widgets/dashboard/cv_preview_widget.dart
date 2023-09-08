import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/dashboard/dashboard_constants.dart';

class CvPreviewWidget extends StatelessWidget {
  const CvPreviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kCvButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kCvButtonBorderRadius),
              side: kCvButtonBorderSide,
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 80)),
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(1)), // Ajout de l'ombre
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/cv');
        },
        child: Center(
          child: Text(
            'CV',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kCvButtonFontFamily,
              fontSize: kCvButtonFontSize,
              color: kCvTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
