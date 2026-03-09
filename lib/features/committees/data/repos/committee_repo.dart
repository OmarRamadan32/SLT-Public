import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';

abstract class CommitteeRepo {
  Future<Either<Failure, List<CommitteeModel>>> getAllCommittees();
  // will be used only in DashBoard for changing Committee Details such as name, Description and image
  Future<Either<Failure, CommitteeModel>> getCommitteById({
    required String committeeId
  });
  // will only be Used in Dashboard to add or delete Committee Members
   Future<Either<Failure, List<UserModel>>> getCommitteMembers({
    required String committeeId
  });

  Future<Either<Failure, void>> addCommittee({
    required CommitteeModel committeeModel,
  });
  Future<Either<Failure, void>> updateCommitteeDetails({
    required CommitteeModel committeeModel,
        required String committeeId
  });
  Future<Either<Failure, void>> changeCommitteeLeader({
    required String newLeaderId,
        required String committeeId,
        required String newLeaderName,
    required String committeeName,
    required String oldLeaderId
  });

    Future<Either<Failure, void>> addCommitteeMembers({
    required List<String> membersIDSList,
    required String committeeId,
        required String committeeName
  });

      Future<Either<Failure, void>> removeCommitteeMembers({
    required List<String> membersIDSList,
        required String committeeId,
                required String committeeName
  });

}
