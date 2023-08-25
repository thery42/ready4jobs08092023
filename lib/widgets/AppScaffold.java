/*import 'package:flutter/material.dart';
import 'constants.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar; // AppBar optionnelle
  final Widget? bottomNavigationBar; // BottomNavigationBar optionnelle

  const AppScaffold({
    Key? key,
    required this.body,
    this.appBar, // initialisée par défaut à null
    this.bottomNavigationBar, // initialisée par défaut à null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: appBar, // Utilisée si elle n'est pas null
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: body,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar, // Utilisée si elle n'est pas null
    );
  }
}

 */