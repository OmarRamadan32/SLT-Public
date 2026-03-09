import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, this.imageUrl, this.height, this.width});
  final double? height;

  final double? width;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        height: height?.r ?? 60.r,
        width: width?.r ?? 60.r,
        scale: 1.0,
        alignment: Alignment.center,

        errorWidget:
            (context, url, error) =>
                Opacity(opacity: 0.5, child: Image.asset(Assets.sltLogo)),
      ),
    );
  }
}
