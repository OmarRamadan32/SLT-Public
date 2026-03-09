import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class TeamLeadersBoardCard extends StatelessWidget {
  const TeamLeadersBoardCard({
    super.key,
    this.leaderName,
    this.leaderTitle,
    this.leaderImage,
  });

  final String? leaderName;
  final String? leaderTitle;
  final String? leaderImage;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (leaderTitle != null && leaderName != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 125.h,
          width: double.infinity,
          decoration: BoxDecoration(color: theme.primaryColor),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(100.r, 100.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: leaderImage!,
                    fit: BoxFit.cover,
                    errorWidget:
                        (context, url, error) => Icon(Icons.error, size: 0.sp),
                  ),
                ),
              ),

              // Text
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: ArabicTextWidget(
                          text: leaderTitle!,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! + 7.sp,
                          ),
                        ),
                      ),
                      ArabicTextWidget(
                        text: leaderName!,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(height: 100.h, width: 100.w);
    }
  }
}
