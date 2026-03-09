import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/features/council/data/repos/council_repo.dart';

part 'council_state.dart';

class CouncilCubit extends Cubit<CouncilState> {
  final CouncilRepo councilRepo;
  CouncilCubit({required this.councilRepo}) : super(CouncilInitialState());

  List<CouncilModel> councils = [];
  List<GroupModel> groups = [];
  CouncilModel? council;
  Swa3edModel? swa3ed;
  GroupModel? group;

  Future<void> getAllCouncils() async {
    emit(CouncilLoadingState());
    var result = await councilRepo.getAllCouncils();
    result.fold((l) => emit(CouncilErrorState(message: l.message)), (r) {
      councils = r;
     if (!isClosed)  emit(CouncilSuccessState());
    });
  }

  Future<void> getCouncilEventsById({required String councilId}) async {
    groups = [];
    swa3ed = null;
    emit(CouncilLoadingState());
    var councilResult = await councilRepo.getCouncilById(councilId: councilId);
    var swa3edResult = await councilRepo.getCouncilSwa3ed(councilId: councilId);
    var groupsResult = await councilRepo.getCouncilGroups(councilId: councilId);
    swa3edResult.fold((l) {}, (r) => swa3ed = r);
    groupsResult.fold((l) {}, (r) => groups = r);
    councilResult.fold((l) => emit(CouncilErrorState(message: l.message)), (r) {
      council = r;
      emit(CouncilSuccessState());
    });
  }

  // Future<void> getCouncilGroups() async {
  //   emit(CouncilLoadingState());
  //   var result = await councilRepo.getCouncilGroups(councilId: council!.id!);
  //   result.fold((l) => emit(CouncilErrorState(message: l.message)), (r) {
  //     groups = r;
  //     emit(CouncilSuccessState());
  //   });
  // }

  Future<void> getCouncilGroupById({required String groupId}) async {
    emit(CouncilLoadingState());
    var result = await councilRepo.getCouncilGroupById(
      councilId: council!.id!,
      groupId: groupId,
    );
    result.fold((l) => emit(CouncilErrorState(message: l.message)), (r) {
      group = r;
      emit(CouncilSuccessState());
    });
  }

  // Future<void> getCouncilSwa3ed() async {
  //   emit(CouncilLoadingState());
  //   var result = await councilRepo.getCouncilSwa3ed(councilId: council!.id!);
  //   result.fold((l) => emit(CouncilErrorState(message: l.message)), (r) {
  //     swa3ed = r;
  //     emit(CouncilSuccessState());
  //   });
  // }
}
