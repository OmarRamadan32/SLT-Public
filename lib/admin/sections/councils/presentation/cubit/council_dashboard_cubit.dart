import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/council/data/models/council_fields.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/features/council/data/repos/council_repo.dart';

part 'council_dashboard_state.dart';

class CouncilDashboardCubit extends Cubit<CouncilDashboardState> {
  CouncilRepo councilRepo;
  CouncilDashboardCubit({required this.councilRepo})
    : super(CouncilDashboardInitialState());

  List<CouncilModel> councils = [];
  CouncilModel? council;
  List<GroupModel> groups = [];
  GroupModel? group;
  Swa3edModel? swa3ed;

  void resetState() {
    emit(CouncilDashboardInitialState());
  }

  Future<void> addCouncil({required CouncilModel councilModel}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.addCouncil(councilModel: councilModel);
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardCouncilAddedState()),
    );
  }

  Future<void> addGroup({required GroupModel groupModel}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.addCouncilGroup(
      councilId: council!.id!,
      groupModel: groupModel,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardSuccessState()),
    );
  }

  Future<void> addSwa3ed({required Swa3edModel swa3edModel}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.addCouncilSwa3ed(
      councilId: council!.id!,
      swa3edModel: swa3edModel,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardSuccessState()),
    );
  }

  // --
  Future<void> getCouncils() async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.getAllCouncils();
    data.fold((l) => emit(CouncilDashboardErrorState(message: l.message)), (r) {
      councils = r;
      if (!isClosed) emit(CouncilDashboardSuccessState());
    });
  }

  // --

  Future<void> changeCouncilLeader({
    required String newCouncilLeaderId,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String newCouncilLeaderName,
  }) async {
    emit(CouncilDashboardLoadingState());
    final String oldCouncilLeaderId =
        newLeaderIdFieldName == CouncilFields.councilLeaderId
            ? council!.councilLeaderId
            : council!.councilLeaderTwoId!;
    var data = await councilRepo.changeCouncilLeader(
      oldCouncilLeaderId: oldCouncilLeaderId,
      newCouncilLeaderName: newCouncilLeaderName,
      newLeaderNameFieldName: newLeaderNameFieldName,
      newLeaderIdFieldName: newLeaderIdFieldName,
      councilId: council!.id!,
      newCouncilLeaderId: newCouncilLeaderId,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardLeaderUpdatedState()),
    );
  }

  Future<void> changeGroupLeader({
    required String newGroupLeaderId,
    required String newLeaderFieldName,
    required String newGroupLeaderName,
    required String newLeaderNameFieldName,
    required String oldGroupLeaderId,
  }) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.changeCouncilGroupLeader(
      newGroupLeaderName: newGroupLeaderName,
      newLeaderNameFieldName: newLeaderNameFieldName,
      councilId: council!.id!,
      groupId: group!.id!,
      groupName: group!.groupName,
      oldGroupLeaderId: oldGroupLeaderId,
      newGroupLeaderId: newGroupLeaderId,
      newLeaderIdFieldName: newLeaderFieldName,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardLeaderUpdatedState()),
    );
  }

  Future<void> changeSwa3edLeader({
    required String newSwa3edLeaderId,
    required String newLeaderFieldName,
    required String newLeaderNameFieldName,
    required String newSwa3edLeaderName,
    required String oldSwa3edLeaderId,
  }) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.changeCouncilSwa3edLeader(
      councilId: council!.id!,
      swa3edId: swa3ed!.id!,
      oldCouncilSwa3edLeaderId: oldSwa3edLeaderId,
      newCouncilSwa3edLeaderId: newSwa3edLeaderId,
      newLeaderFieldName: newLeaderFieldName,
      newLeaderNameFieldName: newLeaderNameFieldName,
      newSwa3edLeaderName: newSwa3edLeaderName,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardLeaderUpdatedState()),
    );
  }

  Future<void> getAllCouncilEventsById({required String councilId}) async {
    emit(CouncilDashboardLoadingState());

    var singlecouncil = await councilRepo.getCouncilById(councilId: councilId);
    var groupsData = await councilRepo.getCouncilGroups(councilId: councilId);
    var swa3edData = await councilRepo.getCouncilSwa3ed(councilId: councilId);
    swa3edData.fold((l) {}, (r) {
      swa3ed = r;
    });
    groupsData.fold((l) {}, (r) {
      groups = r;
    });
    singlecouncil.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) {
        council = r;
        emit(CouncilDashboardSuccessState());
      },
    );
  }

  Future<void> getCouncilGroupById({required String groupId}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.getCouncilGroupById(
      councilId: council!.id!,
      groupId: groupId,
    );
    data.fold((l) => emit(CouncilDashboardErrorState(message: l.message)), (r) {
      group = r;
      emit(CouncilDashboardSuccessState());
    });
  }

  Future<void> addGroupMembers({required List<String> membersIds}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.addGroupMembers(
      councilId: council!.id!,
      groupId: group!.id!,
      membersIds: membersIds,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardMembersUpdatedState()),
    );
  }

  Future<void> removeGroupMembers({required List<String> membersIds}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.removeGroupMembers(
      councilId: council!.id!,
      groupId: group!.id!,
      membersIds: membersIds,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardMembersUpdatedState()),
    );
  }

  Future<void> addSwa3edMembers({required List<String> membersIds}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.addSwa3edMembers(
      councilId: council!.id!,
      swa3edId: swa3ed!.id!,
      membersIds: membersIds,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardMembersUpdatedState()),
    );
  }

  Future<void> removeSwa3edMembers({required List<String> membersIds}) async {
    emit(CouncilDashboardLoadingState());
    var data = await councilRepo.removeSwa3edMembers(
      councilId: council!.id!,
      swa3edId: swa3ed!.id!,
      membersIds: membersIds,
    );
    data.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardMembersUpdatedState()),
    );
  }

  Future<void> endCouncil() async {
    emit(CouncilDashboardLoadingState());
    var result = await councilRepo.endCouncil(councilId: council!.id!);
    result.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardEndedState()),
    );
  }

  Future<void> addGroupShield({required String shieldName}) async {
    emit(CouncilDashboardLoadingState());
    var result = await councilRepo.addGroupShield(
      councilId: council!.id!,
      groupId: group!.id!,
      shieldName: shieldName,
    );
    result.fold(
      (l) => emit(CouncilDashboardErrorState(message: l.message)),
      (r) => emit(CouncilDashboardGroupShiledAddedState()),
    );
  }
}
