import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/services/auth/auth_service.dart';
import 'package:new_slt/core/services/cloud/storage_service.dart';
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/core/global_cubits/remote_config_cubit.dart/remote_config_cubit.dart';
import 'package:new_slt/features/schedule/data/repos/schedule_repo.dart';
import 'package:new_slt/features/user/data/repos/user_repo.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/global_cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:new_slt/core/global_cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/app_theme.dart';
import 'package:new_slt/core/di/service_locator.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';

class SLTAPP extends StatelessWidget {
  const SLTAPP({super.key, required this.initialThemeMode});
  final ThemeMode initialThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Remote Config
        BlocProvider(
          create:
              (context) => RemoteConfigCubit(
                remoteConfigService: getItInstance.get<RemoteConfigService>(),
              ),
        ),

        // Botton Navigation Bar
        BlocProvider(create: (context) => BottomNavigationBarCubit()),
        // Auth
        BlocProvider(
          create:
              (context) => AuthCubit(
                db: getItInstance.get<DatabaseService>(),
                auth: getItInstance.get<AuthService>(),
                storage: getItInstance.get<StorageService>(),
              ),
        ),
        // Users
        BlocProvider(
          create:
              (context) => UserCubit(
                storageService: getItInstance.get<StorageService>(),
                userRepo: getItInstance.get<UserRepo>(),
                authService: getItInstance.get<AuthService>(),
              ),
        ),
        // Theme
        BlocProvider(
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          create: (context) => AppThemeCubit()..emit(initialThemeMode),
        ),
        // Schedule
        BlocProvider(
          create: (context) => ScheduleCubit(getItInstance.get<ScheduleRepo>()),
        ),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder:
            (context, themeMode) => ScreenUtilInit(
              designSize: const Size(412, 915),
              minTextAdapt: true,
              useInheritedMediaQuery: true,
              splitScreenMode: true,

              builder: (context, child) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerConfig: AppRouter.router,
                  darkTheme: AppTheme.darkTheme,
                  theme: AppTheme.lightTheme,
                  themeMode: themeMode,
                  builder: (context, widget) {
                    final mediaQuery = MediaQuery.of(context);
                    return MediaQuery(
                      data: mediaQuery.copyWith(
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      child: widget!,
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}
