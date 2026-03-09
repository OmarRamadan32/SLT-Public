import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/council_settings_council_section_admin.dart';

class CouncilSettingsAdminPage extends StatefulWidget {
  const CouncilSettingsAdminPage({super.key, required this.councilId});
  final String councilId;

  @override
  State<CouncilSettingsAdminPage> createState() =>
      _CouncilSettingsAdminPageState();
}

class _CouncilSettingsAdminPageState extends State<CouncilSettingsAdminPage> {
  @override
  void initState() {
    context.read<CouncilDashboardCubit>().groups = [];
    context.read<CouncilDashboardCubit>().swa3ed = null;
    context.read<CouncilDashboardCubit>().getAllCouncilEventsById(
      councilId: widget.councilId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CouncilDashboardCubit cubit = context.read<CouncilDashboardCubit>();
    return DashboardScreenWidget(
      appBarTitle: "إدارة المجلس",
      child: SingleChildScrollView(
        child: BlocConsumer<CouncilDashboardCubit, CouncilDashboardState>(
          builder: (context, state) {
            if (state is CouncilDashboardLoadingState) {
              return const LoadingWidget(isCentered: true);
            } else if (state is CouncilDashboardErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              return Column(
                children: [
                  CouncilSettingsCouncilSection(councilId: widget.councilId),
                  Spaces.inSectionSpace20,
                  if (cubit.swa3ed != null)
                    DashboardSecCard(
                      icon: FontAwesomeIcons.gears,
                      onTap: () {
                        context.pushReplacement(
                          AppRouter.kSwa3edSettingsAdminPage,
                        );
                      },
                      title: "إعدادات السواعد",
                    ),
                  Spaces.inSectionSpace20,
                  const TitleWidget(title: "المجاميع"),
                  Spaces.inSectionSpace20,
                  if (cubit.groups.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.groups.length,
                      itemBuilder: (context, index) {
                        return DashboardSecCard(
                          title: cubit.groups[index].groupName,
                          onTap: () {
                            cubit.getCouncilGroupById(
                              groupId: cubit.groups[index].id!,
                            );
                            context.pushReplacement(
                              AppRouter.kGroupSettingsAdminPage,
                            );
                          },
                        );
                      },
                    ),
                  if (cubit.groups.isEmpty)
                    Column(
                      children: [
                        const EmptyViewWidget(
                          message: "لا يوجد مجاميع",
                          isCentered: false,
                        ),
                        Spaces.inSectionSpace20,
                      ],
                    ),
                ],
              );
            }
          },
          listener: (context, state) {
            if (state is CouncilDashboardLeaderUpdatedState) {
              context.read<CouncilDashboardCubit>().getAllCouncilEventsById(
                councilId: widget.councilId,
              );
              Helpers.showSnackBar(
                context,
                "تم تغيير قائد المجلس بنجاح",
                isSuccessMessage: true,
              );
              context.read<UserCubit>().reset();
            }
            if (state is CouncilDashboardEndedState) {
              Helpers.showSnackBar(
                context,
                "تم إنهاء المجلس بنجاح",
                isSuccessMessage: true,
              );
              context.pop();
            }
          },
        ),
      ),
    );
  }
}
