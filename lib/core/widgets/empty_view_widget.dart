import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class EmptyViewWidget extends StatelessWidget {
  const EmptyViewWidget({
    super.key,
    this.isCentered,
    this.message,
    this.viewTitle,
  });
  final bool? isCentered;
  final String? message;
  final String? viewTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (viewTitle != null)
            Column(
              children: [
                Spaces.inSectionSpace20,
                TitleWidget(title: viewTitle!),
              ],
            ),
          Spaces.inSectionSpace20,
          if (isCentered == true)
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Opacity(
            opacity: 0.4,
            child: SvgPicture.asset(
              Assets.emptyIcon,
              width: 40.w,
              height: 40.h,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message ?? "لا يوجد بيانات",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
