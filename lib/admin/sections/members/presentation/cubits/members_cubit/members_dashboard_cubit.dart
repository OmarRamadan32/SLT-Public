import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo.dart';
import 'package:new_slt/features/members/data/repos/members_repo.dart';

part 'members_dashboard_state.dart';

class MembersDashboardCubit extends Cubit<MembersDashboardState> {
  MembersDashboardCubit({
    required this.membersRepo,
    required this.memberOfTheMonthRepo,
  }) : super(MembersDashboardInitial());
  final MembersRepo membersRepo;
  final MemberOfTheMonthRepo memberOfTheMonthRepo;
  //-- adds
  // ------------- Member of the month
  Future<void> addMemberOfTheMonth({
    required HighlightModel memberOfTheMonthModel,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await memberOfTheMonthRepo.addMemberOfTheMonth(
      memberOfTheMonthModel,
    );
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  Future<void> removeMemberOfTheMonth() async {
    emit(MembersDashboardLoadingState());
    var result = await memberOfTheMonthRepo.deleteMemberOfTheMonth();
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  Future<void> addMembersToMainBoard({
    required List<String> membersIds,
    required List<String> membersTokens,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.addMembersToMainBoard(
      membersIds: membersIds,
    );
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> addMembersToTheTeam({required List<String> membersIds}) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.addMembersToTheTeam(membersIds: membersIds);
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> addMembersToSubBoard({
    required List<String> membersIds,
    required List<String> membersTokens,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.addMembersToSubBoard(membersIds: membersIds);
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-- Remove
  Future<void> removeMembersFromMainBoard({
    required List<String> membersIds,
    required List<String> membersTokens,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.removeMembersFromMainBoard(
      membersIds: membersIds,
    );

    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> removeMembersFromSubBoard({
    required List<String> membersIds,
    required List<String> membersTokens,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.removeMembersFromSubBoard(
      membersIds: membersIds,
    );

    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> removeMembersFromTheTeam({
    required List<String> membersIds,
    required List<String> membersTokens,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.removeMembersFromTheTeam(
      membersIds: membersIds,
    );
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> removeViceTeamLeader() async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.removeViceTeamLeader();
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> removeAssistantTeamLeader() async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.removeAssistantTeamLeader();
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //- Choose
  Future<void> chooseAssistantTeamLeader({
    required String newLeaderId,
    required String leaderToken,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.chooseAssistantTeamLeader(
      newLeaderId: newLeaderId,
    );
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
  Future<void> chooseViceTeamLeader({
    required String newLeaderId,
    required String leaderToken,
  }) async {
    emit(MembersDashboardLoadingState());
    var result = await membersRepo.chooseViceTeamLeader(
      newLeaderId: newLeaderId,
    );
    result.fold(
      (l) => emit(MembersDashboardErrorState(message: l.message)),
      (r) => emit(MembersDashboardSuccessState()),
    );
  }

  //-
}
