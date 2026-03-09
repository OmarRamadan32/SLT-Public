import 'package:flutter/material.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CommentItemDate extends StatelessWidget {
  const CommentItemDate({
    super.key,
    required this.commentDate,
    required this.isAuthor,
  });
  final DateTime commentDate;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    final int hour = commentDate.hour % 12 == 0 ? 12 : commentDate.hour % 12;
    final String period = commentDate.hour < 12 ? 'صباحًا' : 'مساءً';
    final String time =
        "${hour.toString().padLeft(2, '0')}:${commentDate.minute.toString().padLeft(2, '0')} $period";
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        ArabicTextWidget(
          text:
              "${commentDate.year}/${Helpers.zeroFill(commentDate.month)}/${Helpers.zeroFill(commentDate.day)}",
          style: theme.textTheme.labelSmall!.copyWith(
            color:
                isAuthor ? Colors.black54 : theme.textTheme.labelSmall!.color,
          ),
        ),
        ArabicTextWidget(
          text: time,
          style: theme.textTheme.labelSmall!.copyWith(
            color:
                isAuthor ? Colors.black54 : theme.textTheme.labelSmall!.color,
          ),
        ),
      ],
    );
  }
}
