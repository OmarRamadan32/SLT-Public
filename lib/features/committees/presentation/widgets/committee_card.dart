import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_card_details.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_card_image.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_card_shadow.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_card_title.dart';

class CommitteeCard extends StatelessWidget {
  const CommitteeCard({super.key, required this.committeeModel});
  final CommitteeModel committeeModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CommitteeCardImage(imageUrl: committeeModel.committeeImage),
              const CommitteeCardShadow(),
              CommitteeCardDetails(
                committeeLeaderName:
                    committeeModel.committeeLeaderName ?? 'لا يوجد إسم',
                committeeMembersCount: committeeModel.committeeMembers!.length,
              ),
            ],
          ),
        ),
        CommitteeCardTitle(committeeName: committeeModel.committeeName),
        Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
          width: 200.w,
          child: ArabicTextWidget(
            maxLines: 2,
            text: committeeModel.committeeDescription,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: Colors.white54),
          ),
        ),
      ],
    );
  }
}
