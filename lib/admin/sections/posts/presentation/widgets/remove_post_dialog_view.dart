import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RemovePostDialogView extends StatelessWidget {
  const RemovePostDialogView({super.key, required this.onRemove});

  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text(
            'لست متأكد',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: ()  {
            onRemove();
            context.pop();
          },
          child: Text('متأكد', style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
