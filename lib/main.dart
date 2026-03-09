import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:new_slt/core/theme/get_initial_theme.dart';
import 'package:new_slt/core/utils/bloc_observer.dart';
import 'package:new_slt/core/di/service_locator.dart';
import 'package:new_slt/firebase_options.dart';
import 'package:new_slt/slt_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // قفل الاتجاه على الوضع العمودي فقط
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setupServiceLocator();

  final isDark = await getInitialTheme();
  // change the initialThemeMode based on the user's preference
  Bloc.observer = SimpleBlocObserver();
  runApp(SLTAPP(initialThemeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  
}
