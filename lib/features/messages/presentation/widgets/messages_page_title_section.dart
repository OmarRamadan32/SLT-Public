
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MessagesPageTitleSection extends StatelessWidget {
  const MessagesPageTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50.w,
          child: Divider(color: Theme.of(context).primaryColor, thickness: 0.5),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const ArabicTextWidget(text: "الرسائل"),
        ),
        SizedBox(
          width: 50.w,
          child: Divider(color: Theme.of(context).primaryColor, thickness: 0.5),
        ),
      ],
    );
  }
}
