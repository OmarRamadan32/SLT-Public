import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class PastEventCard extends StatelessWidget {
  const PastEventCard({
    super.key,
    required this.cardTitle,
    required this.cardImage,
  });
  final String cardTitle;
  final String cardImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13),
      child: AspectRatio(
        aspectRatio: 1 / 1.25,
        child: Container(
          decoration: BoxDecoration(
            // boxShadow: [Styles.cardsBoxShadow],
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(cardImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: ArabicTextWidget(
                    text: cardTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
