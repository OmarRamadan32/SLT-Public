import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DrawerCardWidget extends StatelessWidget {
  const DrawerCardWidget({
    super.key,
    this.isLogoutCard,
    required this.label,
    required this.icon,
    this.ontap,
  });
  final String label;
  final IconData icon;
  final void Function()? ontap;
  final bool? isLogoutCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20.w),
                FaIcon(
                  FontAwesomeIcons.angleLeft,
                  size: 15.sp,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!.withAlpha(100),
                ),
                const Spacer(),
                ArabicTextWidget(
                  text: label,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: isLogoutCard == true ? Colors.red : null,
                  ),
                ),
                SizedBox(width: 20.w),
                FaIcon(
                  icon,
                  size: 22.sp,
                  color: isLogoutCard == true ? Colors.red : null,
                ),
                SizedBox(width: 20.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
