import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';
import 'package:ready4jobs/widgets/bottom_navigation_bar_widget.dart';


class AppScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final Color backgroundColor;
  final Widget? drawer;
  final FloatingActionButton? floatingActionButton;
  final CustomAppBar? appBar; // Changer CustomAppBar en CustomAppBar?
  final BottomNavigationBarWidget? bottomNavigationBar; // Changer BottomNavigationBarWidget en BottomNavigationBarWidget?

  const AppScaffold({
    Key? key,

    required this.body,
    this.padding = const EdgeInsets.all(16.0),
    this.useSafeArea = true,
    this.backgroundColor = kAppBackgroundColor,
    this.drawer,
    this.floatingActionButton,
    this.appBar, // Changer required en facultatif (?)
    this.bottomNavigationBar, // Changer required en facultatif (?)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: padding,
              child: body,
            ),
          ),
        );
      },
    );

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      appBar: appBar, // Utiliser CustomAppBar ici
      backgroundColor: backgroundColor,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      body: content,
      bottomNavigationBar: bottomNavigationBar, // Utiliser BottomNavigationBarWidget ici
    );
  }
}

// AppScaffold est un widget personnalisé qui crée une structure de base pour la mise en page de l'application.
// Il enveloppe le widget `body` fourni à l'intérieur d'un Scaffold avec des styles communs.
// Le contenu est affiché dans une zone sécurisée (SafeArea) pour éviter les chevauchements avec les encoches des appareils et les barres système.
// Il ajoute un espacement autour du contenu en utilisant un padding de 16 pixels sur tous les côtés.
// La couleur d'arrière-plan du scaffold est définie en utilisant une constante définie dans `constants.dart`.
