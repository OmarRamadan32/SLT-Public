import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/core/widgets/membership_check_view.dart';

import 'package:new_slt/features/messages/presentation/widgets/message_widget.dart';

class MessagesPageMessagesSection extends StatelessWidget {
  const MessagesPageMessagesSection({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.isDone,
    required this.loadMoreFunction,
  });
  final List<MessageModel> messages;
  final bool isLoading;
  final bool isDone;
  final void Function()? loadMoreFunction;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const EmptyViewWidget(message: "لا يوجد رسائل");
    } else {
      return MembershipCheckView(
        view: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MessageCard(
                          maxLines: 5,
                          message: messages[index].text,
                          senderName: messages[index].senderName,
                          messageDate: messages[index].date,
                        ),
                        if (index == messages.length - 1 && !isDone)
                          LoadMoreWidget(
                            onTap: loadMoreFunction,
                            isLoading: isLoading,
                            isDone: isDone,
                          ),
                      ],
                    );
                  },
                ),
              ),
              Spaces.screenLastItemSpace70,
            ],
          ),
        ),
      );
    }
  }
}
