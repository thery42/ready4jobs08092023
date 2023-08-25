import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/welcome/welcome_content.dart';
import 'package:ready4jobs/widgets/app_scaffold.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: const WelcomeContent(),
      useSafeArea: false, // Vous pouvez également désactiver la SafeArea ici, si nécessaire.
    );
  }
}



/*
AppScaffold(
  body: const HomePageContent(),
  appBar: const CustomAppBar(),
  bottomNavigationBar: const CustomBottomNavigationBar(),
)
""Si je veux intégrer dans app et bottom bar dans une des pages""
 */