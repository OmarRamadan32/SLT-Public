import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/widgets/add_post_buttons.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card.dart';

class PostLoadingView extends StatelessWidget {
  const PostLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoadingView(
      cardsCount: 1,
      card: Column(
        children: [
          const AddPostButtons(),
          Spaces.inSectionSpace20,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder:
                (context, index) => PostCard(postModel: PostModel.fakeModel()),
          ),
        ],
      ),
    );
  }
}
