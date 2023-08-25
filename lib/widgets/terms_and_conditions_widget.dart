// Importations des packages nécessaires pour le fonctionnement du widget.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ready4jobs/pages/TermsAndConditionsPage.dart';

// Définition du widget Stateless `TermsAndConditionsWidget`.
class TermsAndConditionsWidget extends StatefulWidget {


  // Constructeur du widget avec deux paramètres obligatoires : acceptedTerms et onChanged.
  const TermsAndConditionsWidget({
    Key? key,
    required this.acceptedTerms,
    required this.onChanged,
  }) : super(key: key);

  final bool? acceptedTerms;  // Indique si les CGU sont acceptées.
  final ValueChanged<bool?>? onChanged;  // Fonction de rappel pour le changement d'état de la case.

  // Création de l'état associé à ce widget.
  @override
  _TermsAndConditionsWidgetState createState() =>
      _TermsAndConditionsWidgetState();
}

// État du widget `TermsAndConditionsWidget`.
class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {


  // Méthode build pour définir l'aspect visuel et le comportement du widget.
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      // Utilisation d'un RichText pour combiner des textes normaux et des liens.
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'J\'accepte les ',
              style: TextStyle(color: Colors.white),
            ),
            TextSpan(

              // Création d'un lien cliquable pour les CGU.
              text: 'Conditions Générales d\'Utilisation',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {

                // Action lors du clic sur le lien : navigation vers la page des CGU.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
                  );
                },
            ),
          ],
        ),
      ),
      value: widget.acceptedTerms,  // Valeur initiale de la case (cochée ou non).
      onChanged: (value) {


        // Mise à jour de la valeur de la case et appel du callback.
        final newValue = value ?? false;
        widget.onChanged?.call(newValue);
      },
      controlAffinity: ListTileControlAffinity.leading,  // Position de la case à cocher avant le texte.
    );
  }
}
