    import 'package:flutter/material.dart';


    // Widget réutilisable représentant un cercle avec une image (avatar).
    class CircleAvatarWidget extends StatelessWidget {
      final double radius;
      final ImageProvider? imageProvider;

      CircleAvatarWidget({required this.radius, required this.imageProvider});

      @override
      Widget build(BuildContext context) {
        if (imageProvider != null) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
          );
        } else {
          // Return an empty Container
          return Container();
        }
      }
    }
