import 'package:flutter/material.dart';

class SettingToggleWidget extends StatefulWidget {
  final Function onToggle;
  final bool isExpanded;

  SettingToggleWidget({required this.onToggle, required this.isExpanded});

  @override
  _SettingToggleWidgetState createState() => _SettingToggleWidgetState();
}

class _SettingToggleWidgetState extends State<SettingToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            'Paramètres',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              widget.onToggle();
            },
            child: Text(
              widget.isExpanded ? '-' : '+',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}


class CoordinatesToggleWidget extends StatefulWidget {
  final Function onToggle;
  final bool isExpanded;

  CoordinatesToggleWidget({required this.onToggle, required this.isExpanded});

  @override
  _CoordinatesToggleWidgetState createState() => _CoordinatesToggleWidgetState();
}
class _CoordinatesToggleWidgetState extends State<CoordinatesToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            'Coordonnées',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              widget.onToggle();
            },
            child: Text(
              widget.isExpanded ? '-' : '+',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}




class RechercheToggleWidget extends StatefulWidget {
  final Function onToggle;
  final bool isExpanded;

  RechercheToggleWidget({required this.onToggle, required this.isExpanded});

  @override
  _RechercheToggleWidgetState createState() => _RechercheToggleWidgetState();
}
class _RechercheToggleWidgetState extends State<RechercheToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            'Profil Professionel',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              widget.onToggle();
            },
            child: Text(
              widget.isExpanded ? '-' : '+',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}