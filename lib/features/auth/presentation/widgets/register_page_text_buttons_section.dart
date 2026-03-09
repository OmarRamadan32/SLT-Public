import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class RegisterPageTextButtonsSection extends StatelessWidget {
   RegisterPageTextButtonsSection({super.key, required this.formKey, required this.autovalidateMode});

  final GlobalKey<FormState> formKey;
  AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              formKey.currentState!.reset();
          autovalidateMode = AutovalidateMode.disabled;
              GoRouter.of(context).pushReplacement(AppRouter.kLoginPage);
            },
            child: Text(
              "تسجيل دخول",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        Center(
          child: ArabicTextWidget(
            text: "لديك حساب بالفعل؟",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
