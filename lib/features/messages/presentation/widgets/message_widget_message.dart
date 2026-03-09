import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MessageWidgetText extends StatefulWidget {
  const MessageWidgetText({
    super.key,
    required this.message,
    required this.isPrimary,
  });
  final String message;
  final bool isPrimary;

  @override
  State<MessageWidgetText> createState() => _MessageWidgetTextState();
}

class _MessageWidgetTextState extends State<MessageWidgetText> {
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
          text: widget.message,
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
                text: widget.message,
                maxLines: _isExpanded ? 100000 : collapsedMaxLines,
                style: textStyle.copyWith(
                  fontSize: theme.textTheme.bodySmall!.fontSize! + 1,
                  color:
                      widget.isPrimary
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
                            widget.isPrimary
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
