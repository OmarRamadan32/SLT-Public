import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';

class CampaignsAdminPage extends StatefulWidget {
  const CampaignsAdminPage({super.key});

  @override
  State<CampaignsAdminPage> createState() => _CampaignsAdminPageState();
}

class _CampaignsAdminPageState extends State<CampaignsAdminPage> {
  @override
  void initState() {
    context.read<CampaignDashbaordCubit>().getAllCampaigns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "الحملات",
      child: Column(
        children: [
          DashboardSecCard(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.solidMoon,
            onTap: () {
              context.read<CampaignDashbaordCubit>().resetState();
              (context).pushReplacement(AppRouter.kAddCampaignAdminPage);
            },
            title: "إضافة حملة",
          ),
          SizedBox(width: 250.w, child: const Divider()),
          Spaces.inSectionSpace20,
          const TitleWidget(title: "الحملات"),
          Spaces.inSectionSpace20,
          BlocBuilder<CampaignDashbaordCubit, CampaignDashboardState>(
            builder: (context, state) {
              CampaignDashbaordCubit campaignDashbaordCubit =
                  context.read<CampaignDashbaordCubit>();
              if (state is CampaignDashboardLoadingState) {
                return const LoadingWidget(isCentered: true);
              } else if (state is CampaignDashboardErrorState) {
                return ErrorMessageWidget(
                  isCentered: true,
                  message: state.error,
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: campaignDashbaordCubit.campaigns.length,
                  itemBuilder: (context, index) {
                    return DashboardSecCard(
                      title:
                          "${campaignDashbaordCubit.campaigns[index].campaignName} (${campaignDashbaordCubit.campaigns[index].campaignNumber})",
                      onTap: () {
                        context.pushReplacement(
                          '${AppRouter.kCampaignSettingsAdminPage}/${campaignDashbaordCubit.campaigns[index].id}',
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
