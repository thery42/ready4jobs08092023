import 'package:flutter/material.dart';
import 'package:another_dashed_container/another_dashed_container.dart';
import 'dart:ui';

// Fonction pour obtenir la largeur de l'écran
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// Fonction pour obtenir la hauteur de l'écran
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Valeurs constantes pour certaines couleurs
const kAppBackgroundColor = Color(0xFF08245A);
const kWelcomeButtonColor = Color(0xFF04CAE9);
const kProfileShadowColor = Colors.black;

// Styles de texte commun pour l'application
const kWelcomeButtonTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 12,
  color: Colors.white,
);

const kWelcomeButtonBlackTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 12,
  color: Colors.black,
);

const kTitleTextStyle = TextStyle(
  fontFamily: 'Inter',
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// Fonction pour créer un bouton personnalisé
Widget buildCustomButton(BuildContext context, Function chooseCVAndUpload) {
  double desiredWidth = screenWidth(context) * 0.9; // 20% de la largeur de l'écran
  double desiredHeight = screenHeight(context) * 0.08; // 10% de la hauteur de l'écran

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(7),
        bottom: Radius.circular(7),
      ),
    ),
    child: DashedContainer(
      dashedLength: 8.0,
      blankLength: 4.0,
      strokeWidth: 1.0,
      dashColor: Colors.white70,
      child: SizedBox(
        width: desiredWidth,
        height: desiredHeight,
        child: ElevatedButton(
          onPressed: () => chooseCVAndUpload(),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5),
                bottom: Radius.circular(5),
              ),
            ),
            primary: Colors.transparent,
          ),
          child: Center(
            child: Icon(
              Icons.add_sharp,
              size: 26, // Ajuster cette valeur aussi si nécessaire
              color: Colors.white70,
            ),
          ),
        ),
      ),
    ),
  );
}



// =================== MessageInput Constants ===================

// Pour le Container
const double kMessageInputPadding = 10.0;

// Pour le TextField
const String kMessageInputHintText = 'Tapez votre message ici...';
const double kMessageInputBorderRadius = 10.0;
const Color kMessageInputBackgroundColor = Colors.white;

// Autres constantes pour MessageInput peuvent être ajoutées ici au besoin

// ===============================================================



// =================== Message Bubble ===================
const kAppMessageBubbleColor = Color(0xFF5DE6E5);
const kUserMessageBubbleColor = Color(0xFF0869A5);
const kMessageBubbleRadius = 20.0;  // Adjust as needed
// ===============================================================




// =================== Boutton terminé ===================
const kEndButtonPadding = EdgeInsets.all(10.0);
const kEndButtonColor = Color(0xFF04CAE9);
const kEndButtonText = 'Terminer';
const kEndButtonTextColor = Colors.black;
const kEndButtonBorderRadius = BorderRadius.all(Radius.circular(8.0));
// ===============================================================



// =================== Page de garde apercu ===================
const double kEntretienCoverWidthFactor = 0.00;
const double kEntretienCoverHeightFactor = 0.12;
const Color kEntretienCoverBackgroundColor = Color(0xFF0869A5);
const double kEntretienCoverBorderRadius = 10;
const EdgeInsets kEntretienCoverMargin = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const EdgeInsets kEntretienCoverPadding = EdgeInsets.all(16);
const double kEntretienCoverTitleFontSize = 20.0;
const double kEntretienCoverTimestampFontSize = 12.0;
// ===============================================================


// =================== AppBar ===================
const Color kAppBarBackgroundColor = Color(0xFF08245A);
const double kAppBarTitleFontSize = 18.0;
const FontWeight kAppBarTitleFontWeight = FontWeight.bold;
const double kAppBarElevation = 0.3;

// ===============================================================