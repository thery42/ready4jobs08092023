import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/profil/Profil_app_bar.dart';
import 'package:ready4jobs/widgets/profil/Profil_bottom_bar.dart';

class ProfilAppScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final Color backgroundColor;
  final ProfilCustomAppBar? profilCustomAppBar;
  final BottomNavigationBarWidget? profilBottomNavigationBarItemInfo;

  const ProfilAppScaffold({
    Key? key,
    required this.body,
    this.padding = const EdgeInsets.all(16.0),
    this.useSafeArea = true,
    this.backgroundColor = kAppBackgroundColor,
    this.profilCustomAppBar,
    this.profilBottomNavigationBarItemInfo, // Utilisez appBar ici
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
      appBar: profilCustomAppBar,
      bottomNavigationBar: profilBottomNavigationBarItemInfo,// Utilisez appBar ici
      backgroundColor: backgroundColor,
      body: content,
    );
  }
}
