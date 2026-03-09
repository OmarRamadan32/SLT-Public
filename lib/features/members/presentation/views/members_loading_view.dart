import 'package:flutter/material.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/members/presentation/widgets/members_page_board_section.dart';
import 'package:new_slt/features/members/presentation/widgets/team_leaders_board_leader.dart';
import 'package:new_slt/features/members/presentation/widgets/team_member_card.dart';

class MembersLoadingView extends StatelessWidget {
  const MembersLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Spaces.inSectionSpace20,
          const SkeletonLoadingView(
            card: TeamLeadersBoardCard(
              leaderImage: "",
              leaderName: "عمرو فرج",
              leaderTitle: "قائد الفريق",
            ),
            cardsCount: 1,
          ),
          Spaces.inSectionSpace20,
          SkeletonLoadingView(
            cardsCount: 1,
            card: MembersPageBoardSection(
              usersModels: [
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
              ],
            ),
          ),
          Spaces.inSectionSpace20,
          SkeletonLoadingView(
            cardsCount: 1,
            card: MembersPageBoardSection(
              usersModels: [
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
                UserModel.fakeModel(),
              ],
            ),
          ),
          Spaces.sectionsSpace40,
          const SkeletonLoadingView(
            card: TitleWidget(title: "اعضاء الفريق"),
            cardsCount: 1,
          ),
          ListView.builder(
            itemBuilder:
                (context, index) => SkeletonLoadingView(
                  cardsCount: 1,
                  card: TeamMemberCard(userModel: UserModel.fakeModel()),
                ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
