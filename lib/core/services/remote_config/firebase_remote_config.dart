import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:new_slt/core/constants/constants.dart';

class FirebaseRemoteConfigService implements RemoteConfigService {
  final Map<String, dynamic> _remoteConfigMap = {
    Constants.appStateConfig: true,
    Constants.appTitleConfig: "فريق القادة الإجتماعيين",
    Constants.appVersionConfig: Constants.appVersion,
    Constants.highlightConfig: "",
  };
  final remoteConfig = FirebaseRemoteConfig.instance;
  @override
  Future<void> init() async {
    // Initialize Firebase Remote Config here
    await remoteConfig.setDefaults(_remoteConfigMap); // default value
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        // if it takes more than 1 minute to fetch, then work with the default value
        fetchTimeout: const Duration(minutes: 1),
        // the changes will be fetched every 1 hour
        minimumFetchInterval: const Duration(minutes: 20),
      ),
    );
    await remoteConfig.fetchAndActivate();
  }

  @override
  bool getBool(String key) {
    return remoteConfig.getBool(key);
  }

  @override
  int getInt(String key) {
    return remoteConfig.getInt(key);
  }

  @override
  String getString(String key) {
    return remoteConfig.getString(key);
  }
}
