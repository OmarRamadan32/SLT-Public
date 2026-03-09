import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/messages/cubit/messages_cubit.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/features/messages/presentation/views/today_message_loading_view.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  void initState() {
    context.read<MessagesCubit>().getTodayMessages(
      userId: context.read<UserCubit>().userModel!.id!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessagesCubit>();
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoadingState) {
          return const TodayMessageLoadingView();
        } else if (state is MessagesErrorState) {
          return ErrorMessageWidget(message: state.error);
        } else {
          if (cubit.todayMessages.isEmpty) {
            return const SizedBox();
          } else {
            return Column(
              children: [
                Spaces.inSectionSpace20,
                ExpandablePageView.builder(
                  animationCurve: Curves.decelerate,
                  padEnds: false,
                  animationDuration: const Duration(milliseconds: 500),
                  animateFirstPage: true,
                  controller: PageController(
                    viewportFraction:
                        cubit.todayMessages.length == 1 ? 1 : 0.95,
                  ),
                  alignment: Alignment.center,
                  itemCount: cubit.todayMessages.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: cubit.todayMessages.length == 1 ? 0 : 5.w,
                        ),
                        child: MessageCard(
                          maxLines: 3,
                          isPrimary: false, //! IMPORTANT
                          message: cubit.todayMessages[index].text,
                          messageDate: cubit.todayMessages[index].date,
                          senderName: cubit.todayMessages[index].senderName,
                        ),
                      ),
                ),
                SizedBox(
                  width: 75.w,
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 1.3,
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
