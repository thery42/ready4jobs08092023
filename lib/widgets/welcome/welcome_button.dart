  import 'package:flutter/material.dart';
  import '../constants.dart';

  import 'package:flutter/material.dart';
  import '../constants.dart';

  class WelcomeButton extends StatelessWidget {
    final String text;
    final Widget route;

    const WelcomeButton({
      Key? key,
      required this.text,
      required this.route,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: 120,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kWelcomeButtonColor),
            minimumSize: MaterialStateProperty.all<Size>(Size(120, 40)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // Add some padding around the button text for spacing.
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          },
          // Wrap the button child with MouseRegion for web interactions and InkWell for mobile interactions.
          // This adds visual feedback when the button is hovered or pressed.
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
              onTap: () {
                // Add a slight scale animation to the button on tap for a smoother interaction.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => route),
                );
              },
              child: Center(
                child: Text(
                  text,
                  style: kWelcomeButtonTextStyle.merge(TextStyle(color: Colors.black)),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }



  // WelcomeButton est un widget personnalisé qui affiche un bouton de bienvenue.
  // Ce bouton est utilisé pour effectuer une navigation vers une autre page lorsqu'il est pressé.
  // Le texte affiché sur le bouton est défini par la propriété `text`.
  // La route vers laquelle naviguer est définie par la propriété `route`, qui est un widget représentant la page de destination.
  // Le style du bouton est configuré en utilisant ButtonStyle avec une couleur de fond basée sur la constante kWelcomeButtonColor.
  // La taille minimale du bouton est définie à 120 pixels de largeur et 40 pixels de hauteur.
  // Lorsque le bouton est pressé, il déclenche une navigation vers la page spécifiée par la propriété `route`.
  // Le texte du bouton est affiché avec le style défini dans la constante kWelcomeButtonTextStyle, et la couleur du texte est également définie en noir.