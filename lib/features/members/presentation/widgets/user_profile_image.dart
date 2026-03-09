import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.imageUrl,
    required this.isDrawer,
  });
  final String imageUrl;
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    void openPreview() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          final size = MediaQuery.of(context).size;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: SafeArea(
              child: Container(
                height: size.height * 0.85,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                child: Center(
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.8,
                    maxScale: 4.0,
                    child: Hero(
                      tag: imageUrl,
                      child: SizedBox(
                        width: size.width * 0.9,
                        height: size.width * 0.9,
                        child: AvatarImage(imageUrl: imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    if (isDrawer) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Container(
          width: 125.r,
          height: 125.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.7),
          ),
          child: AvatarImage(imageUrl: imageUrl),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 15.w),
        child: GestureDetector(
          onTap: openPreview,
          onDoubleTap: openPreview,
          child: Container(
            width: 125.r,
            height: 125.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.7),
            ),
            child: Hero(tag: imageUrl, child: AvatarImage(imageUrl: imageUrl)),
          ),
        ),
      );
    }
  }
}
