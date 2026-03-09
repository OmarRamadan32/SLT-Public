import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/messages_cubit/messages_dashboard_cubit.dart';

class MembersAdminPageMessagesSection extends StatelessWidget {
  const MembersAdminPageMessagesSection({super.key});

  Future<void> punishmentFunction({
    required String text,
    required BuildContext context,
  }) async {
    final String senderName = context.read<UserCubit>().userModel!.name;
    final UserCubit userCubit = context.read<UserCubit>();
    final List<String> membersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    final List<String> membersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    MessageModel messageModel = MessageModel(
      isPrivate: true,
      senderName: senderName,
      text: text.trim(),
      date: DateTime.now(),
    );
    await context.read<MessagesDashboardCubit>().sendMessageToMembers(
      receiversTokens: membersTokens,
      receiversIds: membersIds,
      messageModel: messageModel,
    );
  }

  Future<void> removeMembersFromTeamFunction({
    required BuildContext context,
  }) async {
    final UserCubit userCubit = context.read<UserCubit>();
    final List<String> membersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    final List<String> membersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    await context.read<MembersDashboardCubit>().removeMembersFromTheTeam(
      membersIds: membersIds,
      membersTokens: membersTokens,
    );
  }

  Future<void> addMembersToTheTeamFunction({
    required BuildContext context,
  }) async {
    final UserCubit userCubit = context.read<UserCubit>();
    final List<String> membersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    await context.read<MembersDashboardCubit>().addMembersToTheTeam(
      membersIds: membersIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessagesDashboardCubit, MessagesDashboardState>(
      listener: (context, state) {
        if (state is MessagesDashboardErrorState) {
          Helpers.showSnackBar(context, state.message, isFailureMessage: true);
        }
        if (state is MessagesDashboardSuccessState) {
          Helpers.showSnackBar(
            context,
            "تمت العملية بنجاح",
            isSuccessMessage: true,
          );
        }
        if (state is MessagesDashboardLoadingState) {
          Helpers.showSnackBar(context, 'جاري التحميل');
        }
      },
      child: Column(
        children: [
          const TitleWidget(title: "رسائل الفريق"),
          Spaces.space10,
          DashboardSecCard(
            requiredAccessLevel: 3,
            icon: FontAwesomeIcons.solidPaperPlane,
            onTap: () {
              context.push(AppRouter.kSendTeamMessageAdminPage);
            },
            title: "إرسال رسالة للجميع",
          ),
          DashboardSecCard(
            requiredAccessLevel: 3,
            icon: FontAwesomeIcons.solidPaperPlane,
            onTap: () {
              context.push(AppRouter.kSendMessageAdminPage);
            },
            title: "إرسال رسالة لبعض من الاعضاء",
          ),
          SizedBox(width: 250.w, child: const Divider()),
          Spaces.inSectionSpace20,
          const TitleWidget(title: "قرارات الفريق"),
          const SmallNoteWidget(
            content: '''
ملحوظة: جميع القرارات الثلاث ترسل إلي الشخص بشكل خاص ولا تظهر لأي عضو غيره
وإذا كنت تريد ان يظهر القرار بشكل علني يمكنك إرساله كرسالة للجميع
''',
          ),
          ChooseMultibleMembersWidgetAdmin(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.exclamation,
            cardTitle: "قرار لفت نظر",
            searchPath: BackendEndpoints.usersCollection,
            onSavedFunction: () {
              punishmentFunction(
                context: context,
                text: Constants.punishment1Message,
              );
            },
          ),
          ChooseMultibleMembersWidgetAdmin(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.triangleExclamation,
            cardTitle: "قرار إنذار بالفصل",
            searchPath: BackendEndpoints.usersCollection,
            onSavedFunction: () {
              punishmentFunction(
                context: context,
                text: Constants.punishment2Message,
              );
            },
          ),
          ChooseMultibleMembersWidgetAdmin(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.ban,
            cardTitle: "قرار فصل",
            searchPath: BackendEndpoints.usersCollection,
            onSavedFunction: () {
              removeMembersFromTeamFunction(context: context);
            },
          ),
          ChooseMultibleMembersWidgetAdmin(
            requiredAccessLevel: Constants.adminAccessLevel,
            icon: FontAwesomeIcons.userPlus,
            where: {UserFields.userAccountType: Constants.guestMember},
            cardTitle: "إضافة أعضاء الفريق",
            searchPath: BackendEndpoints.usersCollection,
            onSavedFunction: () {
              addMembersToTheTeamFunction(context: context);
            },
          ),
          const SmallNoteWidget(
            content: "إضافة أصحاب الحسابات الجديدة إلي قائمة أعضاء الفريق",
          ),
        ],
      ),
    );
  }
}
