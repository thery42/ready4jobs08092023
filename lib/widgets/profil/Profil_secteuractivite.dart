import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/profil/Profil_constants.dart';

class SectorDropdown extends StatefulWidget {
  @override
  _SectorDropdownState createState() => _SectorDropdownState();
}

class _SectorDropdownState extends State<SectorDropdown> {
  String? _selectedSector;
  final List<String> _sectors = [
    'Informatique',
    'Finance',
    'Santé',
    'Éducation',
    'Transport',
    // Ajoutez d'autres secteurs ici...
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSector = null; // Réinitialise la sélection
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _selectedSector != null
                  ? 'Secteur d\'activité recherché : $_selectedSector'
                  : 'Choisir un secteur d\'activité',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (_selectedSector == null)
          DropdownButton<String>(
            value: _selectedSector,
            onChanged: (String? newValue) {
              setState(() {
                _selectedSector = newValue;
              });
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
          ),
      ],
    );
  }
}
