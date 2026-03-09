import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/views/campaign_section_loading_view.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/campaign_section_past_campaign_section.dart';

class CampaignSection extends StatelessWidget {
  const CampaignSection({
    super.key,
    required this.campaignName,
    required this.campaignDescription,
  });

  final String campaignName;
  final String campaignDescription;

  @override
  Widget build(BuildContext context) {
    CampaignCubit campaignCubit = context.read<CampaignCubit>();
    return BlocBuilder<CampaignCubit, CampaignState>(
      builder: (context, state) {
        if (state is CampaignLoadingState) {
          return const CampaignSectionLoadingView();
        } else if (state is CampaignErrorState) {
          return ErrorMessageWidget(isCentered: true, message: state.message);
        } else {
          CampaignModel? currentCampaign =
              campaignCubit.campaigns
                  .where(
                    (element) =>
                        element.isCurrent == true &&
                        element.campaignName == campaignName,
                  )
                  .first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Spaces.space10,
              GestureDetector(
                onTap: () {
                  context.push(
                    AppRouter.kCampaignActivitiesPage,
                    extra: currentCampaign,
                  );
                },
                child: HalfImageCard(
                  cardImage: currentCampaign.campaignImage,
                  cardLeaderOneName: currentCampaign.campaignLeaderName,
                  cardLeaderTwoName:
                      currentCampaign.campaignLeaderTwoName ?? "---",
                  cardTitle:
                      "${currentCampaign.campaignName} ${currentCampaign.campaignNumber}",
                ),
              ),
              Spaces.inSectionSpace20,
              CampaignSectionPastCampaignSection(eventName: campaignName),
              Spaces.inSectionSpace20,
              DetailsBoxWidget(content: campaignDescription),
            ],
          );
        }
      },
    );
  }
}
