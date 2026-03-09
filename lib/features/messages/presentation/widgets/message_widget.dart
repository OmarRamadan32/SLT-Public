import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget_bottom_sheet.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget_message.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget_upper.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.messageDate,
    required this.senderName,
    this.isPrimary = false,
    this.maxLines,
  });
  final String message;
  final DateTime messageDate;
  final String senderName;
  final bool isPrimary;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
       Helpers.    showBottomSheetMethod(
            context: context,
            child: MessageWidgetBottomSheet(
              isPrimary: isPrimary,
              message: message,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isPrimary
                    ? theme.primaryColor
                    : theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MessageWidgetUpperPart(
                isPrimary: isPrimary,
                messageDate: messageDate,
                senderName: senderName,
              ),
              Spaces.space10,
              MessageWidgetText(message: message, isPrimary: isPrimary),
              Spaces.space10,
            ],
          ),
        ),
      ),
    );
  }
}
