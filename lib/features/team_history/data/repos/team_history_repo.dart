import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/team_history/data/models/team_rule_model.dart';
import 'package:new_slt/features/team_history/data/models/team_song_model.dart';

abstract class TeamHistoryRepo {
  Future<Either<Failure, List<TeamSongModel>>> getTeamSongs();
  Future<Either<Failure, List<TeamRuleModel>>> getTeamRules();
}
