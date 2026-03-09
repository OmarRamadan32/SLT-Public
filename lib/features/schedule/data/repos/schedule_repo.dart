import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';

abstract class ScheduleRepo {
  Future<Either<Failure, List<ScheduleModel>>> getAllSchedules({
    required String path,
  });
    Future<Either<Failure, List<ScheduleModel>>> getUpcomingSchedules({
    required String path,
  });

  Future<Either<Failure, ScheduleModel>> getScheduleById({required String path,
     required String docId,});

    Future<Either<Failure,void>> deleteSchedule({
    required String path,
    required String docId,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
  });

      Future<Either<Failure,void>> addSchedule({
    required String path,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
    required ScheduleModel scheduleModel,
  });

    Future<Either<Failure, void>> attsSchedule({
    required String path,
    required String userId,
    required String docId,
  });

      Future<Either<Failure, void>> absSchedule({
    required String path,
    required String docId,
    required ScheduleAbsModel scheduleAbsModel,
        required String scheduleLeaderId
  });


      Future<Either<Failure, List<ScheduleAbsModel>>> getScheduleAbs({
    required String path,
    required String docId
  });

          Future<Either<Failure, void>> approveScheduleAbs({
    required String path,
    required String docId,
    required String userId
  });

        Future<Either<Failure, void>> declineScheduleAbs({
    required String path,
        required String docId,
  required String userId
  });

    Future<Either<Failure, List<ScheduleModel>>> getAllUserSchedules({
    required String path,
    required String userId
  });



  
}
