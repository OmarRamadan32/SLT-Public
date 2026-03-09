import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifiedIcon extends StatelessWidget {
  const VerifiedIcon({super.key, required this.accessLevel, this.size});
  final int accessLevel;
  final double? size;

  @override
  Widget build(BuildContext context) {
    Color? iconColor;
    if (accessLevel == 1) {
      iconColor = const Color(0xffCD7F32);
    } else if (accessLevel == 2) {
      iconColor = const Color(0xffC0C0C0);
    } else if (accessLevel == 3) {
      iconColor = const Color(0xFFFFD700);
    } else if (accessLevel == 5) {
      iconColor = const Color(0xFF1877F2);
    }
    if (accessLevel == 1 || accessLevel == 2 || accessLevel == 3) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Icon(
          Icons.verified_user_sharp,
          color: iconColor,
          shadows: [const BoxShadow(color: Colors.black, blurRadius: 2)],
          size: size?.sp ?? 15.sp,
        ),
      );
    } else if (accessLevel == 5) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Icon(Icons.verified, color: iconColor, size: size?.sp ?? 15.sp),
      );
    } else {
      return const Icon(null);
    }
  }
}
