import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/members/presentation/widgets/back_ground_image.dart';
import 'package:new_slt/features/members/presentation/widgets/user_profile_image.dart';

class ProfileImagesWidget extends StatelessWidget {
  const ProfileImagesWidget({
    super.key,
    required this.isCentered,
    required this.imageUrl,
    required this.backGroundImageUrl,
    required this.isDrawer,
  });
  final bool isCentered;
  final String imageUrl;
  final String backGroundImageUrl;
  final bool isDrawer;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: isCentered ? Alignment.centerLeft : Alignment.centerRight,
      clipBehavior: Clip.none,
      children: [
        BackGroundImage(imageUrl: backGroundImageUrl),
        Positioned(
          bottom: isDrawer ? -50.h : -25.h,
          child: UserProfileImage(isDrawer: isDrawer, imageUrl: imageUrl),
        ),
      ],
    );
  }
}
