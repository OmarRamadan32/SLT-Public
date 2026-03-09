import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/campaign_activity_card.dart';

class CampaignActivitiesPageActivitiesSection extends StatelessWidget {
  const CampaignActivitiesPageActivitiesSection({
    super.key,
    required this.campaignId,
  });
  final String campaignId;

  @override
  Widget build(BuildContext context) {
    CampaignCubit campaignCubit = context.read<CampaignCubit>();
    return Column(
      children: [
        const TitleWidget(title: "انشطة الحملة", isCentered: true),
        Spaces.sectionsSpace40,
        campaignCubit.activities.isEmpty
            ? const EmptyViewWidget(
              message: "لا توجد أي انشطة",
              isCentered: true,
            )
            : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: campaignCubit.activities.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.3,
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.pushReplacement(
                      '${AppRouter.kActivityPage}/$campaignId/${campaignCubit.activities[index].id}',
                    );
                  },
                  child: CampaignActivityCard(
                    cardImage: campaignCubit.activities[index].activityImage,
                    cardTitle: campaignCubit.activities[index].activityName,
                  ),
                );
              },
            ),
      ],
    );
  }
}
