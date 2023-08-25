import 'package:flutter/material.dart';
import '../constants.dart';

class WelcomeDescription extends StatelessWidget {
  const WelcomeDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Votre expérience, Votre entreprise cible, Notre technologie',
      style: kWelcomeButtonTextStyle.copyWith(
        fontFamily: 'Abhaya Libre',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// WelcomeDescription est un widget qui affiche une description de bienvenue.
// La description est définie comme un texte statique.
// Le style du texte est configuré en utilisant la constante kWelcomeButtonTextStyle, mais avec des modifications supplémentaires.
// La police de caractères est définie sur 'Abhaya Libre' et le poids du texte est en gras (FontWeight.bold).
// Ce widget est utilisé pour afficher une courte description captivante dans la page de bienvenue de l'application.