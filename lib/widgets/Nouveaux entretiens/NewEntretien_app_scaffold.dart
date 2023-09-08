import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/constants.dart';
import 'package:ready4jobs/widgets/Nouveaux entretiens/NewEntretien_app_bar.dart';

class NewEntretienAppScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final Color backgroundColor;
  final NewEntretiensCustomAppBar? newEntretiensCustomAppBar;

  const NewEntretienAppScaffold({
    Key? key,
    required this.body,
    this.padding = const EdgeInsets.all(16.0),
    this.useSafeArea = true,
    this.backgroundColor = kAppBackgroundColor,
    this.newEntretiensCustomAppBar,
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
      appBar: newEntretiensCustomAppBar,
      backgroundColor: backgroundColor,
      body: content,
    );
  }
}
