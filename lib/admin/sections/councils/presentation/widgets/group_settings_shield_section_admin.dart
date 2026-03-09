import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/admin/presentation/shared_views/change_name_bottom_sheet_view.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class GroupSettingsShieldSection extends StatefulWidget {
  const GroupSettingsShieldSection({super.key});

  @override
  State<GroupSettingsShieldSection> createState() =>
      _GroupSettingsShieldSectionState();
}

class _GroupSettingsShieldSectionState
    extends State<GroupSettingsShieldSection> {
  Future<void> addGroupShield() async {
    context.read<CouncilDashboardCubit>().addGroupShield(
      shieldName: controller.text,
    );
  }

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardSecCard(
      authorizedIds: [
        context.read<CouncilDashboardCubit>().council!.councilLeaderId,
        context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!,
      ],
      icon: FontAwesomeIcons.plus,
      onTap: () {
        Helpers.showBottomSheetMethod(
          context: context,
          child: ChangeNameBottomSheetView(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                addGroupShield();
                controller.clear();
                context.pop();
              } else {
                Helpers.showSnackBar(context, "من فضلك ادخل اسم الدرع");
              }
            },
            controller: controller,
            textFieldLabel: "اسم الدرع",
          ),
        );
      },
      title: "إضافة دروع",
    );
  }
}
