import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class CommentItemAuthor extends StatelessWidget {
  const CommentItemAuthor({
    super.key,
    required this.postAuthorName,
    required this.postAuthorImage,
    required this.postAuthorAccessLevel,
    required this.isAuthor,
  });
  final String postAuthorName;
  final String postAuthorImage;
  final int postAuthorAccessLevel;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        VerifiedIcon(accessLevel: postAuthorAccessLevel),
        ArabicTextWidget(
          text: postAuthorName,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: isAuthor ? Colors.black87 : null,
          ),
        ),
        SizedBox(width: 7.w),
        SizedBox(
          height: 40.r,
          width: 40.r,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000.r),
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => Image.asset(
                Assets.sltLogo,
              ),
              fit: BoxFit.cover,
              imageUrl: postAuthorImage,
            ),
          ),
        ),
      ],
    );
  }
}
