import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/team_history/presentation/cubit/team_history_cubit.dart';
import 'package:new_slt/features/team_history/presentation/views/team_history_loading_view.dart';
import 'package:new_slt/features/team_history/presentation/widgets/team_history_page_rules_section.dart';
import 'package:new_slt/features/team_history/presentation/widgets/team_history_page_songs_section.dart';
import 'package:new_slt/features/team_history/presentation/widgets/team_history_page_tabbar_section.dart';

class TeamHistoryPage extends StatefulWidget {
  const TeamHistoryPage({super.key});

  @override
  State<TeamHistoryPage> createState() => _TeamHistoryPageState();
}

class _TeamHistoryPageState extends State<TeamHistoryPage> {
  @override
  void initState() {
    context.read<TeamHistoryCubit>().getTeamHistory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TeamHistoryCubit teamHistoryCubit = context.read<TeamHistoryCubit>();
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      animationDuration: const Duration(milliseconds: 500),
      child: ScreenWidget(
        hasDrawer: false,
        isMainScreen: false,
        child: BlocBuilder<TeamHistoryCubit, TeamHistoryState>(
          builder: (context, state) {
            if (state is TeamHistoryLoadingState) {
              return const TeamHistoryLoadingView();
            } else if (state is TeamHistoryErrorState) {
              return ErrorMessageWidget(
                message: state.message,
                isCentered: true,
              );
            } else {
              return Column(
                children: [
                  Spaces.inSectionSpace20,
                  const TeamHistoryPageTabBarSection(),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      thickness: 0.5,
                    ),
                  ),
                  Spaces.inSectionSpace20,
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const EmptyViewWidget(
                          message: ".حكاوي القادة غير متاحة بعد.",
                        ),
                        TeamHistoryPageRulesSection(
                          rules: teamHistoryCubit.teamRules,
                        ),
                        TeamHistoryPageSongsSection(
                          songs: teamHistoryCubit.teamSongs,
                        ),

                        const EmptyViewWidget(
                          message: ".رسائل الخريجين غير متاحة بعد",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
