import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/features/council/data/models/council_fields.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/data/models/group_fields.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/data/models/swa3ed_fields.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/features/council/data/repos/council_repo.dart';
// Notes:
// in change council leader, the old leader title won't change
// the council leaders is not on council members Ids list, its only for swa3ed and groups
class CouncilRepoImpl implements CouncilRepo {
  DatabaseService db;
  UserRepo userRepo;
  MessageRepo messageRepo;
  final String councilCollection = BackendEndpoints.councilCollection;
  final String groupsCollection = BackendEndpoints.groupsCollection;
  final String swa3edCollection = BackendEndpoints.swa3edCollection;

  CouncilRepoImpl({
    required this.db,
    required this.userRepo,
    required this.messageRepo,
  });
  // Add Methods
  @override
  Future<Either<Failure, void>> addCouncil({
    required CouncilModel councilModel,
  }) async {
    try {
      // make the past council is current = false
      String pastCouncilId = await db
          .getData(
            path: councilCollection,
            query: {
              'where': [
                {'field': CouncilFields.isCurrent, 'isEqualTo': true},
              ],
            },
          )
          .then((value) {
            return value[0][CouncilFields.id] as String;
          });
      await db.updateData(
        path: councilCollection,
        data: {CouncilFields.isCurrent: false},
        documentId: pastCouncilId,
      );
      // change the councilLeader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: councilModel.councilLeaderId,
        data: {UserFields.userTitle: Constants.leader},
      );
      // add the Council
      await db.addData(path: councilCollection, data: councilModel.toJson());
      // send notification to Council Leaders
      if (councilModel.councilLeaderTwoId != null) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.namedLeader,
            activityName: "المجلس ال${councilModel.councilNumber}",
          ),
          usersIds: [
            councilModel.councilLeaderId,
            councilModel.councilLeaderTwoId!,
          ],
        );
        // update council leaders access levels
        await userRepo.updateUsersAccessLevel(
          usersIds: [
            councilModel.councilLeaderId,
            councilModel.councilLeaderTwoId!,
          ],
          accessLevel: 3,
        );
      } else {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.namedLeader,
            activityName: "المجلس ال${councilModel.councilNumber}",
          ),
          usersIds: [councilModel.councilLeaderId],
        );
        // update council leaders access levels
        await userRepo.updateUsersAccessLevel(
          usersIds: [councilModel.councilLeaderId],
          accessLevel: 3,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addCouncilGroup({
    required String councilId,
    required GroupModel groupModel,
  }) async {
    try {
      // a list to hold group Leaders
      final List<String> groupLeaders = [
        groupModel.groupCaptainId,
        groupModel.groupFemaleLeaderId,
        groupModel.groupLeaderId,
      ];
      // add the Council group
      await db.addData(
        path: '$councilCollection/$councilId/$groupsCollection',
        data: groupModel.toJson(),
      );
      // add council group Leaders to Council Members Ids
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayUnion(groupLeaders),
        },
        documentId: councilId,
      );
      // update group leaders titles
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: groupModel.groupFemaleLeaderId,
        data: {UserFields.userTitle: Constants.female},
      );
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: groupModel.groupLeaderId,
        data: {UserFields.userTitle: Constants.leader},
      );
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: groupModel.groupCaptainId,
        data: {UserFields.userTitle: Constants.captain},
      );
      // send message to group captain
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedCaptain,
          activityName: "المجموعة ${groupModel.groupName}",
        ),
        usersIds: [groupModel.groupCaptainId],
      );
      // send message to group female leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedFemaleLeader,
          activityName: "المجموعة ${groupModel.groupName}",
        ),
        usersIds: [groupModel.groupFemaleLeaderId],
      );
      // send message to group leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedLeader,
          activityName: "المجموعة ${groupModel.groupName}",
        ),
        usersIds: [groupModel.groupLeaderId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addCouncilSwa3ed({
    required String councilId,
    required Swa3edModel swa3edModel,
  }) async {
    try {
      // a list to hold swa3ed Leaders
      List<String> swa3edLeaders = [
        swa3edModel.swa3edLeaderId,
        swa3edModel.swa3edLeaderTwoId,
      ];
      // add swa3ed
      await db.addData(
        path: '$councilCollection/$councilId/$swa3edCollection',
        data: swa3edModel.toJson(),
      );
      // add swa3ed Leaders to Council Members Ids
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayUnion(swa3edLeaders),
        },
        documentId: councilId,
      );
      // update swa3ed leaders titles
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: swa3edModel.swa3edLeaderId,
        data: {UserFields.userTitle: Constants.leader},
      );
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: swa3edModel.swa3edLeaderTwoId,
        data: {UserFields.userTitle: Constants.female},
      );
      // send message to swa3ed leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedLeader,
          activityName: "سواعد ال${swa3edModel.councilNumber}",
        ),
        usersIds: [swa3edModel.swa3edLeaderId],
      );
      // send message to swa3ed Female leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedFemaleLeader,
          activityName: "سواعد ال${swa3edModel.councilNumber}",
        ),
        usersIds: [swa3edModel.swa3edLeaderTwoId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addGroupShield({
    required String councilId,
    required String groupId,
    required String shieldName,
  }) async {
    try {
      await db.updateData(
        path: '$councilCollection/$councilId/$groupsCollection',
        data: {
          GroupFields.groupShields: FieldValue.arrayUnion([shieldName]),
        },
        documentId: groupId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addGroupMembers({
    required String councilId,
    required String groupId,
    required List<String> membersIds,
  }) async {
    try {
      // add the members to the group
      await db.updateData(
        path: "$councilCollection/$councilId/$groupsCollection",
        documentId: groupId,
        data: {GroupFields.groupMembers: FieldValue.arrayUnion(membersIds)},
      );
      // change the group members account type
      for (String member in membersIds) {
        await db.updateData(
          path: BackendEndpoints.usersCollection,
          data: {UserFields.userAccountType: Constants.newMember},
          documentId: member,
        );
      }
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.addedToEvent,
          activityName: "مجموعتك",
        ),
        usersIds: membersIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addSwa3edMembers({
    required String councilId,
    required String swa3edId,
    required List<String> membersIds,
  }) async {
    try {
      await db.updateData(
        path: "$councilCollection/$councilId/$swa3edCollection",
        documentId: swa3edId,
        data: {Swa3edFields.swa3edMembers: FieldValue.arrayUnion(membersIds)},
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.addedToEvent,
          activityName: "السواعد",
        ),
        usersIds: membersIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  // Change Methods
  @override
  Future<Either<Failure, void>> changeCouncilGroupLeader({
    required String councilId,
    required String groupId,
    required String oldGroupLeaderId,
    required String newGroupLeaderId,
    required String newGroupLeaderName,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String groupName,
  }) async {
    try {
      // remove the old leader from CouncilMembers
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayRemove([
            oldGroupLeaderId,
          ]),
        },
        documentId: councilId,
      );
      // update the groupLeaderId
      await db.updateData(
        path: '$councilCollection/$councilId/$groupsCollection',
        data: {
          newLeaderIdFieldName: newGroupLeaderId,
          newLeaderNameFieldName: newGroupLeaderName,
        },
        documentId: groupId,
      );
      // add the new leader id to the CouncilMembers List
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayUnion([
            newGroupLeaderId,
          ]),
        },
        documentId: councilId,
      );
      // update the new leader title
      //1 - feth old leader data to get the tilte
      Map<String, dynamic> oldLeaderData = await db.getData(
        path: BackendEndpoints.usersCollection,
        docuementId: oldGroupLeaderId,
      );
      String oldLeaderTitle = oldLeaderData[UserFields.userTitle];
      //2 - update the new leader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: newGroupLeaderId,
        data: {UserFields.userTitle: oldLeaderTitle},
      );
      // remove the old leader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: oldGroupLeaderId,
        data: {UserFields.userTitle: Constants.normalMember},
      );
      // send notification to the new leader
      if (newLeaderNameFieldName == GroupFields.groupLeaderName) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            activityName: "المجموعة $groupName",
            appNotificationsMessages: AppNotificationsMessages.namedLeader,
          ),
          usersIds: [newGroupLeaderId],
        );
      } else if (newLeaderNameFieldName == GroupFields.groupFemaleLeaderName) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            activityName: "المجموعة $groupName",
            appNotificationsMessages:
                AppNotificationsMessages.namedFemaleLeader,
          ),
          usersIds: [newGroupLeaderId],
        );
      } else if (newLeaderNameFieldName == GroupFields.groupCaptainName) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            activityName: "المجموعة $groupName",
            appNotificationsMessages: AppNotificationsMessages.namedCaptain,
          ),
          usersIds: [newGroupLeaderId],
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeCouncilLeader({
    required String councilId,
    required String newCouncilLeaderId,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String newCouncilLeaderName,
    required String oldCouncilLeaderId,
  }) async {
    try {
      // update the council data
      await db.updateData(
        path: councilCollection,
        data: {
          newLeaderIdFieldName: newCouncilLeaderId,
          newLeaderNameFieldName: newCouncilLeaderName,
        },
        documentId: councilId,
      );
      // update the new leader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: newCouncilLeaderId,
        data: {UserFields.userTitle: Constants.leader},
      );
      // update the old leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 0,
        usersIds: [oldCouncilLeaderId],
        downgrade: true,
        downgradeFrom: 3,
      );
      // update the new leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 3,
        usersIds: [newCouncilLeaderId],
      );
      // send notification to the new leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.namedLeader,
          activityName: "المجلس",
        ),
        usersIds: [newCouncilLeaderId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeCouncilSwa3edLeader({
    required String councilId,
    required String swa3edId,
    required String oldCouncilSwa3edLeaderId,
    required String newCouncilSwa3edLeaderId,
    required String newLeaderFieldName,
    required String newLeaderNameFieldName,
    required String newSwa3edLeaderName,
  }) async {
    try {
      // remove the old Leader from council Members Ids
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayRemove([
            oldCouncilSwa3edLeaderId,
          ]),
        },
        documentId: councilId,
      );
      // change the swa3ed Leader
      await db.updateData(
        path: '$councilCollection/$councilId/$swa3edCollection',
        data: {
          newLeaderFieldName: newCouncilSwa3edLeaderId,
          newLeaderNameFieldName: newSwa3edLeaderName,
        },
        documentId: swa3edId,
      );
      // add the new leader to council Members Ids
      await db.updateData(
        path: councilCollection,
        data: {
          CouncilFields.councilMembersIds: FieldValue.arrayUnion([
            newCouncilSwa3edLeaderId,
          ]),
        },
        documentId: councilId,
      );
      // update the new leader title
      //1 - feth old leader data to get the title
      Map<String, dynamic> oldLeaderData = await db.getData(
        path: BackendEndpoints.usersCollection,
        docuementId: oldCouncilSwa3edLeaderId,
      );
      String oldLeaderTitle = oldLeaderData[UserFields.userTitle];
      //2 - update the new leader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: newCouncilSwa3edLeaderId,
        data: {UserFields.userTitle: oldLeaderTitle},
      );
      // remove the old leader title
      await db.updateData(
        path: BackendEndpoints.usersCollection,
        documentId: oldCouncilSwa3edLeaderId,
        data: {UserFields.userTitle: Constants.normalMember},
      );
      // send notification to the new leader
      if (newLeaderNameFieldName == Swa3edFields.swa3edLeaderName) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.namedLeader,
            activityName: "السواعد",
          ),
          usersIds: [newCouncilSwa3edLeaderId],
        );
      } else if (newLeaderFieldName == Swa3edFields.swa3edLeaderTwoName) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages:
                AppNotificationsMessages.namedFemaleLeader,
            activityName: "السواعد",
          ),
          usersIds: [newCouncilSwa3edLeaderId],
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  // Get All
  @override
  Future<Either<Failure, List<CouncilModel>>> getAllCouncils() async {
    try {
      List<Map<String, dynamic>> councils = await db.getData(
        path: councilCollection,
        query: {'orderBy': CouncilFields.councilNumber, 'descending': true},
      );
      List<CouncilModel> councilsList = await Future.wait(
        councils.map((council) async {
          var councilMembers = await userRepo.getUsersByIds(
            council[CouncilFields.councilMembersIds],
          );
          council[CouncilFields.councilMembersIds] = councilMembers.fold(
            (l) => [],
            (r) => r,
          );
          return CouncilModel.fromJson(council);
        }).toList(),
      );
      return Right(councilsList);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getCouncilGroups({
    required String councilId,
  }) async {
    try {
      List<Map<String, dynamic>> groups = await db.getData(
        path: '$councilCollection/$councilId/$groupsCollection',
      );
      List<GroupModel> groupsList = await Future.wait(
        groups.map((group) async {
          group[GroupFields.groupMembers] = [];

          return GroupModel.fromJson(group);
        }).toList(),
      );

      return Right(groupsList);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Swa3edModel>> getCouncilSwa3ed({
    required String councilId,
  }) async {
    try {
      List<Map<String, dynamic>> swa3eeds = await db.getData(
        path: "$councilCollection/$councilId/$swa3edCollection",
      );
      Map<String, dynamic> swa3ed = swa3eeds[0];

      var swa3edMembers = await userRepo.getUsersByIds(
        swa3ed[Swa3edFields.swa3edMembers],
      );
      swa3ed[Swa3edFields.swa3edMembers] = swa3edMembers.fold(
        (l) => [],
        (r) => r,
      );

      return Right(Swa3edModel.fromJson(swa3ed));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, CouncilModel>> getCouncilById({
    required String councilId,
  }) async {
    try {
      Map<String, dynamic> council = await db.getData(
        path: councilCollection,
        docuementId: councilId,
      );
      var members = await userRepo.getUsersByIds(
        council[CouncilFields.councilMembersIds],
      );
      council[CouncilFields.councilMembersIds] = members.fold(
        (l) => [],
        (r) => r,
      );
      return Right(CouncilModel.fromJson(council));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, GroupModel>> getCouncilGroupById({
    required String councilId,
    required String groupId,
  }) async {
    try {
      Map<String, dynamic> group = await db.getData(
        path: "$councilCollection/$councilId/$groupsCollection",
        docuementId: groupId,
      );
      var members = await userRepo.getUsersByIds(
        group[GroupFields.groupMembers],
      );
      group[GroupFields.groupMembers] = members.fold((l) => [], (r) => r);

      return Right(GroupModel.fromJson(group));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  // Remove
  @override
  Future<Either<Failure, void>> removeGroupMembers({
    required String councilId,
    required String groupId,
    required List<String> membersIds,
  }) async {
    try {
      // remove the members from the group
      await db.updateData(
        path: "$councilCollection/$councilId/$groupsCollection",
        documentId: groupId,
        data: {GroupFields.groupMembers: FieldValue.arrayRemove(membersIds)},
      );
      // change the group members account type
      for (String member in membersIds) {
        await db.updateData(
          path: BackendEndpoints.usersCollection,
          data: {UserFields.userAccountType: "زائر"},
          documentId: member,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeSwa3edMembers({
    required String councilId,
    required String swa3edId,
    required List<String> membersIds,
  }) async {
    try {
      await db.updateData(
        path: "$councilCollection/$councilId/$swa3edCollection",
        documentId: swa3edId,
        data: {Swa3edFields.swa3edMembers: FieldValue.arrayRemove(membersIds)},
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.removedFromEvent,
          activityName: "السواعد",
        ),
        usersIds: membersIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> endCouncil({required String councilId}) async {
    try {
      // update group data (groupLeaderName, groupFemaleLeaderName, groupCaptainName)
      List<Map<String, dynamic>> groups = await db.getData(
        path: "$councilCollection/$councilId/$groupsCollection",
      );
      List groupsMembersList = [];
      for (var group in groups) {
        groupsMembersList.addAll(group[GroupFields.groupMembers]);
        // fetch group Leaders names
        group[GroupFields.groupLeaderName] = await userRepo
            .getUserById(group[GroupFields.groupLeaderId])
            .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
        group[GroupFields.groupFemaleLeaderName] = await userRepo
            .getUserById(group[GroupFields.groupFemaleLeaderId])
            .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
        group[GroupFields.groupCaptainName] = await userRepo
            .getUserById(group[GroupFields.groupCaptainId])
            .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
        // update group data
        await db.updateData(
          path: "$councilCollection/$councilId/$groupsCollection",
          documentId: group[GroupFields.id],
          data: group,
        );
      }
      // update swa3ed data (swa3edLeaderName)
      List<Map<String, dynamic>> swa3eds = await db.getData(
        path: "$councilCollection/$councilId/$swa3edCollection",
      );
      for (var swa3ed in swa3eds) {
        swa3ed[Swa3edFields.swa3edLeaderName] = await userRepo
            .getUserById(swa3ed[Swa3edFields.swa3edLeaderId])
            .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
        swa3ed[Swa3edFields.swa3edLeaderTwoName] = await userRepo
            .getUserById(swa3ed[Swa3edFields.swa3edLeaderTwoId])
            .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
        // update swa3ed data
        await db.updateData(
          path: "$councilCollection/$councilId/$swa3edCollection",
          documentId: swa3ed[Swa3edFields.id],
          data: swa3ed,
        );
      }
      // update council data (councilLeaderName, councilLeaderTwoNamew)
      Map<String, dynamic> council = await db.getData(
        path: councilCollection,
        docuementId: councilId,
      );
      council[CouncilFields.councilLeaderName] = await userRepo
          .getUserById(council[CouncilFields.councilLeaderId])
          .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
      council[CouncilFields.councilLeaderTwoName] = await userRepo
          .getUserById(council[CouncilFields.councilLeaderTwoId])
          .then((value) => value.fold((l) => "غير متوفر", (r) => r.name));
      // update council data
      await db.updateData(
        path: councilCollection,
        documentId: councilId,
        data: council,
      );

      // update group members Title
      for (var userId in groupsMembersList) {
        await db.updateData(
          path: BackendEndpoints.usersCollection,
          data: {UserFields.userAccountType: "عضو"},
          documentId: userId,
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
