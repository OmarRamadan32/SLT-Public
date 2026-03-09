import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.isDone,
  });

  final void Function()? onTap;
  final bool isLoading;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator(
        strokeWidth: 2,
        color: Theme.of(context).primaryColor,
      );
    } else {
      if (isDone) {
        return const SizedBox();
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.circleArrowDown, size: 13.sp),
            TextButton(
              onPressed: onTap,
              child: ArabicTextWidget(
                text: "عرض المزيد",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
            ),
          ],
        );
      }
    }
  }
}
