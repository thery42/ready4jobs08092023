import 'package:flutter/material.dart';
import '../constants.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenue sur Ready4Jobs',
      style: kWelcomeButtonTextStyle.copyWith(
        fontSize: 48,
      ),
    );
  }
}

// WelcomeText est un widget qui affiche le texte de bienvenue.
// Le texte affiché est "Bienvenue sur Ready4Jobs".
// Le style du texte est configuré en utilisant la constante kWelcomeButtonTextStyle, mais avec une modification supplémentaire.
// La taille de la police est définie sur 48 pixels (fontSize: 48) pour obtenir une taille de texte plus grande.
// Ce widget est utilisé pour afficher un message de bienvenue accrocheur dans la page de bienvenue de l'application.