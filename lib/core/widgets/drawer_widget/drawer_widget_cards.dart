import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/widgets/drawer_widget/drawer_card_widget.dart';

class DrawerWidgetCards extends StatelessWidget {
  const DrawerWidgetCards({super.key});

  @override
  Widget build(BuildContext context) {
    int accessLevel = context.read<UserCubit>().userModel!.accessLevel!;
    final String userAcountType =
        context.read<UserCubit>().userModel!.accountType;
    return Column(
      children: [
        DrawerCardWidget(
          icon: FontAwesomeIcons.solidCircleUser,
          label: "البروفايل",
          ontap: () {
            Scaffold.of(context).closeDrawer();
            context.push(
              "${AppRouter.kProfilePage}/${context.read<UserCubit>().userModel!.id}",
            );
          },
        ),

        // DrawerCardWidget(
        //   icon: FontAwesomeIcons.solidBell,
        //   label: "الإشعارات",
        //   ontap: () {
        //     Scaffold.of(context).closeDrawer();
        //     context.push(AppRouter.kMessagesPage);
        //   },
        // ),
        if (accessLevel >= 3)
          DrawerCardWidget(
            icon: FontAwesomeIcons.earthAmericas,
            label: "إرسال رسالة للجميع",
            ontap: () {
              context.push(AppRouter.kSendTeamMessageAdminPage);
            },
          ),
        if (accessLevel >= 3)
          DrawerCardWidget(
            icon: FontAwesomeIcons.userGroup,
            label: "ارسال رسالة للبعض",
            ontap: () {
              context.push(AppRouter.kSendMessageAdminPage);
            },
          ),
        DrawerCardWidget(
          icon: FontAwesomeIcons.book,
          label: "سجل الفريق",
          ontap: () {
            Scaffold.of(context).closeDrawer();
            context.push(AppRouter.kTeamHistoryPage);
          },
        ),
        DrawerCardWidget(
          icon: FontAwesomeIcons.gears,
          label: "إدارة التطبيق",
          ontap: () {
            if (userAcountType == Constants.normalMember) {
              GoRouter.of(context).push(AppRouter.kDashBoardPage);
              Scaffold.of(context).closeDrawer();
            } else {
              Scaffold.of(context).closeDrawer();
              Helpers.showSnackBar(
                context,
                "لا يمكنك الوصول لهذه الصفحة",
                isFailureMessage: true,
              );
            }
          },
        ),
      ],
    );
  }
}
