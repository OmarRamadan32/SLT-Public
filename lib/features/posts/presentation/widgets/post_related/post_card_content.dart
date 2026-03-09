import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class PostCardContent extends StatefulWidget {
  const PostCardContent({super.key, required this.postContent, this.maxLines});

  final String postContent;
  final int? maxLines;

  @override
  State<PostCardContent> createState() => _PostCardContentState();
}

class _PostCardContentState extends State<PostCardContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int collapsedMaxLines = widget.maxLines ?? 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = theme.textTheme.bodySmall!.copyWith(
          height: 1.5,
          fontSize: theme.textTheme.bodySmall!.fontSize! + 0.5.sp,
        );
        // Measure whether the text overflows when limited to collapsedMaxLines
        final textSpan = TextSpan(text: widget.postContent, style: textStyle);
        final tp = TextPainter(
          text: textSpan,
          maxLines: collapsedMaxLines,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);
        final bool isOverflowing = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: ArabicTextWidget(
                text: widget.postContent,
                maxLines: _isExpanded ? 100000 : collapsedMaxLines,
                style: textStyle,
              ),
            ),
            if (isOverflowing)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: ArabicTextWidget(
                      text: _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
