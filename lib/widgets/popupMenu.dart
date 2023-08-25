// Import des packages et des widgets personnalisés nécessaires
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:ready4jobs/widgets/cv/NouvelEntretienPopupMenuEntry.dart';
import 'package:ready4jobs/widgets/cv/PartagerPopupMenuEntry.dart';
import 'package:ready4jobs/widgets/cv/SupprimerPopupMenuEntry.dart';
import 'package:ready4jobs/widgets/cv/TelechargerPopupMenuEntry.dart';

import 'package:ready4jobs/pages/New_Interviews.dart';

// Classe représentant le menu contextuel
class PopupMenu extends StatelessWidget {
  final void Function(int) onItemSelected;
  final String downloadUrl;

  // Constructeur prenant deux paramètres : onItemSelected et downloadUrl
  PopupMenu({required this.onItemSelected, required this.downloadUrl});

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

            // Si la valeur correspond à celle de NouvelEntretienPopupMenuEntry
            if (value == 0) {
              try {
                if (Navigator.canPop(context)) {
                  print("Navigator can pop");
                } else {
                  print("Navigator cannot pop");
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ),
                );
              } catch (e, stackTrace) {
                print("An error occurred during navigation: $e");
                print("Stack trace: $stackTrace");
              }
            }

            // ... autres logiques pour d'autres valeurs si nécessaire ...

            // Appelle la fonction onItemSelected passée en paramètre avec la valeur sélectionnée
            onItemSelected(value);
          },
          color: kPopupMenuBackgroundColor.withOpacity(0.8),
          elevation: 100.0,
          icon: Icon(Icons.more_vert, color: kPopupMenuPointsColor),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            NouvelEntretienPopupMenuEntry(),
            PartagerPopupMenuEntry(),
            SupprimerPopupMenuEntry(downloadUrl: downloadUrl),
            TelechargerPopupMenuEntry(),
          ],
        ),
      ),
    );
  }
}
