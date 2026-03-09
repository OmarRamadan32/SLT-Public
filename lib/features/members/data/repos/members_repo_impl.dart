import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/features/members/data/repos/members_repo.dart';

class MembersRepoImpl implements MembersRepo {
  final DatabaseService db;
  MessageRepo messageRepo;
  UserRepo userRepo;
  MembersRepoImpl({
    required this.db,
    required this.messageRepo,
    required this.userRepo,
  });
  final String userCollection = BackendEndpoints.usersCollection;
  @override
  Future<Either<Failure, void>> addMembersToMainBoard({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {UserFields.userIsMainBOD: true},
            documentId: e,
          );
        }),
      );
      // update members access level
      await userRepo.updateUsersAccessLevel(
        usersIds: membersIds,
        accessLevel: 2,
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم إضافتك إلي مجلس الإدارة الأساسي",
          isPrivate: true,
        ),
        usersIds: membersIds,
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "يوجد تحديث في قائمة أعضاء مجلس الإدارة الأساسي",
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addMembersToSubBoard({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {UserFields.userIsSubBOD: true},
            documentId: e,
          );
        }),
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم إضافتك إلي مجلس الإدارة الإستشاري",
          isPrivate: true,
        ),
        usersIds: membersIds,
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: false,
          messageText: "يوجد تحديث في قائمة أعضاء مجلس الإدارة الإستشاري",
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addMembersToTheTeam({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {UserFields.userAccountType: Constants.normalMember},
            documentId: e,
          );
        }),
      );
      await messageRepo.sendMessageToUsersByIds(
        usersIds: membersIds,
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: true,
          messageText: "تم إضافتك في قائمة أعضاء فريق القادة الإجتماعيين",
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> chooseAssistantTeamLeader({
    required String newLeaderId,
  }) async {
    try {
      // get old assistant
      List<String> oldLeadersIds = await db
          .getData(
            path: userCollection,
            query: {
              'where': [
                {
                  'field': UserFields.userTitle,
                  'isEqualTo': Constants.assistantLeader,
                },
              ],
            },
          )
          .then(
            (list) =>
                list
                    .map<String>((e) => e[UserFields.userId] as String)
                    .toList(),
          );
      // change the old leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds: oldLeadersIds,
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 3,
      );
      // remove the title from him
      await Future.wait(
        oldLeadersIds
            .where((id) => id != newLeaderId)
            .map(
              (id) => db.updateData(
                path: userCollection,
                data: {UserFields.userTitle: Constants.leader},
                documentId: id,
              ),
            ),
      );
      // update the new Leader Title
      await db.updateData(
        path: userCollection,
        data: {UserFields.userTitle: Constants.assistantLeader},
        documentId: newLeaderId,
      );
      // change the new leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds: [newLeaderId],
        accessLevel: 3,
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        usersIds: [newLeaderId],
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: true,
          messageText: "تم إختيارك كمساعد قائد الفريق",
        ),
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: false,
          messageText: "تم إختيار مساعد قائد الفريق",
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> chooseViceTeamLeader({
    required String newLeaderId,
  }) async {
    try {
      // list to hold old vice Leaders
      List<String> oldLeadersIds = await db
          .getData(
            path: userCollection,
            query: {
              'where': [
                {
                  'field': UserFields.userTitle,
                  'isEqualTo': Constants.viceLeader,
                },
              ],
            },
          )
          .then(
            (list) =>
                list
                    .map<String>((e) => e[UserFields.userId] as String)
                    .toList(),
          );
      // change the old leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds: oldLeadersIds,
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 3,
      );
      // remove the title
      await Future.wait(
        oldLeadersIds
            .where((id) => id != newLeaderId)
            .map(
              (id) => db.updateData(
                path: userCollection,
                data: {UserFields.userTitle: Constants.leader},
                documentId: id,
              ),
            ),
      );
      // change the new leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds: [newLeaderId],
        accessLevel: 3,
      );
      // update the new Leader Title
      await db.updateData(
        path: userCollection,
        data: {UserFields.userTitle: Constants.viceLeader},
        documentId: newLeaderId,
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        usersIds: [newLeaderId],
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: true,
          messageText: "تم إختيارك كنائب قائد الفريق",
        ),
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          isPrivate: false,
          messageText: "تم إختيار نائب قائد الفريق",
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllMainBoardMembers() async {
    try {
      List<Map<String, dynamic>> boardMembers = await db.getData(
        path: userCollection,
        query: {
          'where': [
            {'field': UserFields.userIsMainBOD, 'isEqualTo': true},
          ],
        },
      );
      List<UserModel> boardMembersModels =
          boardMembers.map((e) => UserModel.fromJson(e)).toList();
      return Right(boardMembersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllSubBoardMembers() async {
    try {
      List<Map<String, dynamic>> boardMembers = await db.getData(
        path: userCollection,
        query: {
          'where': [
            {'field': UserFields.userIsSubBOD, 'isEqualTo': true},
          ],
        },
      );
      List<UserModel> boardMembersModels =
          boardMembers.map((e) => UserModel.fromJson(e)).toList();
      return Right(boardMembersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllTeamMembers({
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      Map<String, dynamic> query = {
        'orderBy': UserFields.userName,
        'where': [
          {
            'field': UserFields.userAccountType,
            'isEqualTo': Constants.normalMember,
          },
        ],
      };
      if (limit != null) {
        query['limit'] = limit;
      }
      if (startAfter != null) {
        query['startAfterDocument'] = startAfter;
      }
      List<Map<String, dynamic>> teamMembers = await db.getData(
        path: userCollection,
        query: query,
      );
      List<UserModel> teamMembersModels =
          teamMembers.map((e) => UserModel.fromJson(e)).toList();
      return Right(teamMembersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeAssistantTeamLeader() async {
    try {
      List<Map<String, dynamic>> oldLeadersIds = await db.getData(
        path: userCollection,
        query: {
          'where': [
            {
              'field': UserFields.userTitle,
              'isEqualTo': Constants.assistantLeader,
            },
          ],
        },
      );
      // change the old leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds:
            oldLeadersIds
                .map<String>((e) => e[UserFields.userId] as String)
                .toList(),
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 3,
      );
      if (oldLeadersIds.isNotEmpty) {
        await db.updateData(
          path: userCollection,
          data: {UserFields.userTitle: Constants.leader},
          documentId: oldLeadersIds[0][UserFields.userId],
        );
      }
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم حل مساعد قائد الفريق",
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeMembersFromMainBoard({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {UserFields.userIsMainBOD: false},
            documentId: e,
          );
        }),
      );
      // update members access level
      await userRepo.updateUsersAccessLevel(
        usersIds: membersIds,
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 2,
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم إزالتك من مجلس الإدارة الأساسي",
          isPrivate: true,
        ),
        usersIds: membersIds,
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "يوجد تحديث في قائمة أعضاء مجلس الإدارة الأساسي",
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeMembersFromSubBoard({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {UserFields.userIsSubBOD: false},
            documentId: e,
          );
        }),
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم إزالتك من مجلس الإدارة الإستشاري",
          isPrivate: true,
        ),
        usersIds: membersIds,
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "يوجد تحديث في قائمة أعضاء مجلس الإدارة الإستشاري",
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeMembersFromTheTeam({
    required List<String> membersIds,
  }) async {
    try {
      await Future.wait(
        membersIds.map((e) async {
          await db.updateData(
            path: userCollection,
            data: {
              UserFields.userAccountType: Constants.guestMember,
              UserFields.userAccessLevel: 0,
            },
            documentId: e,
          );
        }),
      );
      // private message
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم فصلك من الفريق",
          isPrivate: true,
        ),
        usersIds: membersIds,
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeViceTeamLeader() async {
    try {
      List<Map<String, dynamic>> oldLeadersIds = await db.getData(
        path: userCollection,
        query: {
          'where': [
            {'field': UserFields.userTitle, 'isEqualTo': Constants.viceLeader},
          ],
        },
      );
      // change the old leader access level
      await userRepo.updateUsersAccessLevel(
        usersIds:
            oldLeadersIds
                .map<String>((e) => e[UserFields.userId] as String)
                .toList(),
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 3,
      );
      await db.updateData(
        path: userCollection,
        data: {UserFields.userTitle: Constants.leader},
        documentId: oldLeadersIds[0][UserFields.userId],
      );
      // public message
      await messageRepo.sendMessageToAllTeam(
        messageModel: MessageModel.membersNotificationMessage(
          messageText: "تم حل نائب قائد الفريق",
          isPrivate: false,
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllTeamLeaders() async {
    List<Map<String, dynamic>> requestQuery = [
      {
        'where': [
          {'field': UserFields.userTitle, 'isEqualTo': Constants.teamLeader},
        ],
      },
      {
        'where': [
          {'field': UserFields.userTitle, 'isEqualTo': Constants.femaleLeader},
        ],
      },
      {
        'where': [
          {'field': UserFields.userTitle, 'isEqualTo': Constants.viceLeader},
        ],
      },
      {
        'where': [
          {
            'field': UserFields.userTitle,
            'isEqualTo': Constants.assistantLeader,
          },
        ],
      },
    ];

    try {
      List<UserModel> teamLeadersModels = [];
      for (var request in requestQuery) {
        List<Map<String, dynamic>> leader = await db.getData(
          path: userCollection,
          query: request,
        );
        if (leader.isNotEmpty) {
          teamLeadersModels.add(UserModel.fromJson(leader[0]));
        }
      }
      return Right(teamLeadersModels);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateMemberData({
    required UserModel userModel,
  }) async {
    try {
      db.updateData(
        path: userCollection,
        data: userModel.toJson(),
        documentId: userModel.id!,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
