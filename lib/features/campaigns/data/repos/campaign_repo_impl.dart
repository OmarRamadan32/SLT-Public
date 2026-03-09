import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/features/campaigns/data/models/activity_fielda.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_fields.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo.dart';

class CampaignRepoImpl implements CampaignRepo {
  final DatabaseService db;
  final UserRepo userRepo;
  MessageRepo messageRepo;
  final String campaignsCollection = BackendEndpoints.campaignsCollection;
  final String activitiesCollection = BackendEndpoints.activitiesCollection;

  CampaignRepoImpl({
    required this.db,
    required this.userRepo,
    required this.messageRepo,
  });

  @override
  Future<Either<Failure, void>> addCampaign({
    required CampaignModel campaignModel,
  }) async {
    try {
      // make the past campaign is current = false
      List<Map<String, dynamic>> pastCampaigns = await db.getData(
        path: campaignsCollection,
        query: {
          'where': [
            {'field': CampaignFields.isCurrent, 'isEqualTo': true},
            {
              'field': CampaignFields.campaignName,
              'isEqualTo': campaignModel.campaignName,
            },
          ],
        },
      );
      List<String> pastCampaignsIds = [];
      for (var campaign in pastCampaigns) {
        pastCampaignsIds.add(campaign[CampaignFields.campaignId]);
      }
      if (pastCampaignsIds.isNotEmpty) {
        Future.wait(
          pastCampaignsIds.map((pastCampaignId) async {
            db.updateData(
              data: {CampaignFields.isCurrent: false},
              path: campaignsCollection,
              documentId: pastCampaignId,
            );
          }),
        );
      }
      // add the campaign
      await db.addData(path: campaignsCollection, data: campaignModel.toJson());
      // send message and change access level to the campaign leaders
      if (campaignModel.campaignLeaderTwoId != null) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.eventLeader,
            activityName: "حملة ${campaignModel.campaignName}",
          ),
          usersIds: [
            campaignModel.campaignLeaderId,
            campaignModel.campaignLeaderTwoId!,
          ],
        );
        await userRepo.updateUsersAccessLevel(
          usersIds: [
            campaignModel.campaignLeaderId,
            campaignModel.campaignLeaderTwoId!,
          ],
          accessLevel: 3,
        );
      } else {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.eventLeader,
            activityName: "حملة ${campaignModel.campaignName}",
          ),
          usersIds: [campaignModel.campaignLeaderId],
        );
        await userRepo.updateUsersAccessLevel(
          usersIds: [campaignModel.campaignLeaderId],
          accessLevel: 3,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addCampaignActivity({
    required String campaignId,
    required ActivityModel activityModel,
  }) async {
    try {
      final String path =
          '$campaignsCollection/$campaignId/$activitiesCollection';
      // add the activity
      await db.addData(path: path, data: activityModel.toJson());
      if (activityModel.activityLeaderTwoId != null) {
        // add the activity leader to the campaign members
        await db.updateData(
          path: campaignsCollection,
          data: {
            CampaignFields.campaignMembersIds: FieldValue.arrayUnion([
              activityModel.activityLeaderId,
              activityModel.activityLeaderTwoId,
            ]),
          },
          documentId: campaignId,
        );
        // change the activityLeaders access level
        await userRepo.updateUsersAccessLevel(
          accessLevel: 1,
          usersIds: [
            activityModel.activityLeaderId!,
            activityModel.activityLeaderTwoId!,
          ],
        );
      } else {
        // add the activity leader to the campaign members
        await db.updateData(
          path: campaignsCollection,
          data: {
            CampaignFields.campaignMembersIds: FieldValue.arrayUnion([
              activityModel.activityLeaderId,
            ]),
          },
          documentId: campaignId,
        );
        // change the activityLeader access level
        await userRepo.updateUsersAccessLevel(
          accessLevel: 1,
          usersIds: [activityModel.activityLeaderId!],
        );
      }
      // send Message to the activity leaders
      if (activityModel.activityLeaderTwoId != null) {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.eventLeader,
            activityName: activityModel.activityName,
          ),
          usersIds: [
            activityModel.activityLeaderId!,
            activityModel.activityLeaderTwoId!,
          ],
        );
      } else {
        await messageRepo.sendMessageToUsersByIds(
          messageModel: MessageModel.notificationMessageModel(
            appNotificationsMessages: AppNotificationsMessages.eventLeader,
            activityName: "نشاط ${activityModel.activityName}",
          ),
          usersIds: [activityModel.activityLeaderId!],
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeActivityLeader({
    required String campaignId,
    required String activityId,
    required String oldActivityLeaderId,
    required String newActivityLeaderId,
    required String newActivityLeaderIdFieldName,
    required String newActivityLeaderNameFieldName,
    required String newActivityLeaderName,
    required String activityName,
  }) async {
    final String activitiesPath =
        '$campaignsCollection/$campaignId/$activitiesCollection';
    try {
      // change the activityLeaderId to hold the new one
      await db.updateData(
        path: activitiesPath,
        data: {
          newActivityLeaderIdFieldName: newActivityLeaderId,
          newActivityLeaderNameFieldName: newActivityLeaderName,
        },
        documentId: activityId,
      );
      // -- remove the old leader from campaign members list and add the new
      await db.updateData(
        path: campaignsCollection,
        data: {
          CampaignFields.campaignMembersIds: FieldValue.arrayRemove([
            oldActivityLeaderId,
          ]),
        },
        documentId: campaignId,
      );
      await db.updateData(
        path: campaignsCollection,
        data: {
          CampaignFields.campaignMembersIds: FieldValue.arrayUnion([
            newActivityLeaderId,
          ]),
        },
        documentId: campaignId,
      );
      // update the old activity leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 0,
        downgrade: true,
        downgradeFrom: 1,
        usersIds: [oldActivityLeaderId],
      );
      // update the new activity leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 1,
        usersIds: [newActivityLeaderId],
      );
      // send Message to the new activity leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.eventLeader,
          activityName: "نشاط $activityName",
        ),
        usersIds: [newActivityLeaderId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeCampaignLeader({
    required String campaignId,
    required String newCampaignLeaderId,
    newCampaignLeaderIdFieldName,
    newCampaignLeaderNameFieldName,
    required String oldCampaignLeaderId,
    required String newCampaignLeaderName,
    required String campaignName,
  }) async {
    try {
      // change the campaignLeaderId to hold the new one
      await db.updateData(
        path: campaignsCollection,
        data: {
          newCampaignLeaderIdFieldName: newCampaignLeaderId,
          newCampaignLeaderNameFieldName: newCampaignLeaderName,
        },
        documentId: campaignId,
      );
      // update the old campaign leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 0,
        usersIds: [oldCampaignLeaderId],
        downgrade: true,
        downgradeFrom: 3,
      );
      // update the new campaign leader access level
      await userRepo.updateUsersAccessLevel(
        accessLevel: 3,
        usersIds: [newCampaignLeaderId],
      );
      // send Message to the new campaign leader
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.eventLeader,
          activityName: "حملة $campaignName",
        ),
        usersIds: [newCampaignLeaderId],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ActivityModel>>> getAllCampaignActivities({
    required String campaignId,
  }) async {
    final String activitiesPath =
        '$campaignsCollection/$campaignId/$activitiesCollection';
    try {
      // variable to hold the incoming map
      List activities = await db.getData(path: activitiesPath);
      // list to hold the Activities model to be returned later
      List<ActivityModel> activitiesList = await Future.wait(
        activities.map((activity) async {
          List<dynamic> activityMembersids =
              activity[ActivityFields.activityMembers];
          var users = await userRepo.getUsersByIds(activityMembersids);
          users.fold(
            (l) {
              activity[ActivityFields.activityMembers] = [];
            },
            (usersModels) {
              activity[ActivityFields.activityMembers] = usersModels;
            },
          );
          return ActivityModel.fromJson(activity);
        }).toList(),
      );

      return Right(activitiesList);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<CampaignModel>>> getAllCampaigns() async {
    try {
      List campaigns = await db.getData(
        path: campaignsCollection,
        query: {'orderBy': CampaignFields.campaignNumber, 'descending': true},
      );
      List<CampaignModel> campaignsList = await Future.wait(
        campaigns.map((campaign) async {
          var campaignMembers = await userRepo.getUsersByIds(
            campaign[CampaignFields.campaignMembersIds],
          );
          campaign[CampaignFields.campaignMembersIds] = campaignMembers.fold(
            (l) => [],
            (r) => r,
          );
          return CampaignModel.fromJson(campaign);
        }).toList(),
      );
      return Right(campaignsList);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ActivityModel>> getCampaignActivityById({
    required String campaignId,
    required String activityId,
  }) async {
    final String activitiesPath =
        '$campaignsCollection/$campaignId/$activitiesCollection';

    try {
      var activity = await db.getData(
        path: activitiesPath,
        docuementId: activityId,
      );
      List<dynamic> activityMembersIds =
          activity[ActivityFields.activityMembers];
      var users = await userRepo.getUsersByIds(activityMembersIds);
      users.fold(
        (l) {
          activity[ActivityFields.activityMembers] = [];
        },
        (usersModels) {
          activity[ActivityFields.activityMembers] = usersModels;
        },
      );
      return Right(ActivityModel.fromJson(activity));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, CampaignModel>> getCampaignById({
    required String campaignId,
  }) async {
    try {
      var campaign = await db.getData(
        path: campaignsCollection,
        docuementId: campaignId,
      );
      var campaignMembers = await userRepo.getUsersByIds(
        campaign[CampaignFields.campaignMembersIds],
      );
      campaign[CampaignFields.campaignMembersIds] = campaignMembers.fold(
        (l) => null,
        (r) => r,
      );
      return Right(CampaignModel.fromJson(campaign));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addActivityMembers({
    required String campaignId,
    required String activityId,
    required List<String> membersIds,
    required String activityName,
  }) async {
    try {
      await db.updateData(
        path: '$campaignsCollection/$campaignId/$activitiesCollection',
        data: {
          ActivityFields.activityMembers: FieldValue.arrayUnion(membersIds),
        },
        documentId: activityId,
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.addedToEvent,
          activityName: "نشاط $activityName",
        ),
        usersIds: membersIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeActivityMembers({
    required String campaignId,
    required String activityId,
    required List<String> membersIds,
    required String activityName,
  }) async {
    try {
      await db.updateData(
        path: '$campaignsCollection/$campaignId/$activitiesCollection',
        data: {
          ActivityFields.activityMembers: FieldValue.arrayRemove(membersIds),
        },
        documentId: activityId,
      );
      await messageRepo.sendMessageToUsersByIds(
        messageModel: MessageModel.notificationMessageModel(
          appNotificationsMessages: AppNotificationsMessages.removedFromEvent,
          activityName: "نشاط $activityName",
        ),
        usersIds: membersIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateActivityDetails({
    required ActivityModel activityModel,
    required String campaignId,
    required String activityId,
  }) async {
    try {
      await db.updateData(
        path: '$campaignsCollection/$campaignId/$activitiesCollection',
        data: activityModel.toJsonUpdate(),
        documentId: activityId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
