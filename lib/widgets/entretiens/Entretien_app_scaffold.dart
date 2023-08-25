import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_app_bar.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_bottom_bar.dart';

class EntretienAppScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final Color backgroundColor;
  final EntretiensCustomAppBar? entretiensCustomAppBar;
  final BottomNavigationBarWidget? EntretiensBottomNavigationBarItemInfo;

  const EntretienAppScaffold({
    Key? key,
    required this.body,
    this.padding = const EdgeInsets.all(16.0),
    this.useSafeArea = true,
    this.backgroundColor = kAppBackgroundColor,
    this.entretiensCustomAppBar,
    this.EntretiensBottomNavigationBarItemInfo, // Utilisez appBar ici
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: body,
    );

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      appBar: entretiensCustomAppBar,
      bottomNavigationBar:EntretiensBottomNavigationBarItemInfo ,// Utilisez appBar ici
      backgroundColor: backgroundColor,
      body: content,
    );
  }
}
