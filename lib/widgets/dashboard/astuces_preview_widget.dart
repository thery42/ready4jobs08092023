import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/dashboard/dashboard_constants.dart';

class ForumPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kAstuceButtonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kAstuceBorderRadius),
              side: kAstuceBorderSide,
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 130)),
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black.withOpacity(1)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/forum');
        },
        child: Center(  // Ajout du widget Center
          child: Text(
            'Forum',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: kAstuceFontFamily,
              fontSize: kAstuceFontSize,
              color: kAstuceTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
