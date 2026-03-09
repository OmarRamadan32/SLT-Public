import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/members/presentation/cubit/members_cubit.dart';
import 'package:new_slt/features/members/presentation/widgets/team_leaders_board_leader.dart';

class TeamLeadersBoard extends StatelessWidget {
  const TeamLeadersBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> teamLeaders =
        context.read<MembersCubit>().teamLeaders;
    if (teamLeaders.isEmpty) {
      return const SizedBox();
    } else {
      return ExpandablePageView.builder(
        animationDuration: const Duration(milliseconds: 500),
        controller: PageController(
          viewportFraction: teamLeaders.length < 2 ? 1 : 0.92,
        ),
        animateFirstPage: true,
        padEnds: false,
        alignment: Alignment.center,
        itemCount: teamLeaders.length,
        itemBuilder:
            (context, index) => Padding(
              padding: EdgeInsets.only(
                right: teamLeaders.length > 1 ? 10.w : 0,
              ),
              child: TeamLeadersBoardCard(
                leaderImage: teamLeaders[index].imageUrl,
                leaderName: teamLeaders[index].name,
                leaderTitle: teamLeaders[index].title,
              ),
            ),
      );
    }
  }
}
