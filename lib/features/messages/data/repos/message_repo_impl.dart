import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/features/messages/data/models/message_fields.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';

class MessageRepoImpl implements MessageRepo {
  final DatabaseService db;
  final NotificationService notificationService;
  final UserRepo userRepo;
  MessageRepoImpl({
    required this.db,
    required this.notificationService,
    required this.userRepo,
  });
  final String messagesCollection = BackendEndpoints.messagesCollection;
  final String usersCollection = BackendEndpoints.usersCollection;

  @override
  Future<Either<Failure, List<MessageModel>>> getAllTeamMessages({
    int? limit,
    dynamic startAfter,
  }) async {
    try {
      Map<String, dynamic> query = {
        'orderBy': MessageFields.date,
        'descending': true,
      };
      if (limit != null) {
        query['limit'] = limit;
      }
      if (startAfter != null) {
        query['startAfterDocument'] = startAfter;
      }
      List<Map<String, dynamic>> messages = await db.getData(
        path: messagesCollection,
        query: query,
      );
      return Right(messages.map((e) => MessageModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getCurrentUserMessages({
    required String userId,
    int? limit,
    dynamic startAfter,
  }) async {
    Map<String, dynamic> query = {
      'orderBy': MessageFields.date,
      'descending': true,
    };
    if (limit != null) {
      query['limit'] = limit;
    }
    if (startAfter != null) {
      query['startAfterDocument'] = startAfter;
    }
    final String userMessagesPath =
        '${BackendEndpoints.usersCollection}/$userId/$messagesCollection';
    try {
      List<Map<String, dynamic>> messages = await db.getData(
        path: userMessagesPath,
        query: query,
      );
      return Right(messages.map((e) => MessageModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessageToAllTeam({
    required MessageModel messageModel,
  }) async {
    try {
      await db.addData(path: messagesCollection, data: messageModel.toJson());
      await notificationService.sendNotificationToAllTeamMembers(
        title: messageModel.senderName,
        body: messageModel.text,
      );
      //! Will be removed later
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessageToMembers({
    required MessageModel messageModel,
    required List<String> receiversIds,
    required List<String> receiversTokens,
  }) async {
    try {
      await Future.wait(
        receiversIds.map((e) async {
          final String receiverMessagesCollection =
              '${BackendEndpoints.usersCollection}/$e/$messagesCollection';
          if (e != "") {
            await db.addData(
            path: receiverMessagesCollection,
            data: messageModel.toJson(),
          );
          } else {
            
          }
        }),
      );
      await notificationService.sendNotificationToUsers(
        title: messageModel.senderName,
        body: messageModel.text,
        tokens: receiversTokens,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getTodayMessages({
    required String userId,
  }) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final startTimestamp = Timestamp.fromDate(startOfDay);
    final endTimestamp = Timestamp.fromDate(endOfDay);
    try {
      List<Map<String, dynamic>> teamMessages = await db.getData(
        path: messagesCollection,
        query: {
          'orderBy': MessageFields.date,
          'descending': true,
          'where': [
            {
              'field': MessageFields.date,
              'isGreaterThanOrEqualTo': startTimestamp,
              'isLessThanOrEqualTo': endTimestamp,
            },
          ],
        },
      );
      List<Map<String, dynamic>> userMessages = await db.getData(
        path: '${BackendEndpoints.usersCollection}/$userId/$messagesCollection',
        query: {
          'orderBy': MessageFields.date,
          'descending': true,
          'where': [
            {
              'field': MessageFields.date,
              'isGreaterThanOrEqualTo': startTimestamp,
              'isLessThanOrEqualTo': endTimestamp,
            },
          ],
        },
      );

      final allMessages = teamMessages + userMessages;
      allMessages.sort((a, b) {
        final dateA = a[MessageFields.date];
        final dateB = b[MessageFields.date];
        final dateTimeA =
            dateA is Timestamp ? dateA.toDate() : dateA as DateTime;
        final dateTimeB =
            dateB is Timestamp ? dateB.toDate() : dateB as DateTime;
        return dateTimeB.compareTo(dateTimeA);
      });

      return Right(allMessages.map((e) => MessageModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getAllMessages({
    required String userId,
    int? limit,
    dynamic startAfterTeam,
    dynamic startAfterUser,
  }) async {
    try {
      Map<String, dynamic> teamQuery = {
        'orderBy': MessageFields.date,
        'descending': true,
      }; // Team messages Query
      Map<String, dynamic> userQuery = {
        'orderBy': MessageFields.date,
        'descending': true,
      };
      if (limit != null) {
        teamQuery['limit'] = limit;
      }
      if (startAfterTeam != null) {
        teamQuery['startAfterDocument'] = startAfterTeam;
      }
      if (limit != null) {
        userQuery['limit'] = limit;
      }
      if (startAfterUser != null) {
        userQuery['startAfterDocument'] = startAfterUser;
      }
      List<Map<String, dynamic>> teamMessages = await db.getData(
        path: messagesCollection,
        query: teamQuery,
      );
      List<Map<String, dynamic>> userMessages = await db.getData(
        path: '${BackendEndpoints.usersCollection}/$userId/$messagesCollection',
        query: userQuery,
      );
      List<Map<String, dynamic>> allMessages = teamMessages + userMessages;
      allMessages.sort((a, b) {
        final dateA = a[MessageFields.date];
        final dateB = b[MessageFields.date];
        // If using Firestore Timestamp, convert to DateTime
        final dateTimeA =
            dateA is Timestamp ? dateA.toDate() : dateA as DateTime;
        final dateTimeB =
            dateB is Timestamp ? dateB.toDate() : dateB as DateTime;
        return dateTimeB.compareTo(dateTimeA); // descending order
      });
      return Right((allMessages).map((e) => MessageModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessageToUsersByIds({
    required MessageModel messageModel,
    required List<String> usersIds,
  }) async {
    try {
      Either<Failure, List<UserModel>> users = await userRepo.getUsersByIds(
        usersIds,
      );
      List<UserModel>? usersModels = users.fold(
        (l) => null,
        (usersModels) => usersModels,
      );
    await  sendMessageToMembers(
        messageModel: messageModel,
        receiversIds: usersIds,
        receiversTokens: usersModels!.map((user) => user.token).toList(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
