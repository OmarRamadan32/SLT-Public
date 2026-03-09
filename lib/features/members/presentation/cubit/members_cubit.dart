import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/members/data/repos/members_repo.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit({required this.membersRepo}) : super(MembersInitial());

  final MembersRepo membersRepo;
  List<UserModel> teamMembers = [];
  List<UserModel> mainBoardMembers = [];
  List<UserModel> subBoardMembers = [];
  List<UserModel> teamLeaders = [];
  Future<void> getAllTeamMembers({
    required String? startAfter,
    bool append = false,
  }) async {
    const limit = 10;
    if (!append) {
      emit(MembersLoadingState());
    } else {
      emit(MembersLoadingMoreState());
    }
    var result = await membersRepo.getAllTeamMembers(
      limit: limit,
      startAfter: startAfter,
    );
    result.fold(
      (failure) => emit(MembersErrorState(errorMessage: failure.message)),
      (members) {
        if (members.isEmpty) {
          emit(MembersNoMoreState());
        } else {
          if (append) {
            teamMembers.addAll(members);
            members.length < limit
                ? emit(MembersNoMoreState())
                : emit(MembersSuccessState());
          } else {
            teamMembers = members;
          }
        }
      },
    );
  }

  Future<void> getAllMainBoardMembers() async {
    var result = await membersRepo.getAllMainBoardMembers();
    result.fold(
      (failure) => emit(MembersErrorState(errorMessage: failure.message)),
      (members) {
        mainBoardMembers = members;
      },
    );
  }

  Future<void> getAllSubBoardMembers() async {
    var result = await membersRepo.getAllSubBoardMembers();
    result.fold(
      (failure) => emit(MembersErrorState(errorMessage: failure.message)),
      (members) {
        subBoardMembers = members;
      },
    );
  }

  Future<void> getAllTeamLeaders() async {
    var result = await membersRepo.getAllTeamLeaders();
    result.fold(
      (failure) => emit(MembersErrorState(errorMessage: failure.message)),
      (members) {
        teamLeaders = members;
        if (!isClosed) emit(MembersSuccessState());
      },
    );
  }

  Future<void> updateProfileDetails({required UserModel userModel}) async {
    emit(MembersLoadingState());
    final result = await membersRepo.updateMemberData(userModel: userModel);
    result.fold(
      (failure) => emit(MembersErrorState(errorMessage: failure.message)),
      (r) => emit(MembersSuccessState()),
    );
  }

  Future<void> getAllMembersMethod({
    bool append = false,
    String? startAfter,
  }) async {
    await getAllTeamMembers(append: append, startAfter: startAfter);
    await getAllMainBoardMembers();
    await getAllSubBoardMembers();
    await getAllTeamLeaders();
  }
}
