import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final bool? isCentered;

  const ErrorMessageWidget({
    super.key,
    this.message,
    this.onRetry,
    this.isCentered,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCentered == true)
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),

            SvgPicture.asset(Assets.errorIcon, width: 40.w, height: 40.h),
            SizedBox(height: 10.h),
            ArabicTextWidget(
              maxLines: 2,
              text: message ?? "حدث خطأ ما",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.redAccent),
            ),
            SizedBox(height: 14.h),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: 18.w),
                label: ArabicTextWidget(
                  text: "إعادة المحاولة",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(0, 36.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
