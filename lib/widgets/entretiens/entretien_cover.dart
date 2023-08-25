import 'package:flutter/material.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_constants.dart';
import 'package:ready4jobs/widgets/entretiens/Entretiens_popupMenu.dart';

class EntretienCover extends StatelessWidget {
  final String? title;
  final DateTime? timestamp;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final int number;
  final String imageUrl;

  EntretienCover({
    required this.number,
    this.title,
    this.timestamp,
    this.onTap,
    this.height,
    this.width,
    required this.imageUrl,
  }) {
    print('EntretienCover imageUrl: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: kEntretienCoverBackgroundColor,
          borderRadius: BorderRadius.circular(kEntretienCoverBorderRadius),
        ),
        margin: kEntretienCoverMargin,
        padding: kEntretienCoverPadding,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Entretien n° $number.',
                      style: TextStyle(
                        fontSize: kEntretienCoverTitleFontSize, color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  Flexible(
                    child: Text(
                      '${timestamp?.toLocal() ?? ''}',
                      style: TextStyle(fontSize: kEntretienCoverTimestampFontSize,color: Colors.white,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 0,
              child: EntretienPopupMenu(
                onItemSelected: (value) {
                  print('Selected menu item: $value');
                },
                imageUrl: imageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
