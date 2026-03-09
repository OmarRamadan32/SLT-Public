import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SpecialPostCardButtons extends StatelessWidget {
  const SpecialPostCardButtons({
    super.key,
    required this.postModel,
    required this.isSigned,
  });
  final PostModel postModel;
  final bool isSigned;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              backgroundColor: theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () async {
              context.read<PostsCubit>().currentPost = postModel; //!
              context.push(AppRouter.kSpecialPostPage, extra: postModel);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Center(
                child: ArabicTextWidget(
                  text: "عرض البوست",
                  style: theme.textTheme.bodySmall!.copyWith(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.zero,
              backgroundColor:
                  isSigned ? theme.scaffoldBackgroundColor : theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () async {
              var postCubit = context.read<PostsCubit>();
              await postCubit.signSpost(
                postId: postModel.postId!,
                userId: context.read<UserCubit>().userModel!.id!,
              );
              await postCubit.getApprovedPosts();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Center(
                child: ArabicTextWidget(
                  text: isSigned ? "إلغاء التسجيل" : "التسجيل في البوست",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: isSigned ? theme.primaryColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
