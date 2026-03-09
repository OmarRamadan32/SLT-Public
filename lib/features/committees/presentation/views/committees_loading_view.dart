import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';

class CommitteesLoadingView extends StatelessWidget {
  const CommitteesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoadingView(
      cardsCount: 5,
      card: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 150.w, minWidth: 90.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: ArabicTextWidget(
                  text: 'لا يوجد Committees',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                width: 200.w,
                child: ArabicTextWidget(
                  maxLines: 2,
                  text: 'لا يوجد Committees',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: Colors.white54),
                ),
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'لا يوجد Committees',
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Icons.group, size: 16.r),
                              SizedBox(width: 4.w),
                              Text(
                                '0',
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
