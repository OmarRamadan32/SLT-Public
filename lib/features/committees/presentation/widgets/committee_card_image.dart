import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';

class CommitteeCardImage extends StatelessWidget {
  const CommitteeCardImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,
          height: 170.h,
          width: double.infinity,
          fit: BoxFit.cover,
            placeholder: (context, url) => Opacity(
            opacity: 0.5,
            child: Image.asset(Assets.sltLogo, fit: BoxFit.cover),
            ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
