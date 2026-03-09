import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';

abstract class MembersRepo {
      Future<Either<Failure, void>> updateMemberData({
    required UserModel userModel
  });
  //-- MainBoard
  Future<Either<Failure, void>> addMembersToMainBoard({
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> removeMembersFromMainBoard({
    required List<String> membersIds,
  });
  //-- SubBoard
  Future<Either<Failure, void>> addMembersToSubBoard({
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> removeMembersFromSubBoard({
    required List<String> membersIds,
  });
  //-- Team Members
  Future<Either<Failure, void>> addMembersToTheTeam({
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> removeMembersFromTheTeam({
    required List<String> membersIds,
  });
  //-- Leaders
  Future<Either<Failure, void>> chooseViceTeamLeader({
    required String newLeaderId,
  });
  Future<Either<Failure, void>> chooseAssistantTeamLeader({
    required String newLeaderId,
  });
  Future<Either<Failure, void>> removeViceTeamLeader();
  Future<Either<Failure, void>> removeAssistantTeamLeader();
  //-- Fetch Members
  Future<Either<Failure, List<UserModel>>> getAllTeamMembers({
    int? limit,
    dynamic startAfter,
  });
  Future<Either<Failure, List<UserModel>>> getAllMainBoardMembers();
  Future<Either<Failure, List<UserModel>>> getAllSubBoardMembers();
  Future<Either<Failure, List<UserModel>>> getAllTeamLeaders();
}
