import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/core/constants/constants.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final RemoteConfigService remoteConfigService;
  RemoteConfigCubit({required this.remoteConfigService})
    : super(RemoteConfigInitial());

  String loadAppTitle() {
    return remoteConfigService.getString(Constants.appTitleConfig);
  }

  bool loadAppState() {
    return remoteConfigService.getBool(Constants.appStateConfig);
  }

  String loadAppVersion() {
    return remoteConfigService.getString(Constants.appVersionConfig);
  }

  String loadStarMembers() {
    return remoteConfigService.getString(Constants.highlightConfig);
  }
}
