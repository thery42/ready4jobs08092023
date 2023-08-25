import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';


import 'package:ready4jobs/widgets/constants.dart';

import 'package:ready4jobs/models/profile_model.dart';
import 'package:ready4jobs/models/profile_provider.dart';

import 'package:ready4jobs/widgets/profil/circle_avatar_widget.dart';



class ProfilePreviewWidget extends StatelessWidget {

  Widget _buildProfileAvatar(ProfileModel profile, double radius) {
    if (profile.profilePhoto != null) {
      return CircleAvatarWidget(
        radius: radius,
        imageProvider: FileImage(File(profile.profilePhoto!)),
      );
    } else {
      return CircleAvatar(
        radius: radius,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final profile = profileProvider.profile;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profil');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileAvatar(profile, 40),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Poste recherché',
                    style: kProfileTitleTextStyle(context),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Description du profil',
                    style: kProfileDescriptionTextStyle(context),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: kProfileDescriptionTextStyle(context),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: kAppBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: kProfileShadowColor.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
