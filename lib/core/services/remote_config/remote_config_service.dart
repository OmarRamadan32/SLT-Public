abstract class RemoteConfigService {
  Future<void> init();
  bool getBool(String key);
  String getString(String key);
  int getInt(String key);
  
}