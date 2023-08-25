import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/Forum/Forum_constants.dart';
import 'package:ready4jobs/widgets/Forum/Forum_app_bar.dart';
import 'package:ready4jobs/widgets/Forum/Forum_bottom_bar.dart';

class ForumAppScaffold extends StatelessWidget {
  final Widget body;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final Color backgroundColor;
  final ForumCustomAppBar? forumCustomAppBar;
  final BottomNavigationBarWidget? forumBottomNavigationBarItemInfo;

  const ForumAppScaffold({
    Key? key,
    required this.body,
    this.padding = const EdgeInsets.all(16.0),
    this.useSafeArea = true,
    this.backgroundColor = kAppBackgroundColor,
    this.forumCustomAppBar,
    this.forumBottomNavigationBarItemInfo, // Utilisez appBar ici
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
      appBar: forumCustomAppBar,
      bottomNavigationBar: forumBottomNavigationBarItemInfo,// Utilisez appBar ici
      backgroundColor: backgroundColor,
      body: content,
    );
  }
}
