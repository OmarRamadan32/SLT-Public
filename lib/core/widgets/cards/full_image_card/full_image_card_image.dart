import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class FullImageCardImage extends StatelessWidget {
  const FullImageCardImage({super.key, required this.cardImage});
  final String cardImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.black,
      ),
      child: Opacity(
        opacity: 0.40,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: cardImage,

          placeholder:
              (context, url) => Image.asset(
                width: double.infinity,
                Assets.sltLogo,
                fit: BoxFit.cover,
              ),
        ),
      ),
    );
  }
}
