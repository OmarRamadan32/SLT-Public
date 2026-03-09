import 'package:flutter/material.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget.dart';

class MessagesLoadingView extends StatelessWidget {
  const MessagesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SkeletonLoadingView(
        card: MessageCard(
          message: "دي رسالة فاضية وملهاش اي لازمة",
          messageDate: DateTime.now(),
          senderName: "فريق القادة ",
        ),
        cardsCount: 10,
      ),
    );
  }
}
