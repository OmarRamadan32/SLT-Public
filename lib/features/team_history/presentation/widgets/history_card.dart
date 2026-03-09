import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.cardTitle,
    required this.cardContent,
  });
  final String cardTitle;
  final String cardContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: GestureDetector(
        onTap: () {
       Helpers.    showBottomSheetMethod(
            context: context,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: ArabicTextWidget(
                  style: Theme.of(context).textTheme.bodyLarge,
                  text: cardContent,
                  maxLines: 1000,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          );
        },

        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: ArabicTextWidget(
              maxLines: 5,
              text: cardTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
