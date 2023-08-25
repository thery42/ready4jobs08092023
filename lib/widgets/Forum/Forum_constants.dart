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
  double desiredWidth = screenWidth(context) * 0.9;
  double desiredHeight = screenHeight(context) * 0.08;

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



// =================== AppBar ====================================
const Color kAppBarBackgroundColor = Color(0xFF08245A);
const double kAppBarTitleFontSize = 18.0;
const FontWeight kAppBarTitleFontWeight = FontWeight.bold;
const double kAppBarElevation = 0.3;
// ===============================================================




// =================== Profil Picture =============================
// Pour CircleAvatar
const double kAvatarRadius = 50.0;

// Pour Container quand il est vide
const double kEmptyContainerWidth = 100.0;
const double kEmptyContainerHeight = 100.0;
const Color kEmptyContainerColor = Color(0xFF04CAE9);

// Pour l'icône de l'appareil photo
const EdgeInsets kIconPadding = EdgeInsets.all(8.0);
const Color kIconColor = Colors.white;
const double kIconSize = 24.0;
// ===============================================================





// =================== Profil name ===============================
const TextAlign NAME_INPUT_TEXT_ALIGN = TextAlign.center;

// Decoration du texte pour le widget de nom
const TextStyle NAME_INPUT_TEXT_STYLE = TextStyle(
  fontSize: 24, color : Colors.white,
  fontWeight: FontWeight.bold,
);
// Decoration de saisie pour le widget de nom
const InputDecoration NAME_INPUT_DECORATION = InputDecoration(
  hintText: "Entrez votre nom",
  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  border: InputBorder.none,
);
// ===============================================================





// =================== Profil Descritpion =============================

const TextAlign DESCRIPTION_INPUT_TEXT_ALIGN = TextAlign.left;

const TextStyle DESCRIPTION_INPUT_TEXT_STYLE = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const InputDecoration DESCRIPTION_INPUT_DECORATION = InputDecoration(
  hintText: "Description",
  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  border: InputBorder.none,
);

const EdgeInsets DESCRIPTION_CONTAINER_PADDING = EdgeInsets.all(10.0);
const double DESCRIPTION_CONTAINER_BORDER_RADIUS = 5.0; // const for border radius value

// ===============================================================





// =================== Profil Email =============================
// Texte
const EMAIL_TEXT_COLOR = Colors.white;
const EMAIL_TEXT_FONT_SIZE = 16.0;

// Le titre
const EMAIL_TITLE_TEXT = 'Email';
const EMAIL_TITLE_FONT_SIZE = 16.0;
const EMAIL_TITLE_COLOR = Colors.white;

// L'icon
const EMAIL_TRAILING_ICON = Icons.edit;
const EMAIL_TRAILING_ICON_SIZE = 24.0;
const EMAIL_TRAILING_ICON_COLOR = Colors.white;
// ===============================================================



// =================== Profil phone =============================
// Texte
const PHONE_TEXT_COLOR = Colors.white;
const PHONE_TEXT_FONT_SIZE = 16.0;

// Le titre
const PHONE_TITLE_TEXT = 'Telephone';
const PHONE_TITLE_FONT_SIZE = 16.0;
const PHONE_TITLE_COLOR = Colors.white;

// L'icon
const PHONE_TRAILING_ICON = Icons.edit;
const PHONE_TRAILING_ICON_SIZE = 24.0;
const PHONE_TRAILING_ICON_COLOR = Colors.white;
// ===============================================================



// =================== Profil Adress =============================
// Texte
const ADDRESS_TEXT_COLOR = Colors.white;
const ADDRESS_TEXT_FONT_SIZE = 16.0;

// Le titre
const ADDRESS_TITLE_TEXT = 'Adresse';
const ADDRESS_TITLE_FONT_SIZE = 16.0;
const ADDRESS_TITLE_COLOR = Colors.white;

// L'icon
const ADDRESS_TRAILING_ICON = Icons.edit;
const ADDRESS_TRAILING_ICON_SIZE = 24.0;
const ADDRESS_TRAILING_ICON_COLOR = Colors.white;
// ===============================================================


// =================== Profil Boutton deconnexion ================
const double kButtonHeight = 16.0;
const double kButtonBorderRadius = 8.0;
const Color kButtonColor = Color(0xFF04CAE9);
const Color kButtonTextColor = Colors.white;
// ===============================================================


// =================== Profil Boutton de suppression ==================
const double kDeleteButtonHeight = 16.0;
const double kDeleteButtonBorderRadius = 8.0;
const Color kDeleteButtonColor = Color(0xFFFF4F4F);
const Color kDeleteButtonTextColor = Colors.white;
// =====================================================================


// =================== Profil Boutton de Contact ==================
const double kContactButtonHeight = 16.0;
const double kContactButtonBorderRadius = 8.0;
const Color kContactButtonColor = Color(0xFF0869A5);
const Color kContactButtonTextColor = Colors.white;
// ===================================================================


// =================== Profil Secteur d'activité  ==================
const Color dropdownTextColor = Colors.black;
const double dropdownTextSize = 16.0;
// ===================================================================
