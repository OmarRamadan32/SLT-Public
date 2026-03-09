import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';

class HighlightCard extends StatelessWidget {
  const HighlightCard({super.key, required this.highlightModel});
  final HighlightModel highlightModel;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: GestureDetector(
        onTap: ()async{
          if(highlightModel.actionLink != null){
            Helpers.launchURL(highlightModel.actionLink!);
          }
        },
        child: Container(
          height: 125.h,
          width: double.infinity,
          decoration: BoxDecoration(color: theme.primaryColor),
          child: Row(
            children: [
              // Image
              Expanded(
                child: SizedBox(
                  height: 125.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(100.r, 100.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: highlightModel.image,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) => Icon(Icons.error, size: 0.sp),
                    ),
                  ),
                ),
              ),
        
              // Texts
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spaces.space5,
                      if (highlightModel.title != null)
                        Expanded(
                          flex: highlightModel.remainingDays != null ? 2 : 1,
                          child: Align(
                            alignment:
                                highlightModel.content == null &&
                                        highlightModel.remainingDays == null
                                    ? Alignment.center
                                    : Alignment.bottomCenter,
        
                            child: Text(
                              highlightModel.title!,
                              maxLines: 3,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontFamily: Constants.appNameFont,
                                fontSize:
                                    theme.textTheme.bodyLarge!.fontSize! + 6,
                              ),
                            ),
                          ),
                        ),
                      if (highlightModel.content != null)
                        Expanded(
                          flex: highlightModel.remainingDays != null ? 2 : 1,
                          child: Opacity(
                            opacity: 0.80,
                            child: Align(
                              alignment:
                                  highlightModel.title == null &&
                                          highlightModel.remainingDays == null
                                      ? Alignment.center
                                      : highlightModel.title == null
                                      ? Alignment.bottomCenter
                                      : Alignment.topCenter,
                              child: ArabicTextWidget(
                                textAlign: TextAlign.center,
                                maxLines: 10,
                                text: highlightModel.content!,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (highlightModel.remainingDays != null)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 5),
                            child: Align(
                              alignment:
                                  highlightModel.content == null &&
                                          highlightModel.title == null
                                      ? Alignment.center
                                      : Alignment.bottomRight,
                              child: ArabicTextWidget(
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                text:
                                    "عدد الأيام المتبقية : ${highlightModel.remainingDays}",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.white,
                                  fontSize:
                                      highlightModel.content == null &&
                                              highlightModel.title == null
                                          ? theme.textTheme.bodyMedium!.fontSize
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
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
