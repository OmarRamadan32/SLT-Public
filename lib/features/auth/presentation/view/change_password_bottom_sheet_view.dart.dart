import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/auth_textfield_widget.dart';

class ChangePasswordBottomSheetView extends StatefulWidget {
  const ChangePasswordBottomSheetView({super.key});

  @override
  State<ChangePasswordBottomSheetView> createState() =>
      _ChangePasswordBottomSheetViewState();
}

class _ChangePasswordBottomSheetViewState
    extends State<ChangePasswordBottomSheetView> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 250.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTextField(
              hint: "ادخل البريد الالكتروني",
              controller: controller,
            ),
            Spaces.inSectionSpace20,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textStyle: theme.textTheme.bodyLarge,
              ),
              onPressed: () {
                context.read<AuthCubit>().sendPasswordResetEmail(
                  controller.text.trim(),
                );
                context.pop();
              },
              child: ArabicTextWidget(
                text: "تاكيد",
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
