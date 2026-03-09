import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/presentation/view/change_password_bottom_sheet_view.dart.dart';

class LoginPageTextButtonsSection extends StatefulWidget {
   LoginPageTextButtonsSection({super.key, required this.formkey, required this.autovalidateMode});
  final GlobalKey<FormState> formkey;
   AutovalidateMode autovalidateMode;

  @override
  State<LoginPageTextButtonsSection> createState() => _LoginPageTextButtonsSectionState();
}

class _LoginPageTextButtonsSectionState extends State<LoginPageTextButtonsSection> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled:
                      true, // This allows the bottom sheet to resize with the keyboard
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder:
                      (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const ChangePasswordBottomSheetView(),
                      ),
                );
              },
              child: Text(
                "نسيت كلمة المرور",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  widget.formkey.currentState!.reset();
                  widget.autovalidateMode = AutovalidateMode.disabled;
                  GoRouter.of(context).pushReplacement(AppRouter.kRegisterPage);
                },
                child: Text(
                  "إنشاء حساب",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            Center(
              child: ArabicTextWidget(
                text: "ليس لديك حساب؟",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
