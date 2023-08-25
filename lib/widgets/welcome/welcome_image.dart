import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: 300,
        height: 200,
        child: Image.asset('images/Bienvenue.png', fit: BoxFit.cover),
      ),
    );
  }
}

// WelcomeImage est un widget qui affiche une image de bienvenue.
// L'image est chargée à partir des ressources locales en utilisant Image.asset et le chemin d'accès à l'image est 'images/Bienvenue.png'.
// L'image est affichée dans un conteneur avec une largeur de 300 et une hauteur de 200.
// Pour obtenir une apparence esthétique, les bords du conteneur sont arrondis en utilisant ClipRRect avec un rayon de bordure de 30.0.
// Le mode de dimensionnement de l'image est défini sur BoxFit.cover pour s'assurer qu'elle couvre entièrement le conteneur sans déformation.
// Ce widget est utilisé pour afficher une image visuellement attrayante dans la page de bienvenue de l'application.