import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/utils/helpers.dart';

class CustomButtonAdmin extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? isLoading;

  const CustomButtonAdmin({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed:
              isLoading ?? false
                  ? () {
                    Helpers.showSnackBar(context, "يرجي انتظار العملية");
                  }
                  : onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child:
              isLoading ?? false
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    text,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
        ),
      ),
    );
  }
}
