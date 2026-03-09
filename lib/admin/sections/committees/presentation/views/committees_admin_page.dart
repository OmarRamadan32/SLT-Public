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
import 'package:new_slt/admin/sections/committees/presentation/cubit/committee_dashboard_cubit.dart';

class CommitteesAdminPage extends StatefulWidget {
  const CommitteesAdminPage({super.key});

  @override
  State<CommitteesAdminPage> createState() => _CommitteesAdminPageState();
}

class _CommitteesAdminPageState extends State<CommitteesAdminPage> {
  @override
  void initState() {
    context.read<CommitteeDashboardCubit>().getAllCommittees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommitteeDashboardCubit committeeCubit =
        context.read<CommitteeDashboardCubit>();
    return DashboardScreenWidget(
      appBarTitle: "ادارة اللجان",
      child: Column(
        children: [
          DashboardSecCard(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.plus,
            title: "إضافة لجنة",
            onTap: () {
              committeeCubit.resetState();
              context.pushReplacement(AppRouter.kAddCommitteeAdminPage);
            },
          ),
          SizedBox(width: 250.w, child: const Divider()),
          Spaces.inSectionSpace20,
          const TitleWidget(title: "اللجان"),
          Spaces.inSectionSpace20,
          BlocBuilder<CommitteeDashboardCubit, CommitteeDashboardState>(
            builder: (context, state) {
              if (state is CommitteeDashboardErrorState) {
                return ErrorMessageWidget(message: state.message);
              } else if (state is CommitteeDashboardLoadingState) {
                return const LoadingWidget(isCentered: true);
              } else {
                return ListView.builder(
                  itemCount: committeeCubit.committees.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DashboardSecCard(
                      authorizedIds: [
                        committeeCubit.committees[index].committeeLeaderId!,
                      ],
                      title: committeeCubit.committees[index].committeeName,
                      onTap: () {
                        context.read<CommitteeDashboardCubit>().committeeModel =
                            committeeCubit.committees[index];
                        context.pushReplacement(
                          "${AppRouter.kCommitteeSettingsAdminPage}/${committeeCubit.committees[index].id}",
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
