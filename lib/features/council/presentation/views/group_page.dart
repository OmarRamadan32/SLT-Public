import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/cards/simple_title_card.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/campaigns/presentation/views/activity_page_loading_view.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/widgets/group_details_section.dart';
import 'package:new_slt/features/council/presentation/widgets/group_leaders_row_widget.dart';
import 'package:new_slt/features/council/presentation/widgets/group_name_widget.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key, required this.groupId});
  final String groupId;
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    context.read<CouncilCubit>().getCouncilGroupById(groupId: widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      isMainScreen: false,
      child: SingleChildScrollView(
        child: BlocBuilder<CouncilCubit, CouncilState>(
          builder: (context, state) {
            if (state is CouncilLoadingState) {
              return const ActivityPageLoadingView();
            } else if (state is CouncilErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              final GroupModel group = context.read<CouncilCubit>().group!;
              return Column(
                children: [
                  Spaces.inSectionSpace20,
                  const GroupNameAndImageSection(),
                  Spaces.sectionsSpace40,
                  const GroupDetailsSection(),
                  Spaces.sectionsSpace40,
                  const GroupLeadersDetailsRowSection(isCurrentCouncil: false),
                  Spaces.sectionsSpace40,
                  const TitleWidget(title: "المرشحين"),
                  Spaces.space10,
                  CirlceImageAndTitleRowWidget(usersModels: group.groupMembers),
                  Spaces.sectionsSpace40,
                  const TitleWidget(title: "الدروع"),
                  Spaces.space10,
                  ...List.generate(group.groupShields.length, (index) {
                    return Column(
                      children: [
                        SimpleTitleCard(cardText: group.groupShields[index]),
                        Spaces.inSectionSpace20,
                      ],
                    );
                  }),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
