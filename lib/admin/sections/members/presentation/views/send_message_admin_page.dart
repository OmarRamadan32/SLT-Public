import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/messages_cubit/messages_dashboard_cubit.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/choosed_users_section.dart';

class SendMessageAdminPage extends StatefulWidget {
  const SendMessageAdminPage({super.key});

  @override
  State<SendMessageAdminPage> createState() => _SendMessageAdminPageState();
}

class _SendMessageAdminPageState extends State<SendMessageAdminPage> {
  Future<void> sendMessageFunction() async {
    UserCubit userCubit = context.read<UserCubit>();
    if (messageController.text.isNotEmpty &&
        userCubit.selectedUsers.isNotEmpty) {
      final String senderName = context.read<UserCubit>().userModel!.name;
      MessageModel messageModel = MessageModel(
        isPrivate: true,
        senderName: senderName,
        text: messageController.text.trim(),
        date: DateTime.now(),
      );
      await context.read<MessagesDashboardCubit>().sendMessageToMembers(
        messageModel: messageModel,
        receiversIds: userCubit.selectedUsers.map((e) => e.id!).toList(),
        receiversTokens: userCubit.selectedUsers.map((e) => e.token).toList(),
      );
      userCubit.reset();
    } else {
      Helpers.showSnackBar(context, "من فضلك أدخل جميع البيانات اللازمة");
    }
  }

  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إرسال رسالة",
      child: BlocConsumer<MessagesDashboardCubit, MessagesDashboardState>(
        builder: (context, state) {
          if (state is MessagesDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is MessagesDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.message);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextFieldAdmin(
                  label: "الرسالة",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  hintText: "إكتب الرسالة هنا",
                  controller: messageController,
                  textAlign: TextAlign.right,
                  maxLines: 5,
                ),
                const SmallNoteWidget(
                  content: "ستظهر الرسالة إلي الأعضاء المختارين فقط",
                ),
                Spaces.sectionsSpace40,
                //-
                ChooseMultibleMembersWidgetAdmin(
                  cardTitle: "اختر المستخدمين",
                  searchPath: BackendEndpoints.usersCollection,
                  onSavedFunction: () {},
                ),
                Spaces.space10,
                //-
                const ChoosedUsersSection(),
                Spaces.sectionsSpace60,
                CustomButtonAdmin(
                  onPressed: () {
                    sendMessageFunction();
                  },
                  text: "إرسال",
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is MessagesDashboardSuccessState) {
            context.pop();
            messageController.clear();
          }
          if (state is MessagesDashboardErrorState) {
            context.pop();
            messageController.clear();
          }
        },
      ),
    );
  }
}
