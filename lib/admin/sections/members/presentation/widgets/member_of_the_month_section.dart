import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';

class MemberOfTheMonthSection extends StatelessWidget {
  const MemberOfTheMonthSection({super.key});

  Future<void> addMemberOfTheMonth({required BuildContext context}) async {
    final UserCubit userCubit = context.read<UserCubit>();
    final String memberName = userCubit.selectedUser!.name;
    final String memberImage = userCubit.selectedUser!.imageUrl;
    final HighlightModel model = HighlightModel(
      memberOfTheMonthId: userCubit.selectedUser!.id!,
      image: memberImage,
      content: "مثالي شهر ${Helpers.getMonthName(DateTime.now().month - 1)}",
      title: memberName,
    );
    await context.read<MembersDashboardCubit>().addMemberOfTheMonth(
      memberOfTheMonthModel: model,
    );
  }

  Future<void> removeMemberOfTheMonth({required BuildContext context}) async {
    await context.read<MembersDashboardCubit>().removeMemberOfTheMonth();
  }

  @override
  Widget build(BuildContext context) {
    final String lastMonthName = Helpers.getMonthName(DateTime.now().month - 1);
    return Column(
      children: [
        SizedBox(width: 250.w, child: const Divider()),
        Spaces.inSectionSpace20,
        const TitleWidget(title: "مثالي الشهر"),
        const SmallNoteWidget(
          content: '''
 اختيار مثالي الشهر يكون بعد انتهاء الشهر نفسه
 مثال: يمكنك إختيار مثالي شهر مارس في اي يوم من شهر ابريل
            ''',
        ),
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userNinja,
          cardTitle: "اختيار مثالي شهر $lastMonthName",
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            addMemberOfTheMonth(context: context);
          },
        ),
        DashboardSecCard(
          onTap: () {
            removeMemberOfTheMonth(context: context);
          },
          title: "حذف مثالي الشهر",
          icon: FontAwesomeIcons.userSlash,
        ),
      ],
    );
  }
}
