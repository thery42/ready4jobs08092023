import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/pages/New_Interviews.dart';

class NouvelEntretienPopupMenuEntry extends PopupMenuEntry<int> {
  @override
  double get height => 48;

  @override
  bool represents(int? value) => value == 0;

  @override
  _NouvelEntretienPopupMenuEntryState createState() =>
      _NouvelEntretienPopupMenuEntryState();
}

class _NouvelEntretienPopupMenuEntryState extends State<NouvelEntretienPopupMenuEntry> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      value: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.6,
            ),
          ),
        ),
        child: Text(
          "Créer un nouvel entretien",
          style: TextStyle(color: kPopupMenuPointsColor),
        ),
      ),
    );
  }
}
