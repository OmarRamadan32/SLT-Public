import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/messages_cubit/messages_dashboard_cubit.dart';

class SendTeamMessageAdminPage extends StatefulWidget {
  const SendTeamMessageAdminPage({super.key});

  @override
  State<SendTeamMessageAdminPage> createState() =>
      _SendTeamMessageAdminPageState();
}

class _SendTeamMessageAdminPageState extends State<SendTeamMessageAdminPage> {
  Future<void> sendMessageFunction() async {
    if (_messageController.text.isNotEmpty) {
      final String senderName = context.read<UserCubit>().userModel!.name;
      MessageModel messageModel = MessageModel(
        isPrivate: false,
        senderName: senderName,
        text: _messageController.text.trim(),
        date: DateTime.now(),
      );
      await context.read<MessagesDashboardCubit>().sendMessageToAllTeam(
        messageModel: messageModel,
      );
    } else {
      Helpers.showSnackBar(context, "من فضلك ادخل الرسالة");
    }
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إرسال رسالة للجميع",
      child: BlocConsumer<MessagesDashboardCubit, MessagesDashboardState>(
        builder: (context, state) {
          if (state is MessagesDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is MessagesDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.message);
          } else {
            return Column(
              children: [
                CustomTextFieldAdmin(
                  label: "الرسالة",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  hintText: "إكتب الرسالة هنا",
                  controller: _messageController,
                  textAlign: TextAlign.right,
                  maxLines: 5,
                ),
                const SmallNoteWidget(
                  content: "ستظهر الرسالة إلي جميع أعضاء الفريق",
                ),
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
            _messageController.clear();
          }
        },
      ),
    );
  }
}
