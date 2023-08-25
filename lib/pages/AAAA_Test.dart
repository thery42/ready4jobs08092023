  import 'package:flutter/material.dart';
  import 'package:ready4jobs/widgets/app_scaffold.dart';
  import 'package:ready4jobs/widgets/custom_app_bar.dart';
  import 'package:ready4jobs/widgets/bottom_navigation_bar_widget.dart';

  class AAAtest extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      print('Building EntretiensPage');

      return AppScaffold(
        appBar: CustomAppBar(title: 'Dashboard'),
        bottomNavigationBar: BottomNavigationBarWidget(),
        body: Placeholder(), // Replace this with the desired content
      );
    }
  }