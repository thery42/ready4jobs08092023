import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';
import 'package:ready4jobs/widgets/profil/Profil_stream_builder.dart';

Future<void> saveSelectedSectorMetier(String userId, String selectedSector) async {
  try {
    // Saving the selected job to Firebase
    await FirebaseFirestore.instance
        .collection('metier')
        .doc(userId)
        .set({'selectedSector': selectedSector});
    print('Métier sauvegardé sur Firebase : $selectedSector');
  } catch (e) {
    print('Erreur lors de la sauvegarde sur Firebase : $e');
  }
}

class MetierDropdown extends StatefulWidget {
  final Function(String)? onMetierSelected;

  MetierDropdown({this.onMetierSelected});

  @override
  _MetierDropdownState createState() => _MetierDropdownState();
}

class _MetierDropdownState extends State<MetierDropdown> {
  bool _isEditing = false; // flag to determine if user is editing the métier

  @override
  Widget build(BuildContext context) {
    return MetierStreamBuilder(
      buildBodyFunction: (BuildContext context, String selectedSector) {
        if (selectedSector.isNotEmpty && !_isEditing) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true; // Set flag to true when text is tapped
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Métier recherché : $selectedSector',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          );
        } else {
          return DropdownMenu(
            onMetierSelected: (newSector) {
              setState(() {
                _isEditing = false; // Reset the flag when a new métier is selected
              });
              widget.onMetierSelected?.call(newSector);
            },
            saveSelectedSectorMetier: saveSelectedSectorMetier,
          );
        }
      },
    );
  }
}


class DropdownMenu extends StatefulWidget {
  final Function(String)? onMetierSelected;
  final Future<void> Function(String userId, String selectedSector) saveSelectedSectorMetier;

  DropdownMenu({this.onMetierSelected, required this.saveSelectedSectorMetier});

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  final List<String> _sectors = [
    'Serveur',
    'Coiffeur',
    'Développeur',
    'Enseignant',
    'Chauffeur',
    // Add more sectors here...
  ];

  String? _selectedSector;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedSector,
      onChanged: (String? newValue) async {
        setState(() {
          _selectedSector = newValue;
        });

        if (_selectedSector != null) {
          try {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              await widget.saveSelectedSectorMetier(user.uid, _selectedSector!);
              widget.onMetierSelected?.call(_selectedSector!);
              print('Métier sauvegardé pour l\'utilisateur ${user.uid}: $_selectedSector');
            } else {
              print('Utilisateur non authentifié.');
            }
          } catch (e) {
            print('Erreur lors de la sauvegarde : $e');
          }
        }
      },
      items: _sectors.map<DropdownMenuItem<String>>((String value) {
        bool isSelected = value == _selectedSector;
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: isSelected ? Colors.white : dropdownTextColor,
              fontSize: dropdownTextSize,
            ),
          ),
        );
      }).toList(),
    );
  }
}
