import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/posts/data/models/content_page_model.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';

class PostCardShowCommentsButton extends StatelessWidget {
  const PostCardShowCommentsButton({required this.postModel, super.key});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        context.read<PostsCubit>().currentPost = postModel;
        GoRouter.of(context).push(
          "${AppRouter.kPostPage}/${postModel.postId}",
          extra: ContentPageModel(
            contentAuthorID: postModel.postAuthorId,
            contentDate: postModel.postDate,
            contentAuthorName: postModel.postAuthorName ?? "بدون اسم",
            contentAuthorImage: postModel.postAuthorImage ?? "",
            contentText: postModel.postContent,
            postImages: postModel.postImages,
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: ArabicTextWidget(
                  text: "التعليقات",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.textTheme.labelLarge!.color,
                  ),
                ),
              ),
              SizedBox(width: 7.w),
              FaIcon(
                FontAwesomeIcons.solidComments,
                color: theme.textTheme.labelLarge!.color,
                size: 15.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
