import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ChooseDropdownBoxWidget extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String>? onSelected;

  const ChooseDropdownBoxWidget({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.items,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PopupMenuButton<String>(
            onSelected: onSelected,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 200.w),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              height: 38.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Text(selectedValue),
              ),
            ),
            itemBuilder:
                (context) => [
                  ...items.map(
                    (item) => PopupMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ArabicTextWidget(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
