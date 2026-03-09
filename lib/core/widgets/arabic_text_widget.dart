import 'package:flutter/material.dart';

class ArabicTextWidget extends StatelessWidget {
  const ArabicTextWidget({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.textAlign,
  });
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.right,
      textDirection: TextDirection.rtl,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: style,
    );
  }
}
