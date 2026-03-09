import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.isCentered, this.message});
  final bool? isCentered;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (isCentered == true)
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              backgroundColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.2),
            ),
          ),
          SizedBox(height: 12.h),
          ArabicTextWidget(
            text: message ?? "جاري التحميل",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
