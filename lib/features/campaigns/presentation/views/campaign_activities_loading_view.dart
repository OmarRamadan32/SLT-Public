import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/campaign_activities_page_details_section.dart';

class CampaignActivitiesLoadingView extends StatelessWidget {
  const CampaignActivitiesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SkeletonLoadingView(
      cardsCount: 1,
      card: Column(
        children: [
          Spaces.screenLastItemSpace70,
          Spaces.screenLastItemSpace70,
          SizedBox(
            width: 200.w,
            child: Divider(color: theme.primaryColor, thickness: 1.3),
          ),
          const CampaignActivitiesPageDetailsSection(
            activitiesCount: 2,
            campaignLeaderOne: "-------------",
            campaignLeaderTwo: "--------",
          ),
          Spaces.sectionsSpace40,
          Column(
            children: [
              Spaces.sectionsSpace40,
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: theme.bottomNavigationBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: ArabicTextWidget(
                        text: "----------------",
                        maxLines: 1,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
