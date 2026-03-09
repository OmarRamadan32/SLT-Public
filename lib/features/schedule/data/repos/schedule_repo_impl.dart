import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/core/errors/server_failure.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/features/messages/data/models/message_model.dart';
import 'package:new_slt/features/messages/data/repos/message_repo.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_fields.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/data/models/schedule_fields.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';

class ScheduleRepoImpl implements ScheduleRepo {
  DatabaseService db;
  UserRepo userRepo;
  MessageRepo messageRepo;
  final NotificationService notificationService;
  ScheduleRepoImpl({
    required this.db,
    required this.userRepo,
    required this.messageRepo,
    required this.notificationService,
  });

  @override
  Future<Either<Failure, void>> declineScheduleAbs({
    required String path,
    required String docId,
    required String userId,
  }) async {
    final String fullPath =
        '$path/$docId/${BackendEndpoints.scheduleAbsCollection}';
    try {
      await db.updateData(
        path: fullPath,
        documentId: userId,
        data: {ScheduleAbsFields.isApproved: false},
      );
      Either<Failure, UserModel> user = await userRepo.getUserById(userId);
      UserModel? userModel = user.fold((l) => null, (userModel) => userModel);
      messageRepo.sendMessageToMembers(
        messageModel: MessageModel(
          senderName: "فريق القادة الاجتماعيين",
          text: "تم رفض طلب إعتذارك عن الموعد",
          date: DateTime.now(),
          isPrivate: true,
        ),
        receiversIds: [userModel!.id!],
        receiversTokens: [userModel.token],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> approveScheduleAbs({
    required String path,
    required String docId,
    required String userId,
  }) async {
    final String fullPath =
        '$path/$docId/${BackendEndpoints.scheduleAbsCollection}';
    try {
      await db.updateData(
        path: fullPath,
        documentId: userId,
        data: {ScheduleAbsFields.isApproved: true},
      );
      Either<Failure, UserModel> user = await userRepo.getUserById(userId);
      UserModel? userModel = user.fold((l) => null, (userModel) => userModel);
      messageRepo.sendMessageToMembers(
        messageModel: MessageModel(
          senderName: "فريق القادة الاجتماعيين",
          text: "تمت الموافقه علي طلب إعتذارك عن الموعد",
          date: DateTime.now(),
          isPrivate: true,
        ),
        receiversIds: [userModel!.id!],
        receiversTokens: [userModel.token],
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> attsSchedule({
    required String path,
    required String userId,
    required String docId,
  }) async {
    final String absCollectionfullPath =
        '$path/$docId/${BackendEndpoints.scheduleAbsCollection}';
    try {
      final absDoc = await db.getData(
        path: absCollectionfullPath,
        docuementId: userId,
      );
      // if User is not signed as Abs
      if (absDoc != null) {
        await db.deleteData(path: absCollectionfullPath, documentId: userId);
        await db.updateData(
          path: path,
          documentId: docId,
          data: {
            ScheduleFields.scheduleAtts: FieldValue.arrayUnion([userId]),
          },
        );
      } else {
        await db.updateData(
          path: path,
          documentId: docId,
          data: {
            ScheduleFields.scheduleAtts: FieldValue.arrayUnion([userId]),
          },
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> absSchedule({
    required String docId,
    required String path,
    required ScheduleAbsModel scheduleAbsModel,
    required String scheduleLeaderId,
  }) async {
    // get the path of the schedule abs collection
    final String fullPath =
        '$path/$docId/${BackendEndpoints.scheduleAbsCollection}';
    try {
      // send notification to schedule leader
      Either<Failure, UserModel> user = await userRepo.getUserById(
        scheduleLeaderId,
      );
      UserModel? userModel = user.fold((l) => null, (userModel) => userModel);
      await notificationService.sendNotificationToUsers(
        title: "فريق القادة الاجتماعيين",
        body:
            "يوجد تغيير في قائمة الإعتذارات الخاصة بالموعد الذي أضفته مؤخرا, قم بالفحص والموافقة علي الاعتذار إذا أردت",
        tokens: [userModel!.token],
      );
      // get the schedule doc
      final scheduleDoc = await db.getData(path: path, docuementId: docId);
      // list to hold the schedule atts
      List attsList = scheduleDoc[ScheduleFields.scheduleAtts];
      // check if the user is signed as atts
      if (attsList.contains(scheduleAbsModel.absId)) {
        // remove the user from the schedule atts List
        await db.updateData(
          path: path,
          documentId: docId,
          data: {
            ScheduleFields.scheduleAtts: FieldValue.arrayRemove([
              scheduleAbsModel.absId,
            ]),
          },
        );
        // add the user to the schedule abs collection
        await db.addData(
          path: fullPath,
          documentId: scheduleAbsModel.absId,
          data: scheduleAbsModel.toJson(),
        );
      } else {
        await db.addData(
          path: fullPath,
          documentId: scheduleAbsModel.absId,
          data: scheduleAbsModel.toJson(),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSchedule({
    required String path,
    required String docId,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
  }) async {
    try {
      // delete the Abs collection first
      await db.deleteData(
        path: '$path/$docId/${BackendEndpoints.scheduleAbsCollection}',
      );
      await db.deleteData(path: path, documentId: docId);
      if (scheduleFeaturePageAdminModel.isTeamSchedule) {
        await messageRepo.sendMessageToAllTeam(
          messageModel: MessageModel(
            senderName:
                scheduleFeaturePageAdminModel.scheduleAuthorName ??
                'فريق القادة الاجتماعيين ',
            text: "تم حذف ${scheduleFeaturePageAdminModel.scheduleType}",
            date: DateTime.now(),
            isPrivate: false,
          ),
        );
      } else {
        await messageRepo.sendMessageToMembers(
          messageModel: MessageModel(
            senderName:
                scheduleFeaturePageAdminModel.scheduleAuthorName ??
                'فريق القادة الاجتماعيين ',
            text: "تم حذف ${scheduleFeaturePageAdminModel.scheduleType}",
            date: DateTime.now(),
            isPrivate: true,
          ),
          receiversIds: scheduleFeaturePageAdminModel.scheduleMembersIds!,
          receiversTokens: scheduleFeaturePageAdminModel.scheduleMembersTokens!,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ScheduleModel>>> getAllSchedules({
    required String path,
  }) async {
    try {
      final List<Map<String, dynamic>> data = await db.getData(path: path);
      print(data.length);
      if (data.isEmpty) return const Right([]);
      List<ScheduleModel> schedules = [];
      for (var element in data) {
        schedules.add(ScheduleModel.fromJsonWithoutAtts(element));
      }
      return Right(schedules);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ScheduleAbsModel>>> getScheduleAbs({
    required String path,
    required String docId,
  }) async {
    try {
      final List<Map<String, dynamic>> data = await db.getData(
        path: '$path/$docId/${BackendEndpoints.scheduleAbsCollection}',
      );
      print(data);
      if (data.isNotEmpty) {
        final abs =
            data.map((e) {
              return ScheduleAbsModel.fromJson(e);
            }).toList();
        return Right(abs);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, ScheduleModel>> getScheduleById({
    required String docId,
    required String path,
  }) async {
    try {
      final schedule = await db.getData(path: path, docuementId: docId);
      final atts = schedule[ScheduleFields.scheduleAtts];
      final attendeesResult =
          atts is List
              ? await userRepo.getUsersByIds(List<String>.from(atts))
              : await userRepo.getUsersByIds(<String>[]);

      final modified = Map<String, dynamic>.from(schedule);
      modified[ScheduleFields.scheduleAtts] = attendeesResult.fold(
        (l) => <UserModel>[],
        (users) => users,
      );

      return Right(ScheduleModel.fromJson(modified));
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addSchedule({
    required String path,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
    required ScheduleModel scheduleModel,
  }) async {
    try {
      await db.addData(path: path, data: scheduleModel.toJson());
      if (scheduleFeaturePageAdminModel.isTeamSchedule) {
        await messageRepo.sendMessageToAllTeam(
          messageModel: MessageModel(
            senderName:
                scheduleFeaturePageAdminModel.scheduleAuthorName ??
                'فريق القادة الاجتماعيين ',
            text:
                "تم إضافة ${scheduleFeaturePageAdminModel.scheduleType} (${scheduleModel.scheduleTitle})",
            date: DateTime.now(),
            isPrivate: false,
          ),
        );
      } else {
        await messageRepo.sendMessageToMembers(
          messageModel: MessageModel(
            senderName:
                scheduleFeaturePageAdminModel.scheduleAuthorName ??
                'فريق القادة الاجتماعيين ',
            text:
                "تم إضافة ${scheduleFeaturePageAdminModel.scheduleType} (${scheduleModel.scheduleTitle})",
            date: DateTime.now(),
            isPrivate: true,
          ),
          receiversIds: scheduleFeaturePageAdminModel.scheduleMembersIds!,
          receiversTokens: scheduleFeaturePageAdminModel.scheduleMembersTokens!,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ScheduleModel>>> getAllUserSchedules({
    required String path,
    required String userId,
  }) async {
    try {
      final List<Map<String, dynamic>> data = await db.getData(
        path: path,
        query: {
          'where': [
            {'field': ScheduleFields.scheduleAuthorId, 'isEqualTo': userId},
          ],
        },
      );
      List<ScheduleModel> schedules = [];
      data.map((e) {
        schedules.add(ScheduleModel.fromJsonWithoutAtts(e));
      }).toList();
      return Right(schedules);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ScheduleModel>>> getUpcomingSchedules({
    required String path,
  }) async {
    try {
      Map<String, dynamic> query = {
        'where': [
          {
            'field': ScheduleFields.scheduleDate,
            'isGreaterThanOrEqualTo': DateTime.now(),
          },
        ],
      };
      final List<Map<String, dynamic>> data = await db.getData(
        path: path,
        query: query,
      );
      print(data.length);
      if (data.isEmpty) return const Right([]);
      List<ScheduleModel> schedules = [];
      for (var element in data) {
        schedules.add(ScheduleModel.fromJsonWithoutAtts(element));
      }
      return Right(schedules);
    } catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
