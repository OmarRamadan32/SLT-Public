import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/activity_image.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/widgets/swa3eed_page_details_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class Swa3eedPage extends StatelessWidget {
  const Swa3eedPage({super.key});

  @override
  Widget build(BuildContext context) {
    CouncilCubit cubit = context.read<CouncilCubit>();
    Swa3edModel swa3ed = cubit.swa3ed!;
    final String schedulePath =
        '${BackendEndpoints.councilCollection}/${cubit.council!.id}/${BackendEndpoints.swa3edCollection}/${swa3ed.id}/${BackendEndpoints.schedulesCollection}';
    return ScreenWidget(
      isMainScreen: false,
      child: Column(
        children: [
          Spaces.inSectionSpace20,
          TitleWidget(title: "سواعد ال${swa3ed.councilNumber}"),
          Spaces.inSectionSpace20,
          ActivityImage(imageUrl: swa3ed.swa3edImage),
          Spaces.inSectionSpace20,
          const Swa3eedPageDetailsSection(),
          Spaces.sectionsSpace40,
          const TitleWidget(title: "قوة السواعد"),
          Spaces.space10,
          CirlceImageAndTitleRowWidget(usersModels: swa3ed.swa3edMembers),
          Spaces.sectionsSpace40,
          ScheduleFeature(
            authorizedUsers: [
              swa3ed.swa3edLeaderId,
              swa3ed.swa3edLeaderTwoId,
              ...swa3ed.swa3edMembers.map((e) => e.id!),
            ],
            path: schedulePath,
          ),
        ],
      ),
    );
  }
}
