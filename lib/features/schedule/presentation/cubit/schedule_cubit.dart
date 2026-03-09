import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepo scheduleRepo;
  ScheduleCubit(this.scheduleRepo) : super(ScheduleInitialState());

  List<ScheduleModel> schedulesList = [];
  ScheduleModel? schedule;

  List<ScheduleAbsModel> scheduleAbs = [];

  Future<void> getUpcomingSchedules({required String path}) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.getUpcomingSchedules(path: path);
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (schedules) {
        schedulesList = schedules;
        emit(ScheduleSuccessState());
      },
    );
  }

  Future<void> getAllSchedules({required String path}) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.getAllSchedules(path: path);
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (schedules) {
        schedulesList = schedules;
        emit(ScheduleSuccessState());
      },
    );
  }

  // this method fetchs the schedule and its abs at the same time
  Future<void> getScheduleById({
    required String path,
    required String docId,
  }) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.getScheduleById(path: path, docId: docId);
    var result2 = await scheduleRepo.getScheduleAbs(path: path, docId: docId);

    result2.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (scheduleAbs) {
        this.scheduleAbs = scheduleAbs;
      },
    );
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (schedule) {
        this.schedule = schedule;
        emit(ScheduleSuccessState());
      },
    );
  }

  Future<void> attsSchedule({
    required String path,
    required String userId,
    required String docId,
  }) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.attsSchedule(
      path: path,
      userId: userId,
      docId: docId,
    );
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (none) => emit(ScheduleAttsSuccessState()),
    );
  }

  Future<void> absSchedule({
    required String path,
    required ScheduleAbsModel scheduleAbsModel,
    required String docId,
  }) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.absSchedule(
      scheduleLeaderId: schedule!.scheduleAuthorId,
      path: path,
      docId: docId,
      scheduleAbsModel: scheduleAbsModel,
    );
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (none) => emit(ScheduleAbsSuccessState()),
    );
  }

  Future<void> approveScheduleAbs({
    required String path,
    required String docId,
    required String userId,
  }) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.approveScheduleAbs(
      path: path,
      docId: docId,
      userId: userId,
    );
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (none) => emit(ScheduleApproveAbsState()),
    );
  }

  Future<void> declineScheduleAbs({
    required String path,
    required String docId,
    required String userId,
  }) async {
    emit(ScheduleLoadingState());
    var result = await scheduleRepo.declineScheduleAbs(
      path: path,
      docId: docId,
      userId: userId,
    );
    result.fold(
      (error) => emit(ScheduleErrorState(errMessage: error.message)),
      (none) => emit(ScheduleDeclineAbsState()),
    );
  }
}
