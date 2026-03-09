import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class OnboardingBodyWidget extends StatelessWidget {
  const OnboardingBodyWidget({
    super.key,
    required this.body,
    this.fontSize,
    this.isPrimaryColor,
    this.textAlign,
  });
  final String body;
  final bool? isPrimaryColor;
  final double? fontSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ArabicTextWidget(
        text: body,
        textAlign: textAlign ?? TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: fontSize?.sp,
          color: isPrimaryColor == true ? Theme.of(context).primaryColor : null,
        ),
        maxLines: 1000,
      ),
    );
  }
}
