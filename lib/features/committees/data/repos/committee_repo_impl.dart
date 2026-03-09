import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/features/committees/data/models/committee_fields.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo.dart';

class CommitteeRepoImpl implements CommitteeRepo {
  DatabaseService db;
  UserRepo userRepo;
  MessageRepo messageRepo;
  final String committeeCollection = BackendEndpoints.committeesCollection;
  CommitteeRepoImpl({
    required this.db,
    required this.userRepo,
    required this.messageRepo,
  });

  @override
  Future<Either<Failure, void>> addCommittee({
    required CommitteeModel committeeModel,
  }) async {
    try {
      // add committee
      await db.addData(
        path: committeeCollection,
        data: committeeModel.toJson(),
      );
      // change leader access level
      userRepo.updateUsersAccessLevel(
        usersIds: [committeeModel.committeeLeaderId!],
        accessLevel: 1,
      );
      // send notification
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          activityName: committeeModel.committeeName,
          appNotificationsMessages: AppNotificationsMessages.eventLeader,
        ),
        usersIds: [committeeModel.committeeLeaderId!],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<CommitteeModel>>> getAllCommittees() async {
    try {
      final List<Map<String, dynamic>> data = await db.getData(
        path: committeeCollection,
      );

      final committees = await Future.wait(
        data.map((map) async {
          var membersIds = map[CommitteeFields.committeeMembers];
          // convert UserIds to List of UserModel
          var committeeMembers = await userRepo.getUsersByIds(membersIds);
          committeeMembers.fold(
            (err) {
              map[CommitteeFields.committeeMembers] = [];
            },
            (users) {
              map[CommitteeFields.committeeMembers] = users;
            },
          );
          return CommitteeModel.fromJson(map);
        }),
      );

      return Right(committees);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeCommitteeLeader({
    required String newLeaderId,
    required String newLeaderName,
    required String committeeId,
    required String committeeName,
    required String oldLeaderId,
  }) async {
    try {
      // update committee leader
      await db.updateData(
        path: committeeCollection,
        data: {
          CommitteeFields.committeeLeaderId: newLeaderId,
          CommitteeFields.committeeLeaderName: newLeaderName,
        },
        documentId: committeeId,
      );
      // change leaders access level
      // old leader
      userRepo.updateUsersAccessLevel(
        usersIds: [oldLeaderId],
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 1,
      );
      // new leader
      userRepo.updateUsersAccessLevel(usersIds: [newLeaderId], accessLevel: 1);
      // send notification
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.eventLeader,
          activityName: committeeName,
        ),
        usersIds: [newLeaderId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, CommitteeModel>> getCommitteById({
    required String committeeId,
  }) async {
    try {
      Map<String, dynamic> committee = await db.getData(
        path: committeeCollection,
        docuementId: committeeId,
      );
      var committeeMembers = await userRepo.getUsersByIds(
        committee[CommitteeFields.committeeMembers],
      );
      committee[CommitteeFields.committeeMembers] = committeeMembers.fold(
        (err) => [],
        (users) => users,
      );
      return Right(CommitteeModel.fromJson(committee));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateCommitteeDetails({
    required CommitteeModel committeeModel,
    required String committeeId,
  }) async {
    try {
      await db.updateData(
        path: committeeCollection,
        data: committeeModel.toJsonForUpdate(),
        documentId: committeeId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  // -- Committee Members Section
  @override
  Future<Either<Failure, List<UserModel>>> getCommitteMembers({
    required String committeeId,
  }) async {
    try {
      var data = await db.getData(
        path: committeeCollection,
        docuementId: committeeId,
      );
      final List membersIds = data[CommitteeFields.committeeMembers];
      var members = await userRepo.getUsersByIds(membersIds);
      return members.fold(
        (err) => Left(ServerFailure.fromException(err)),
        (users) => Right(users),
      );
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addCommitteeMembers({
    required List<String> membersIDSList,
    required String committeeId,
    required String committeeName,
  }) async {
    try {
      await db.updateData(
        path: committeeCollection,
        data: {
          CommitteeFields.committeeMembers: FieldValue.arrayUnion(
            membersIDSList,
          ),
        },
        documentId: committeeId,
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.addedToEvent,
          activityName: committeeName,
        ),
        usersIds: membersIDSList,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeCommitteeMembers({
    required String committeeName,
    required List<String> membersIDSList,
    required String committeeId,
  }) async {
    try {
      await db.updateData(
        path: committeeCollection,
        data: {
          CommitteeFields.committeeMembers: FieldValue.arrayRemove(
            membersIDSList,
          ),
        },
        documentId: committeeId,
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.removedFromEvent,
          activityName: committeeName,
        ),
        usersIds: membersIDSList,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
