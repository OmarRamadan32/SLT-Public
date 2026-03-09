import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/team_history/data/models/team_rule_model.dart';
import 'package:new_slt/features/team_history/data/models/team_song_model.dart';
import 'package:new_slt/features/team_history/data/repos/team_history_repo.dart';

part 'team_history_state.dart';

class TeamHistoryCubit extends Cubit<TeamHistoryState> {
  TeamHistoryCubit({required this.teamHistoryRepo})
    : super(TeamHistoryInitial());
  final TeamHistoryRepo teamHistoryRepo;

  final List<TeamSongModel> teamSongs = [];
  final List<TeamRuleModel> teamRules = [];

  Future<void> getTeamSongs() async {
    emit(TeamHistoryLoadingState());
    final result = await teamHistoryRepo.getTeamSongs();
    result.fold((l) => emit(TeamHistoryErrorState(message: l.message)), (r) {
      teamSongs.addAll(r);
      emit(TeamHistorySuccessState());
    });
  }

  Future<void> getTeamRules() async {
    emit(TeamHistoryLoadingState());
    final result = await teamHistoryRepo.getTeamRules();
    result.fold((l) => emit(TeamHistoryErrorState(message: l.message)), (r) {
      teamRules.addAll(r);
    });
  }

  Future<void> getTeamHistory() async {
 await   getTeamRules();
  await  getTeamSongs();
  }
}
