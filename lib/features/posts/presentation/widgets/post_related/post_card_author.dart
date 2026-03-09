import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';
import 'package:new_slt/features/posts/presentation/widgets/content_date.dart';

import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';

class PostCardAuthor extends StatelessWidget {
  const PostCardAuthor({
    super.key,
    required this.authorName,
    required this.authorImage,
    required this.postDate,
    required this.accessLevel,
  });
  final String authorName;
  final String? authorImage;
  final DateTime postDate;
  final int accessLevel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ContentDate(postDate: postDate),
        const Spacer(),
        Row(
          children: [
            VerifiedIcon(accessLevel: accessLevel),
            ArabicTextWidget(
              text: authorName,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(width: 10.w),
        AvatarImage(imageUrl: authorImage, height: 50, width: 50),
      ],
    );
  }
}
