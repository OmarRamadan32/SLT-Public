import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/features/team_history/data/models/team_rule_model.dart';
import 'package:new_slt/features/team_history/data/models/team_song_model.dart';
import 'package:new_slt/features/team_history/data/repos/team_history_repo.dart';

class TeamHistoryRepoImpl implements TeamHistoryRepo {
  final DatabaseService db;
  TeamHistoryRepoImpl({required this.db});
  static final String teamSongsCollection =
      BackendEndpoints.teamSongsCollection;
  static final String teamRulesCollection =
      BackendEndpoints.teamRulesCollection;
  @override
  Future<Either<Failure, List<TeamRuleModel>>> getTeamRules() async {
    try {
      final List<Map<String, dynamic>> rules = await db.getData(
        path: teamRulesCollection,
      );
      return Right(rules.map((e) => TeamRuleModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<TeamSongModel>>> getTeamSongs() async {
    try {
      final List<Map<String, dynamic>> songs = await db.getData(
        path: teamSongsCollection,
      );
      return Right(songs.map((e) => TeamSongModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
