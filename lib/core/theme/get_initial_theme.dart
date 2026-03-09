import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getInitialTheme() async {
    final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? true;
  return isDark;
}