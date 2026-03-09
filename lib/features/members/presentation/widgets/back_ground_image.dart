import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget:
              (context, url, error) =>
                  Image.asset(Assets.sltLogo, fit: BoxFit.cover),
          placeholder:
              (context, url) =>
                  const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
