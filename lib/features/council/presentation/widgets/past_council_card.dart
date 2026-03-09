import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class PastCouncilCard extends StatelessWidget {
  const PastCouncilCard({
    super.key,
    required this.cardTitle,
    required this.cardImageUrl,
    required this.cardLeaderName,
  });
  final String cardTitle;
  final String cardImageUrl;
  final String cardLeaderName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            opacity: 0.25,
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(cardImageUrl),
          ),
          color: Colors.black,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, top: 10.h),
                child: ArabicTextWidget(
                  text: "ق/ $cardLeaderName",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, bottom: 5.h),
                  child: ArabicTextWidget(
                    text: cardTitle,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
