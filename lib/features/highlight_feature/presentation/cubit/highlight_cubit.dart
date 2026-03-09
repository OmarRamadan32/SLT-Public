import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';
import 'package:new_slt/features/highlight_feature/data/repo/member_of_the_month_repo.dart';
part 'highlight_state.dart';

/*
Highlight Feature:
its the feature that is responsible for showing the members of the month if there is no any highlights
Highlights: its an event or an announcement or a countdown that will be shown on the home screen

*/
class HightlightCubit extends Cubit<HighlightState> {
  MemberOfTheMonthRepo memberOfTheMonthRepo; // Member of the month
  RemoteConfigService remoteConfigService;
  HightlightCubit({
    required this.memberOfTheMonthRepo,
    required this.remoteConfigService,
  }) : super(HighlightInitial());

  // if there is no highlights, get the member of the month
  Future<void> getHighlight() async {
    emit(HighlightLoading());
    final result = await memberOfTheMonthRepo.getMemberOfTheMonth();
    final result2 = remoteConfigService.getString(Constants.highlightConfig);
    final List<Map<String, dynamic>> highlights = Helpers.convertJsonStringToList(
      result2,
    );
    final List<HighlightModel> highlightModels =
        highlights
            .map((e) => HighlightModel.fromHighlightJson(e))
            .where((element) => element.isActive == true)
            .toList();
  final List<HighlightModel>  memberOfTheMonthModels = result.fold((l) => [], (r) => r );
    if (highlightModels.isNotEmpty) {
      emit(HighlightLoaded(models: [
        ...highlightModels,
        ...memberOfTheMonthModels
      ]));
    } else {
           emit(HighlightLoaded(models: memberOfTheMonthModels));
    }
  }
}
