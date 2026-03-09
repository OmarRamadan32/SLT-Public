import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/cards/full_image_card/full_image_card_image.dart';
import 'package:new_slt/core/widgets/cards/full_image_card/full_image_card_details.dart';

class FullImageCard extends StatelessWidget {
  const FullImageCard({super.key, required this.cardTitle, required this.cardImage, required this.cardLeaderOne, required this.cardLeaderTwo});
  final String cardTitle;
  final String cardImage;
  final String cardLeaderOne;
  final String cardLeaderTwo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child:  AspectRatio(
        aspectRatio: 1 / 0.36,
        child: Stack(
          alignment: Alignment.center,
          children: [FullImageCardImage(
            cardImage: cardImage,
          ), FullImageCardDetails(
            cardTitle: cardTitle,
            cardLeaderOne: cardLeaderOne,
            cardLeaderTwo: cardLeaderTwo,
          )],
        ),
      ),
    );
  }
}
