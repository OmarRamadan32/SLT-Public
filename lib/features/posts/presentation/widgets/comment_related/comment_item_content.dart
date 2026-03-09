import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CommentItemContent extends StatefulWidget {
  const CommentItemContent({
    super.key,
    required this.commentContent,
    required this.isAuthor,
  });
  final String commentContent;
  final bool isAuthor;

  @override
  State<CommentItemContent> createState() => _CommentItemContentState();
}

class _CommentItemContentState extends State<CommentItemContent> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int collapsedMaxLines = 3;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = theme.textTheme.bodyMedium!.copyWith(height: 1.5);
        // Measure whether the text overflows when limited to collapsedMaxLines
        final textSpan = TextSpan(
          text: widget.commentContent,
          style: textStyle,
        );
        final tp = TextPainter(
          text: textSpan,
          maxLines: collapsedMaxLines,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: constraints.maxWidth);
        final bool isOverflowing = tp.didExceedMaxLines;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              child: ArabicTextWidget(
                text: widget.commentContent,
                maxLines: _isExpanded ? 100000 : collapsedMaxLines,
                style: textStyle.copyWith(
                  fontSize: theme.textTheme.bodySmall!.fontSize! + 1,
                  color:
                      widget.isAuthor
                          ? Colors.white
                          : theme.textTheme.bodySmall!.color,
                  height: 1.5,
                ),
              ),
            ),
            if (isOverflowing)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: ArabicTextWidget(
                      text: _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                      style: theme.textTheme.labelSmall!.copyWith(
                        color:
                            widget.isAuthor
                                ? Colors.black87
                                : theme.textTheme.labelSmall!.color,
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
