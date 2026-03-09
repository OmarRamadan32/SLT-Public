import 'package:flutter/material.dart';

class DeveloperNameWidget extends StatelessWidget {
  const DeveloperNameWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: "englishFont"),
    );
  }
}