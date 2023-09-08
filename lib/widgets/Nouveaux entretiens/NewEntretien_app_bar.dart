import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';

class NewEntretiensCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  NewEntretiensCustomAppBar({required this.title, this.actions});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kAppBarBackgroundColor, // Couleur de l'appbar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Couleur de l'ombre
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Position de l'ombre
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Fond transparent pour montrer l'ombre
        elevation: 0, // Pas d'élévation pour l'appbar réelle
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: kAppBarTitleFontSize,
            fontWeight: kAppBarTitleFontWeight,
          ),
        ),
        actions: actions,
      ),
    );
  }
}
