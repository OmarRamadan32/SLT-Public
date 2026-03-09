import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class CouncilsSectionLoadingView extends StatelessWidget {
  const CouncilsSectionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Spaces.inSectionSpace20,
          const SkeletonLoadingView(
            card: HalfImageCard(
              cardTitle: "المجلس الاخير",
              cardImage: "",
              cardLeaderOneName: "عمر رمضان",
              cardLeaderTwoName: "مش عمر رمضان",
            ),
            cardsCount: 1,
          ),
          Spaces.inSectionSpace20,
          const SkeletonLoadingView(
            card: TitleWidget(title: "المجالس السابقة"),
            cardsCount: 1,
          ),
          SkeletonLoadingView(
            cardsCount: 5,
            card: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color:
                      Theme.of(
                        context,
                      ).bottomNavigationBarTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, top: 10.h),
                        child: ArabicTextWidget(
                          text: "ق/ عمر رمضان",
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
                            text: "مش عمر رمضان",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
