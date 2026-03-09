import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class ActivityImage extends StatelessWidget {
  const ActivityImage({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        placeholder:
            (context, url) => Opacity(
              opacity: 0.5,
              child: Image.asset(Assets.sltLogo, fit: BoxFit.cover),
            ),
        errorWidget:
            (context, url, error) =>
                Image.asset(Assets.sltLogo, fit: BoxFit.cover),
        width: double.infinity,
        height: 150.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
