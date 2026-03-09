import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/core/widgets/membership_check_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/members/presentation/cubit/members_cubit.dart';
import 'package:new_slt/features/members/presentation/widgets/team_member_card.dart';

class MembersPageAllMembersSection extends StatelessWidget {
  const MembersPageAllMembersSection({super.key, required this.state});

  final MembersState state;

  @override
  Widget build(BuildContext context) {
    MembersCubit cubit = context.read<MembersCubit>();
    return Column(
      children: [
        const TitleWidget(title: "جميع الأعضاء"),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 100.w,
            child: Divider(
              thickness: 1.h,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Spaces.space10,
        MembershipCheckView(
          view: Column(
            children: [
              ListView.builder(
                itemBuilder:
                    (context, index) =>
                        TeamMemberCard(userModel: cubit.teamMembers[index]),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.teamMembers.length,
              ),
              LoadMoreWidget(
                onTap: () {
                  cubit.getAllTeamMembers(
                    startAfter: cubit.teamMembers.last.id,
                    append: true,
                  );
                },
                isLoading: state is MembersLoadingMoreState,
                isDone: state is MembersNoMoreState,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
