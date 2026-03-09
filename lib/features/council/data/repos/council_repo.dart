import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';

abstract class CouncilRepo {
  Future<Either<Failure, List<CouncilModel>>> getAllCouncils();

  Future<Either<Failure, Swa3edModel>> getCouncilSwa3ed({
    required String councilId,
  });
  Future<Either<Failure, List<GroupModel>>> getCouncilGroups({
    required String councilId,
  });

  Future<Either<Failure, CouncilModel>> getCouncilById({
    required String councilId,
  });

  Future<Either<Failure, GroupModel>> getCouncilGroupById({
    required String councilId,
    required String groupId,
  });

  Future<Either<Failure, void>> addCouncil({
    required CouncilModel councilModel,
  });

  Future<Either<Failure, void>> addCouncilSwa3ed({
    required String councilId,
    required Swa3edModel swa3edModel,
  });

  Future<Either<Failure, void>> addCouncilGroup({
    required String councilId,
    required GroupModel groupModel,
  });
  Future<Either<Failure, void>> addGroupShield({
    required String councilId,
    required String groupId,
    required String shieldName,
  });
  // instead of taking bool (is leader number one) and make a change for every case
  // we can take the field name as a parameter and change whatever field we take
  Future<Either<Failure, void>> changeCouncilLeader({
    required String councilId,
    required String newCouncilLeaderId,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String newCouncilLeaderName,
    required String oldCouncilLeaderId
  });
  Future<Either<Failure, void>> changeCouncilSwa3edLeader({
    required String councilId,
    required String swa3edId,
    required String oldCouncilSwa3edLeaderId,
    required String newCouncilSwa3edLeaderId,
    required String newLeaderFieldName,
    required String newLeaderNameFieldName,
    required String newSwa3edLeaderName,
  });

  Future<Either<Failure, void>> changeCouncilGroupLeader({
    required String councilId,
    required String groupId,
    required String oldGroupLeaderId,
    required String newGroupLeaderId,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String newGroupLeaderName,
    required String groupName
  });
  Future<Either<Failure, void>> addGroupMembers({
    required String councilId,
    required String groupId,
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> removeGroupMembers({
    required String councilId,
    required String groupId,
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> addSwa3edMembers({
    required String councilId,
    required String swa3edId,
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> removeSwa3edMembers({
    required String councilId,
    required String swa3edId,
    required List<String> membersIds,
  });
  Future<Either<Failure, void>> endCouncil({required String councilId});
}
