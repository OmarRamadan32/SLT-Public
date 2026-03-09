import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/messages/cubit/messages_cubit.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/messages/presentation/views/messages_loading_view.dart';
import 'package:new_slt/features/messages/presentation/widgets/messages_page_messages_section.dart';
import 'package:new_slt/features/messages/presentation/widgets/messages_page_posts_section.dart';
import 'package:new_slt/features/messages/presentation/widgets/messages_page_tab_bar_section.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    context.read<PostsCubit>().getPendingPosts();
    context.read<MessagesCubit>().getAllMessages(
      userId: context.read<UserCubit>().userModel!.id!,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MessagesCubit messagesCubit = context.read<MessagesCubit>();
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      animationDuration: const Duration(milliseconds: 500),
      child: ScreenWidget(
        hasDrawer: true,
        isMainScreen: true,
        child: Column(
          children: [
            Spaces.inSectionSpace20,
            const MessagesPageTabBarSection(),
            // const MessagesPageDividerSectiion(),
            Spaces.inSectionSpace20,
            // it shows the view based on the index
            BlocBuilder<MessagesCubit, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoadingState) {
                  return const MessagesLoadingView();
                } else if (state is MessagesErrorState) {
                  return ErrorMessageWidget(
                    isCentered: true,
                    message: state.error,
                  );
                } else {
                  return Expanded(
                    child: TabBarView(
                      children: [
                        //* My Messages
                        MessagesPageMessagesSection(
                          loadMoreFunction: () {
                            messagesCubit.loadMorePrivateMessages(
                              userId: context.read<UserCubit>().userModel!.id!,
                              startAfter:
                                  messagesCubit.currentUserMessages.last.id,
                            );
                          },
                          isLoading: state is MessagesLoadingMoreState,
                          isDone: state is MessagesNoMorePrivateState,
                          messages: messagesCubit.currentUserMessages,
                        ),
                        //* All Messages
                        MessagesPageMessagesSection(
                          loadMoreFunction: () {
                            messagesCubit.getAllMessages(
                              userId: context.read<UserCubit>().userModel!.id!,
                              startAfterTeam:
                                  messagesCubit.allMessages
                                      .where(
                                        (element) => element.isPrivate == false,
                                      )
                                      .last
                                      .id,
                              startAfterUser:
                                  messagesCubit.allMessages
                                      .where(
                                        (element) => element.isPrivate == true,
                                      )
                                      .last
                                      .id,
                              append: true,
                            );
                          },
                          isLoading: state is MessagesLoadingMoreState,
                          isDone: state is MessagesNoMoreState,
                          messages: messagesCubit.allMessages,
                        ),
                        //* Team Messages
                        MessagesPageMessagesSection(
                          loadMoreFunction: () {
                            messagesCubit.loadMoreTeamMessages(
                              startAfter: messagesCubit.teamMessages.last.id,
                            );
                          },
                          isLoading: state is MessagesLoadingMoreState,
                          isDone: state is MessagesNoMoreTeamState,
                          messages: messagesCubit.teamMessages,
                        ),
                        // posts
                        const MessagesPagePostsSection(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
