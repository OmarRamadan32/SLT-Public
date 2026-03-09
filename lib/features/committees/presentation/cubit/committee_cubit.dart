import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/data/repos/committee_repo.dart';

part 'committee_state.dart';

class CommitteeCubit extends Cubit<CommitteeState> {
  final CommitteeRepo committeeRepo;
  CommitteeCubit({required this.committeeRepo}) : super(CommitteeInitialState());
  // to hold all committees
  List<CommitteeModel> committees = [];

  Future<void> getAllCommittees() async {
    emit(CommitteeLoadingState());
    var result = await committeeRepo.getAllCommittees();
    result.fold((error) => emit(CommitteeErrorState(message: error.message)), (
      committees,
    ) {
      this.committees = committees;
      if (!isClosed) emit(CommitteeSuccessState());
    });
  }
}
