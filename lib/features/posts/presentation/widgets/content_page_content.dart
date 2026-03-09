import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ContentPageContent extends StatefulWidget {
  const ContentPageContent({
    super.key,
    required this.postContent,
    this.maxLines,
  });

  final String postContent;
  final int? maxLines;

  @override
  State<ContentPageContent> createState() => _ContentPageContentState();
}

class _ContentPageContentState extends State<ContentPageContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int collapsedMaxLines = widget.maxLines ?? 7;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = theme.textTheme.bodyMedium!.copyWith(height: 1.5);
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
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: ArabicTextWidget(
                      text: _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                      style: theme.textTheme.labelSmall,
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
