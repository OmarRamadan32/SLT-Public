import 'package:flutter/material.dart';

class MessagesPageDividerSectiion extends StatelessWidget {
  const MessagesPageDividerSectiion({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Divider(
        color: Theme.of(context).textTheme.bodySmall!.color,
        thickness: 0.5,
      ),
    );
  }
}
