import 'package:flutter/material.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/special_post_card.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key, required this.posts});

  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            if (posts[index].isSpecialPost) {
              return SpecialPostCard(postModel: posts[index]);
            } else {
              return PostCard(postModel: posts[index]);
            }
          },
        ),
      ],
    );
  }
}
