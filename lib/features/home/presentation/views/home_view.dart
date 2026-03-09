import 'package:flutter/material.dart';
import 'package:new_slt/features/highlight_feature/presentation/view/highlight_feature.dart';
import 'package:new_slt/features/messages/presentation/views/messages_view.dart';
import 'package:new_slt/features/posts/presentation/view/posts_feature.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HighlightFeature(),
          const MessagesView(),
          const ScheduleFeature(
            isPublicSchedule: true,
            path: BackendEndpoints.schedulesCollection,
          ),
          Spaces.inSectionSpace20,
          const PostsFeature(),
          Spaces.screenLastItemSpace70,
          Spaces.space10,
        ],
      ),
    );
  }
}
