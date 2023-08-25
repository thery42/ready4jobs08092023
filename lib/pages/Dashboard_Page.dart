import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ready4jobs/widgets/app_scaffold.dart';
import 'package:ready4jobs/widgets/custom_app_bar.dart';

import 'package:ready4jobs/models/profile_provider.dart';

import 'package:ready4jobs/widgets/dashboard/profile_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/cv_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/entretien_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/astuces_preview_widget.dart';
import 'package:ready4jobs/widgets/dashboard/offre_preview_widget.dart';

import 'package:ready4jobs/pages/AAAA_Test.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
      builder: (context, child) {

        return AppScaffold(
          appBar: CustomAppBar(title: 'Dashboard'),
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xFF08245A),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*
                  SizedBox(height: 12),
                  ProfilePreviewWidget(),
                  */
                  SizedBox(height: 132.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Column(
                                children: [
                                  CvPreviewWidget(),
                                  Container(
                                    margin: EdgeInsets.only(top: 6),
                                    child: EntretienPreviewWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: ForumPreviewWidget(), // You didn't provide the import for this widget
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: OffrePreviewWidget(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12), // Add space below the content
/*
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AAAtest()),
                      );
                    },
                    child: Text('Go to AAAtest Page'),
                  ),
                  */
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
