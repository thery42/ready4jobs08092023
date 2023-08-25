// Import des packages et des widgets personnalisés nécessaires
import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/entretiens/EntretiensPartagerPopupMenuEntry.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_SupprimerPopupMenuEntry.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_TelechargerPopupMenuEntry.dart';

import 'package:ready4jobs/pages/New_Interviews.dart';

// Classe représentant le menu contextuel
class EntretienPopupMenu extends StatelessWidget {
  final void Function(int) onItemSelected;
  final String imageUrl;

  // Constructeur prenant deux paramètres : onItemSelected et imageUrl
  EntretienPopupMenu({required this.onItemSelected, required this.imageUrl}) {
    print("ImageUrl in EntretienPopupMenu: $imageUrl");  // Ajout de l'instruction print
  }

  @override
  Widget build(BuildContext context) {
    // Construction du widget Container qui contient le menu contextuel
    return Container(
      // Définition du style du conteneur avec une couleur de fond et un rayon de bordure
      decoration: BoxDecoration(
        color: kPopupMenuBackgroundColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      // Utilisation du widget Theme pour personnaliser le style du menu contextuel
      child: Theme(
        data: Theme.of(context).copyWith(
          popupMenuTheme: kCustomPopupMenuTheme,
        ),
        // Construction du menu contextuel avec PopupMenuButton
        child: PopupMenuButton<int>(
          padding: EdgeInsets.zero,
          iconSize: 24.0,
          // Callback appelée lorsque l'utilisateur sélectionne une option du menu
          onSelected: (value) {
            print('Selected value: $value');

            // ... autres logiques pour d'autres valeurs si nécessaire ...

            // Appelle la fonction onItemSelected passée en paramètre avec la valeur sélectionnée
            onItemSelected(value);
          },
          color: kPopupMenuBackgroundColor.withOpacity(0.8),
          elevation: 100.0,
          icon: Icon(Icons.more_vert, color: kPopupMenuPointsColor),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            EntretiensPartagerPopupMenuEntry(),
            EntretiensSupprimerPopupMenuEntry(imageUrl: imageUrl),
            EntretiensTelechargerPopupMenuEntry(),
          ],
        ),
      ),
    );
  }
}
