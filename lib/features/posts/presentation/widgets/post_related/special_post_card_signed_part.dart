import 'package:flutter/material.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SpecialPostCardSignedPart extends StatelessWidget {
  const SpecialPostCardSignedPart({super.key, required this.postModel});

  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 5),
        Text(
          "${postModel.specialPostSigners!.length}",
          style: theme.textTheme.labelSmall,
        ),
        ArabicTextWidget(
          text: "قاموا بالتسجيل: ",
          style: theme.textTheme.labelSmall,
        ),
        const Spacer(),
        Text(
          "${postModel.specialPostSignersMaxCount! - postModel.specialPostSigners!.length}",
          style: theme.textTheme.labelSmall,
        ),
        ArabicTextWidget(
          text: "عدد التسجيلات المتبقية: ",
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
