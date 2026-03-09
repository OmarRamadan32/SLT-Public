import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/styles.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CampaignActivityCard extends StatelessWidget {
  const CampaignActivityCard({
    super.key,
    required this.cardImage,
    required this.cardTitle,
  });
  final String cardImage;
  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [Styles.cardsBoxShadow],
      ),
      width: MediaQuery.of(context).size.width / 2.5,
      // ---------------- child -------------
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.7,
              child: SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: cardImage,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Opacity(
                        opacity: 0.5,
                        child: Image.asset(Assets.sltLogo, fit: BoxFit.cover),
                      ),
                  errorWidget:
                      (context, url, error) => const Icon(Icons.error, size: 0),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: const Color.fromARGB(85, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),

              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ArabicTextWidget(
                  text: cardTitle,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
