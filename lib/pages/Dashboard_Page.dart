import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ready4jobs/widgets/app_scaffold.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';

import 'package:ready4jobs/models/profile_provider.dart';

import 'package:ready4jobs/widgets/dashboard/cv_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/entretien_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/offre_preview_widget.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
      builder: (context, child) {
        return AppScaffold(
          appBar: CustomAppBar(title: 'Dashboard'),
          body: Container(
            color: Color(0xFF08245A),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aligner en haut
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: CvPreviewWidget(),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: EntretienPreviewWidget(),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: OffrePreviewWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
