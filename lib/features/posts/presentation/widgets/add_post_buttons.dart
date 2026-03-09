import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/widgets/add_post_button.dart';

class AddPostButtons extends StatelessWidget {
  const AddPostButtons({super.key});

  @override
  Widget build(BuildContext context) {
    PostsCubit postsCubit = context.read<PostsCubit>();
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AddPostButton(
            onPressed: () async {
              await context.push(AppRouter.kAddPostAdminPage);
              await postsCubit.getApprovedPosts(
                limit: 5,
              ); // to fetch new post when the user come back
            },
            isPrimaryButton: false,
            text: "كتابة بوست",
            icon: FontAwesomeIcons.solidNewspaper,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: AddPostButton(
            onPressed: () async {
              await context.push(AppRouter.kAddSpecialPostAdminPage);
              await postsCubit.getApprovedPosts(
                limit: 5,
              ); // to fetch new post when the user come back
            },
            isPrimaryButton: true,
            text: "كتابة بوست للتسجيل",
            icon: FontAwesomeIcons.filePen,
          ),
        ),
      ],
    );
  }
}
