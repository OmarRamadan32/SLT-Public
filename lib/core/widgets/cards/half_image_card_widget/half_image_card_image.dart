import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class HalfImageCardImage extends StatelessWidget {
  const HalfImageCardImage({super.key, this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
          topRight: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
        child: CachedNetworkImage(
          imageUrl: image ?? '',
          placeholder:
              (context, url) => Opacity(
                opacity: 0.5,
                child: Image.asset(Assets.sltLogo, fit: BoxFit.cover),
              ),
          errorWidget:
              (context, url, error) => Opacity(
                opacity: 0.5,
                child: Image.asset(Assets.sltLogo, fit: BoxFit.cover),
              ),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
