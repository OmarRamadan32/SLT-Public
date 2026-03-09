import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card_details.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card_image.dart';

class HalfImageCard extends StatelessWidget {
  const HalfImageCard({
    super.key,
    required this.cardTitle,
    required this.cardImage,
    required this.cardLeaderOneName,
    required this.cardLeaderTwoName,
  });
  final String cardTitle;
  final String cardImage;
  final String cardLeaderOneName;
  final String cardLeaderTwoName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        // boxShadow: [Styles.cardsBoxShadow],
      ),
      child: AspectRatio(
        aspectRatio: 0.81 / 0.32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HalfImageCardImage(image: cardImage),
            HalfImageCardDetails(
              campaignLeaderOneName: cardLeaderOneName,
              campaignLeaderTwoName: cardLeaderTwoName,
              campaignTitle: cardTitle,
            ),
          ],
        ),
      ),
    );
  }
}
