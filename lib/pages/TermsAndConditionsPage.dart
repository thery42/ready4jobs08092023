import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';
import 'package:ready4jobs/widgets/signup/cgu_widget.dart';
import 'package:ready4jobs/widgets/app_scaffold.dart';

// Placez ici la définition de votre CustomAppBar

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(
        title: 'Conditions Générales d\'Utilisation',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CGUWidget(),
          ],
        ),
      ),
      backgroundColor: kAppBackgroundColor, // Utilisez la constante importée
    );
  }
}
