import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';

class TeamMemberCardImage extends StatelessWidget {
  const TeamMemberCardImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: AvatarImage(imageUrl: imageUrl),
    );
  }
}
