import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButton extends StatelessWidget {
  const ContactButton();

  // Méthode pour lancer l'application de messagerie
  _launchEmail() async {
    const emailUrl = "mailto:Ready4Jobs@outlook.fr";
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 1; // You can adjust this factor
    double buttonHeight = screenHeight * 0.06; // You can adjust this factor

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          print("Button Pressed");
          _launchEmail();
        },

        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kContactButtonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kContactButtonBorderRadius),
            ),
          ),
        ),
        child: Text(
          'Nous contacter',
          style: TextStyle(
            color: kContactButtonTextColor,
          ),
        ),
      ),
    );
  }
}
