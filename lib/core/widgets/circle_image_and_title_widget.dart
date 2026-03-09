import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';

class CirlceImageAndTitleWidget extends StatelessWidget {
  const CirlceImageAndTitleWidget({
    super.key,
    required this.userName,
    required this.userImage,
  });
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          child: AvatarImage(height: 65, width: 65, imageUrl: userImage),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Text(userName, style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
