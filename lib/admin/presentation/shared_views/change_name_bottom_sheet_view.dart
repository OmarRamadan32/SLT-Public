import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';

class ChangeNameBottomSheetView extends StatelessWidget {
  const ChangeNameBottomSheetView({
    super.key,
    required this.textFieldLabel,
    required this.controller,
    required this.onPressed,
  });
  final String textFieldLabel;
  final TextEditingController controller;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 15.w,
          right: 15.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFieldAdmin(label: textFieldLabel, controller: controller),
            Spaces.inSectionSpace20,
            CustomButtonAdmin(onPressed: onPressed, text: "حفظ"),
          ],
        ),
      ),
    );
  }
}
