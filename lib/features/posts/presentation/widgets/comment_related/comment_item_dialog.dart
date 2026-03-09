import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CommentItemDialog extends StatelessWidget {
  const CommentItemDialog({super.key, required this.onDone});
  final void Function() onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        TextButton(
          child: ArabicTextWidget(
            text: "رجوع",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: theme.textTheme.bodySmall!.color,
            ),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        TextButton(
          child: ArabicTextWidget(
            text: "نعم",
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.red),
          ),
          onPressed: () {
            context.pop();
            // on Confirm delete comment
            onDone();
          },
        ),
      ],
    );
  }
}
