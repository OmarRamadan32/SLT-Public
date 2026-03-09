import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';

class ChangeDescriptionBottomSheetView extends StatelessWidget {
  const ChangeDescriptionBottomSheetView({
    super.key,
    required this.textFieldLabel,
  });
  final String textFieldLabel;

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
            CustomTextFieldAdmin(label: textFieldLabel, maxLines: 3),
            Spaces.inSectionSpace20,
            CustomButtonAdmin(onPressed: () {}, text: "حفظ"),
          ],
        ),
      ),
    );
  }
}
