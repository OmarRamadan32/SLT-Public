import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class LoginPageHeaderSection extends StatelessWidget {
  const LoginPageHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ArabicTextWidget(
            text: "فريق القادة الاجتماعيين",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Center(
            child: ArabicTextWidget(
              text: "كلية الأعمال",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Spaces.sectionsSpace40,
        Center(
          child: SizedBox(
            child: SvgPicture.asset(Assets.loginIcon, width: 125.w),
          ),
        ),
      ],
    );
  }
}
