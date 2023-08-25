// Ce widget est utilisé pour afficher un indicateur de progression circulaire (CircularProgressIndicator) pendant qu'une opération asynchrone future est en cours d'exécution.
// Le widget prend deux paramètres : 'future' qui est la future opération asynchrone à exécuter et 'message' qui est un widget optionnel pour afficher un message supplémentaire pendant l'attente.
// Pendant que l'opération future est en cours d'exécution (ConnectionState.waiting), le widget affiche un indicateur de progression circulaire centré, éventuellement accompagné du message.
// Si une erreur se produit pendant l'exécution de l'opération future (snapshot.hasError), le widget affiche un message "An error occurred." au centre de l'écran.
// Une fois que l'opération future est terminée (snapshot.connectionState != ConnectionState.waiting), le widget renvoie un conteneur vide, ce qui signifie qu'aucun indicateur de progression n'est affiché.
// Ce widget est utile pour montrer visuellement le chargement ou l'attente d'une opération asynchrone future dans l'interface utilisateur, avec la possibilité d'ajouter un message personnalisé.



// Importation du package Flutter pour les éléments d'interface utilisateur.
import 'package:flutter/material.dart';

// Widget qui affiche un indicateur de progression pendant l'exécution d'une opération Future.
class FutureProgressDialogWidget extends StatelessWidget {

  // Déclaration des propriétés du widget.
  final Future Function() future;                  // La tâche future à exécuter.
  final Widget? completedWidget;                   // Widget à afficher après la complétion du Future.
  final Widget? initialWidget;                     // Widget à afficher avant que le Future ne commence.
  final CircularProgressIndicator? loadingIndicator;  // Widget d'indicateur de chargement.
  final Function(dynamic error)? onError;           // Callback pour gérer les erreurs.

  // Constructeur pour initialiser les propriétés.
  FutureProgressDialogWidget({
    required this.future,
    this.completedWidget,
    this.loadingIndicator,
    this.onError,
    this.initialWidget,
  });

  // Méthode build qui définit l'apparence du widget.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {

          // Avant le démarrage du Future, afficher `initialWidget` ou un conteneur vide.
          return initialWidget ?? Container();
        } else if (snapshot.connectionState == ConnectionState.waiting) {

          // Pendant l'exécution du Future, afficher l'indicateur de chargement.
          return Center(
            child: loadingIndicator ?? CircularProgressIndicator(),
          );

        } else if (snapshot.hasError) {

          // En cas d'erreur, exécuter le callback `onError` s'il existe.
          onError?.call(snapshot.error);

          // Et retourner un conteneur vide.
          return Container();
        } else {

          // Après la complétion du Future, afficher `completedWidget` ou un conteneur vide.
          return completedWidget ?? Container();
        }
      },
    );
  }
}

