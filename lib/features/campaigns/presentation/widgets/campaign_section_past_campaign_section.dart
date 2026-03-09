import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/cards/past_event_card.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';

class CampaignSectionPastCampaignSection extends StatelessWidget {
  const CampaignSectionPastCampaignSection({
    super.key,
    required this.eventName,
  });
  final String eventName;

  @override
  Widget build(BuildContext context) {
    CampaignCubit campaignCubit = context.read<CampaignCubit>();
    return Container(
      alignment: Alignment.center,
      height: 160.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            campaignCubit.campaigns
                .where((element) => element.campaignName == eventName)
                .length,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          CampaignModel campaignModel =
              campaignCubit.campaigns
                  .where((element) => element.campaignName == eventName)
                  .toList()[index];
          return GestureDetector(
            onTap: () {
              context.push(AppRouter.kCampaignActivitiesPage,
              extra: campaignModel);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: PastEventCard(
                cardImage: campaignModel.campaignImage,
                cardTitle:
                    "${campaignModel.campaignName} ${campaignModel.campaignNumber}",
              ),
            ),
          );
        },
      ),
    );
  }
}
