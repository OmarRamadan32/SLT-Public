import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo.dart';

part 'committee_dashboard_state.dart';

class CommitteeDashboardCubit extends Cubit<CommitteeDashboardState> {
  final CommitteeRepo committeeRepo;
  CommitteeDashboardCubit({required this.committeeRepo})
    : super(CommitteeDashboardInitialState());

  CommitteeModel? committeeModel;
  List<CommitteeModel> committees = [];
  List<UserModel> committeeMembers = [];

  void resetState() => emit(CommitteeDashboardInitialState());

  Future<void> getAllCommittees() async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.getAllCommittees();
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committees) {
        this.committees = committees;
        if (!isClosed) emit(CommitteeDashboardSuccessState());
      },
    );
  }

  Future<void> getCommitteeById({required String committeeId}) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.getCommitteById(committeeId: committeeId);
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        committeeModel = committee;
        emit(CommitteeDashboardSuccessState());
      },
    );
  }

  Future<void> getCommitteeMembers(String id) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.getCommitteMembers(committeeId: id);
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (members) {
        committeeMembers = members;
        emit(CommitteeDashboardSuccessState());
      },
    );
  }

  Future<void> updateCommitteeDetails({
    required CommitteeModel committeeModel,
    required String committeeId,
  }) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.updateCommitteeDetails(
      committeeModel: committeeModel,
      committeeId: committeeId,
    );
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        emit(CommitteeDashboardSuccessState());
      },
    );
  }

  Future<void> addCommittee({required CommitteeModel committeeModel}) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.addCommittee(
      committeeModel: committeeModel,
    );
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        emit(CommitteeDashboardCommitteeAddedState());
      },
    );
  }

  Future<void> changeCommitteeLeader({
    required String newLeaderId,
    required String newLeaderName,
  }) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.changeCommitteeLeader(
      committeeId: committeeModel!.id!,
      committeeName: committeeModel!.committeeName,
      oldLeaderId: committeeModel!.committeeLeaderId!,
      newLeaderId: newLeaderId,
      newLeaderName: newLeaderName,
    );
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        emit(CommitteeDashboardleaderChangedState());
      },
    );
  }

  Future<void> addCommitteeMembers({
    required List<String> membersIDSList,
  }) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.addCommitteeMembers(
      membersIDSList: membersIDSList,
      committeeId: committeeModel!.id!,
      committeeName: committeeModel!.committeeName,
    );
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        emit(CommitteeDashboardMembersUpdatedState());
      },
    );
  }

  Future<void> removeCommitteeMembers({
    required List<String> membersIDSList,
    required String committeeId,
  }) async {
    emit(CommitteeDashboardLoadingState());
    var result = await committeeRepo.removeCommitteeMembers(
      membersIDSList: membersIDSList,
      committeeId: committeeModel!.id!,
      committeeName: committeeModel!.committeeName,
    );
    result.fold(
      (error) => emit(CommitteeDashboardErrorState(message: error.message)),
      (committee) {
        emit(CommitteeDashboardMembersUpdatedState());
      },
    );
  }
}
