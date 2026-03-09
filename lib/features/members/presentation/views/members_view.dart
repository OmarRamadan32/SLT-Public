import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/features/members/presentation/cubit/members_cubit.dart';
import 'package:new_slt/features/members/presentation/views/members_loading_view.dart';
import 'package:new_slt/features/members/presentation/widgets/members_page_all_members_section.dart';
import 'package:new_slt/features/members/presentation/widgets/members_page_board_section.dart';
import 'package:new_slt/features/members/presentation/widgets/members_page_sub_board_section.dart';
import 'package:new_slt/features/members/presentation/widgets/team_leaders_board.dart';

class MembersView extends StatefulWidget {
  const MembersView({super.key});

  @override
  State<MembersView> createState() => _MembersViewState();
}

class _MembersViewState extends State<MembersView> {
  @override
  void initState() {
    context.read<MembersCubit>().getAllMembersMethod(append: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembersCubit, MembersState>(
      builder: (context, state) {
        MembersCubit cubit = context.read<MembersCubit>();
        if (state is MembersLoadingState) {
          return const MembersLoadingView();
        } else if (state is MembersErrorState) {
          return ErrorMessageWidget(message: state.errorMessage);
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Spaces.inSectionSpace20,
                const TeamLeadersBoard(),
                Spaces.sectionsSpace40,
                MembersPageBoardSection(usersModels: cubit.mainBoardMembers),
                Spaces.sectionsSpace40,
                MembersPageSubBoardSection(usersModels: cubit.subBoardMembers),
                Spaces.sectionsSpace40,
                MembersPageAllMembersSection(state: state),
                Spaces.screenLastItemSpace70,
              ],
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is MembersErrorState) {
          Helpers.showSnackBar(context, state.errorMessage);
        }
        if (state is MembersNoMoreState) {
          Helpers.showSnackBar(context, "تم عرض جميع أعضاء الفريق");
        }
      },
    );
  }
}
