import 'package:flutter/material.dart';

// Voici un widget pour afficher des messages d'erreur à l'utilisateur.
class ErrorMessage extends StatelessWidget {
  // Ce sont les éléments dont on a besoin pour construire notre widget.
  final String message;          // Le message d'erreur à afficher.
  final TextStyle? style;        // Comment le texte doit-il ressembler? Si on ne spécifie rien, il aura un design par défaut.
  final Duration? animationDuration; // Combien de temps l'animation doit-elle durer? Si on ne spécifie rien, ce sera 300 millisecondes.


  ErrorMessage({
    required this.message,
    this.style,
    this.animationDuration,
  });

  // La méthode 'build' décrit à quoi le widget ressemble et comment il se comporte.
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(

      // Si on n'a pas spécifié de durée pour l'animation, elle durera 300 millisecondes.
      duration: animationDuration ?? Duration(milliseconds: 300),

      // C'est l'animation elle-même - un simple effet de fondu.
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(child: child, opacity: animation);
      },

      // Si le message d'erreur n'est pas vide, affiche-le.
      child: message.isNotEmpty
          ? Padding(

        // Un peu d'espace au-dessus du message pour qu'il ne touche pas les autres éléments de l'interface.
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(

          // Le texte affiché est notre message d'erreur.
          message,

          // Si on n'a pas choisi de style pour le texte, il sera rouge et d'une taille de 14.
          style: style ?? TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
          // Le texte est centré.
          textAlign: TextAlign.center,
        ),
      )

      // Si le message est vide, n'affiche rien du tout.
          : SizedBox.shrink(),
    );
  }
}

