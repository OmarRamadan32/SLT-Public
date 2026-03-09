import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card.dart';
import 'package:new_slt/core/widgets/cards/past_event_card.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class CampaignSectionLoadingView extends StatelessWidget {
  const CampaignSectionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SkeletonLoadingView(
          card: TitleWidget(title: "الحملات", subtitle: "--"),
          cardsCount: 1,
        ),
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
        SkeletonLoadingView(
          card: Container(
            alignment: Alignment.center,
            height: 160.h,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: const PastEventCard(
                    cardImage: "",
                    cardTitle: "المجلس الاخير",
                  ),
                );
              },
            ),
          ),
          cardsCount: 1,
        ),
      ],
    );
  }
}
