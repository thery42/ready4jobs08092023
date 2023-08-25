import 'package:flutter/material.dart';
import 'package:another_dashed_container/another_dashed_container.dart';

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

// Nouveaux styles de texte pour le profil
TextStyle kProfileTitleTextStyle(BuildContext context) => TextStyle(
  fontFamily: 'Inter',
  fontSize: screenWidth(context) * 0.06, // Ajuste la taille en fonction de la largeur de l'écran
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle kProfileDescriptionTextStyle(BuildContext context) => TextStyle(
  fontFamily: 'Inter',
  fontSize: screenWidth(context) * 0.04, // Ajuste la taille en fonction de la largeur de l'écran
  color: Colors.white,
);

// Fonction pour créer un bouton personnalisé
Widget buildCustomButton(BuildContext context, Function chooseCVAndUpload) {
  double desiredWidth = screenWidth(context) * 0.2; // 20% de la largeur de l'écran
  double desiredHeight = screenHeight(context) * 0.1; // 10% de la hauteur de l'écran

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

// Couleurs pour le widget PopupMenu
const kPopupMenuBackgroundColor = Color(0xFF0869A5);
const kPopupMenuPointsColor = Colors.black;

// Définir un thème personnalisé pour PopupMenu
final kCustomPopupMenuTheme = PopupMenuThemeData(
  color: kPopupMenuBackgroundColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
    side: BorderSide(
      color: Colors.black,
      width: 1.6,
    ),
  ),
);
