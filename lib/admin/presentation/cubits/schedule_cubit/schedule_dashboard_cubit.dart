import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';

part 'schedule_dashboard_state.dart';

class ScheduleDashboardCubit extends Cubit<ScheduleDashboardState> {
  final ScheduleRepo scheduleRepo;
  ScheduleDashboardCubit({required this.scheduleRepo})
    : super(ScheduleDashboardInitialState());

  Future<void> addSchedule({
    required String path,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
    required ScheduleModel scheduleModel,
  }) async {
    emit(ScheduleDashboardLoadingState());
    var result = await scheduleRepo.addSchedule(
      scheduleFeaturePageAdminModel: scheduleFeaturePageAdminModel,
      path: path,
      scheduleModel: scheduleModel,
    );
    result.fold((error) {
      emit(ScheduleDashboardErrorState(errMessage: error.message));
    }, (R) => emit(ScheduleDashboardSuccessState()));
  }

  Future<void> getAllUserSchedule({
    required String path,
    required String userId,
  }) async {
    emit(ScheduleDashboardLoadingState());
    var result = await scheduleRepo.getAllUserSchedules(
      path: path,
      userId: userId,
    );
    result.fold(
      (error) => emit(ScheduleDashboardErrorState(errMessage: error.message)),
      (schedules) => emit(ScheduleDashboardLoadedState(schedules: schedules)),
    );
  }

  Future<void> getAllTeamSchedule({required String path}) async {
    emit(ScheduleDashboardLoadingState());
    var result = await scheduleRepo.getAllSchedules(path: path);
    result.fold(
      (error) => emit(ScheduleDashboardErrorState(errMessage: error.message)),
      (schedules) => emit(ScheduleDashboardLoadedState(schedules: schedules)),
    );
  }

  Future<void> deleteSchedule({
    required String path,
    required String docId,
    required ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel,
  }) async {
    emit(ScheduleDashboardLoadingState());
    var result = await scheduleRepo.deleteSchedule(
      scheduleFeaturePageAdminModel: scheduleFeaturePageAdminModel,
      path: path,
      docId: docId,
    );
    result.fold(
      (error) => emit(ScheduleDashboardErrorState(errMessage: error.message)),
      (r) => emit(ScheduleDashboardSuccessState()),
    );
  }
}
