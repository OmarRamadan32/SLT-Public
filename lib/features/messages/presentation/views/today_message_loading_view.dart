import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/messages/presentation/widgets/message_widget.dart';

class TodayMessageLoadingView extends StatelessWidget {
  const TodayMessageLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoadingView(
      card: Column(
        children: [
          Container(
            height: 20.h,
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 100.w,
          ),
          Spaces.space5,
          ExpandablePageView.builder(
            controller: PageController(viewportFraction: 0.95),
            alignment: Alignment.center,
            itemCount: 3,
            itemBuilder:
                (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: MessageCard(
                    maxLines: 3,
                    isPrimary: true,
                    message: "----------------------------------",
                    messageDate: DateTime.now(),
                    senderName: "------",
                  ),
                ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: 75.w,
            height: 5.h,
          ),
        ],
      ),
      cardsCount: 1,
    );
  }
}
