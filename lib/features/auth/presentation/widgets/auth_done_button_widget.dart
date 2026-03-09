import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';

class AuthDoneButtonWidget extends StatelessWidget {
  const AuthDoneButtonWidget({
    super.key,
    required this.isLoading,
    this.onPressed,
  });
  final bool isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 13.h),
        child:
            isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                  "Done",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontFamily: Constants.englishFont,
                    color: Colors.white,
                  ),
                ),
      ),
    );
  }
}
