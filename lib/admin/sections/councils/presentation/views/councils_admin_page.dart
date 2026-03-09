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
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class CouncilsAdminPage extends StatefulWidget {
  const CouncilsAdminPage({super.key});

  @override
  State<CouncilsAdminPage> createState() => _CouncilsAdminPageState();
}

class _CouncilsAdminPageState extends State<CouncilsAdminPage> {
  @override
  void initState() {
    context.read<CouncilDashboardCubit>().getCouncils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "المجالس",
      child: Column(
        children: [
          DashboardSecCard(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.plus,
            onTap: () {
              context.read<CouncilDashboardCubit>().resetState();
              context.pushReplacement(AppRouter.kAddCouncilAdminPage);
            },
            title: "إضافة مجلس",
          ),
          SizedBox(width: 250.w, child: const Divider()),
          Spaces.inSectionSpace20,
          const TitleWidget(title: "المجالس"),
          Spaces.inSectionSpace20,
          BlocBuilder<CouncilDashboardCubit, CouncilDashboardState>(
            builder: (context, state) {
              if (state is CouncilDashboardLoadingState) {
                return const LoadingWidget(
                  isCentered: true,
                  message: "جاري تحميل المجالس",
                );
              } else if (state is CouncilDashboardErrorState) {
                return ErrorMessageWidget(
                  isCentered: true,
                  message: state.message,
                );
              } else {
                CouncilDashboardCubit councilDashboardCubit =
                    context.read<CouncilDashboardCubit>();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: councilDashboardCubit.councils.length,
                  itemBuilder:
                      (context, index) => DashboardSecCard(
                        onTap: () {
                          councilDashboardCubit.resetState();
                          context.push(
                            '${AppRouter.kCouncilSettingsAdminPage}/${councilDashboardCubit.councils[index].id}',
                          );
                        },
                        title:
                            "المجلس رقم ${councilDashboardCubit.councils[index].councilNumber}",
                      ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
