import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';

class PostCardPendingPostMessage extends StatelessWidget {
  const PostCardPendingPostMessage({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    if (postModel.pending) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ArabicTextWidget(
                text: 'معلق',
                style: TextStyle(color: Colors.redAccent),
              ),
              postModel.isSpecialPost
                  ? SizedBox(height: 8.h)
                  : const SizedBox(),
              postModel.isSpecialPost
                  ? Column(
                    children: [
                      ArabicTextWidget(
                        text: 'بوست بخاصية التسجيل',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                  : const SizedBox(),
            ],
          ),
          Spaces.space10,
          SizedBox(
            width: 125.w,
            child: Divider(color: Theme.of(context).primaryColor, thickness: 1),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
