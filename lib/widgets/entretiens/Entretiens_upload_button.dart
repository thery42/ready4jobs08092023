import 'package:flutter/material.dart';
import 'package:ready4jobs/pages/New_Interviews.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';

class NavigationToEntretiensButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildCustomButton(context, () => _navigateToChatPage(context));
 // Renommez la méthode pour qu'elle soit plus claire
  }

  void _navigateToChatPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
  }

}
