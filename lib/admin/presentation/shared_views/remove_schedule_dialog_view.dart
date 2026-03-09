import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class RemoveScheduleDialogView extends StatelessWidget {
  const RemoveScheduleDialogView({super.key, required this.onConfirm});

  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            context.pop(); // Close dialog
          },
          child: Text(
            'لست متأكد',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () async {
            onConfirm!();
            context.pop();
          },
          child: Text('متأكد', style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
