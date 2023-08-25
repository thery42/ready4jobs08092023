import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/welcome/welcome_text.dart';
import 'package:ready4jobs/widgets/welcome/welcome_image.dart';
import 'package:ready4jobs/widgets/welcome/welcome_description.dart';
import 'package:ready4jobs/widgets/welcome/welcome_buttons.dart';
import '../constants.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 57),
        const WelcomeText(),
        const SizedBox(height: 40),
        const WelcomeImage(),
        const SizedBox(height: 10),
        const WelcomeDescription(),
        const SizedBox(height: 110),
        const WelcomeButtons(), // changé à 'WelcomeButtons'
        const SizedBox(height: 10),
      ],
    );
  }
}

// WelcomeContent est un widget qui affiche le contenu de bienvenue de l'application.
// Il est composé de plusieurs widgets personnalisés importés depuis d'autres fichiers, notamment WelcomeText, WelcomeImage, WelcomeDescription et WelcomeButtons.
// Les widgets sont disposés dans une colonne pour les empiler verticalement.
// Des espaces vides (SizedBox) sont utilisés pour ajuster la mise en page et créer des espacements entre les éléments.
// Le contenu comprend le texte de bienvenue, une image d'accueil, une description et des boutons de bienvenue.
// Chaque widget a son propre fichier et est réutilisé ici pour créer la mise en page globale de la page de bienvenue de l'application.