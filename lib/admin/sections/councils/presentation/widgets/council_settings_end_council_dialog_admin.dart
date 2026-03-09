import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
class EndCouncilDialogActionsWidgets extends StatelessWidget {
  const EndCouncilDialogActionsWidgets({super.key, required this.endCouncil});

  final void Function() endCouncil;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              context.pop(context);
            },
            child: ArabicTextWidget(
              text: "إغلاق",
              style: theme.textTheme.bodySmall,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              endCouncil();
              context.pop();
            },
            child: ArabicTextWidget(
              text: "تأكيد",
              style: theme.textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
