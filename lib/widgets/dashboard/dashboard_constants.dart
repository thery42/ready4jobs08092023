import 'package:flutter/material.dart';
import 'dart:ui';

Color addTint(Color color, double amount) {
  return Color.lerp(color, Colors.white, amount)!;
}




// =================== Profil Boutton  Cv ==================
const kCvButtonColor = Color(0xFF0389A7);
const kCvButtonFontFamily = 'Inter';
const kCvButtonFontSize = 20.0;
const kCvTextColor = Colors.white;

const double kCvButtonBorderRadius = 20.0;
const kCvButtonBorderSide = BorderSide(color: Colors.black, width: 1.0);
// ===================================================================




// =================== Profil Boutton Forum ==================
const kAstuceButtonColor = Color(0xFF0389A7);
const kAstuceFontFamily = 'Inter';
const kAstuceFontSize = 20.0;
const kAstuceTextColor = Colors.white70;

const double kAstuceBorderRadius = 20.0;
const kAstuceBorderSide = BorderSide(color: Colors.black, width: 1.0);
// ===================================================================




// =================== Profil Boutton Entretiens ==================
const kOriginalEntretienButtonColor = Color(0xFF0389A7);
final kEntretienButtonColor = addTint(kOriginalEntretienButtonColor, 0.8);

const kEntretienFontFamily = 'Inter';
const kEntretienFontSize = 20.0;
const kEntretienTextColor = Colors.white;
const double kEntretienBorderRadius = 20.0;
const kEntretienBorderSide = BorderSide(color: Colors.black, width: 1.0);
// ===================================================================




// =================== Profil Boutton Profil ==================
const kOffreButtonColor = Color(0xFF0389A7);
const kOffreFontFamily = 'Inter';
const kOffreFontSize = 20.0;
const kOffreTextColor = Colors.white;

const double kOffreBorderRadius = 20.0;
const kOffreBorderSide = BorderSide(color: Colors.black, width: 1.0);
// ===================================================================



// =================== Profil Ombres ==================
class DashboardConstants {
  static const Color transparentBlack = Color(0x66000000);
  static const BorderRadius circularBorderRadius = BorderRadius.all(Radius.circular(20));

  static const BoxDecoration ContainerDecoration = BoxDecoration(
    color: Colors.transparent,
    boxShadow: [
      BoxShadow(
        color: transparentBlack,
        spreadRadius: 2,
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    borderRadius: circularBorderRadius,
  );
}
// ===================================================================


