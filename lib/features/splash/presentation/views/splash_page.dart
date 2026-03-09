import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/core/global_cubits/remote_config_cubit.dart/remote_config_cubit.dart';
import 'package:new_slt/core/services/remote_config/remote_config_service.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/di/service_locator.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 250));
      await _initApp();
    });
  }

  Future<void> _initApp() async {
    await _requestNotificationPermission();
    await _initRemoteConfig();
    final bool isFirstTime = await _checkIfFirstTime();
    final bool isLoggedIn = await _checkIfLoggedIn();
    final bool appState = await _checkAppState();
    final bool appVersion = await _checkAppVersion();
   await _navigation(
      isFirstTime: isFirstTime,
      isLoggedIn: isLoggedIn,
      appState: appState,
      appVersion: appVersion,
    );
  }

  Future<void> _initRemoteConfig() async {
    await getItInstance.get<RemoteConfigService>().init(); // init remote config

  }

  Future<bool> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool(Constants.isFirstTime) ?? true;
    return isFirstTime;
  }

  Future<bool> _checkIfLoggedIn() async {
    AuthCubit authCubit = context.read<AuthCubit>();
    final bool isLoggedIn = await authCubit.isLoggedIn();
    return isLoggedIn;
  }

  Future<bool> _checkAppState() async {
    RemoteConfigCubit remoteConfigCubit = context.read<RemoteConfigCubit>();
    final bool appState = remoteConfigCubit.loadAppState();
    return appState;
  }

  Future<bool> _checkAppVersion() async {
    RemoteConfigCubit remoteConfigCubit = context.read<RemoteConfigCubit>();
    final String appVersion = remoteConfigCubit.loadAppVersion();
    final String appConsVersion = Constants.appVersion;
    return appVersion == appConsVersion;
  }

  Future<void> _requestNotificationPermission() async {
    NotificationService notificationService =
        getItInstance.get<NotificationService>();
    await notificationService.requestNotificationPermission();
  }

  Future<void> _saveTokenToDatabase() async {
    NotificationService notificationService =
        getItInstance.get<NotificationService>();
    await notificationService.saveTokenToDatabase();
  }

  Future<void> _getCurrentUser() async {
    UserCubit userCubit = context.read<UserCubit>();
    await userCubit.getCurrentUser();
  }

 Future<void> _navigation({
    required bool isFirstTime,
    required bool isLoggedIn,
    required bool appState,
    required bool appVersion,
  }) async {
    final router = GoRouter.of(context);
    if (appState && appVersion) {
      if (isLoggedIn) {
        await _getCurrentUser();
        await _saveTokenToDatabase();
        if (isFirstTime) {
          router.pushReplacement(AppRouter.kOnboardingPage);
        } else {
          router.pushReplacement(AppRouter.kHomePage);
        }
      } else {
        if (isFirstTime) {
          router.pushReplacement(AppRouter.kOnboardingPage);
        } else {
          router.pushReplacement(AppRouter.kLoginPage);
        }
      }
      // if the app is Closed
    } else if (appState == false) {
      final String closedImage = Assets.appStateClosed;
      final String message = "التطبيق خارج الخدمة حاليًا";
      router.pushReplacement(
        "${AppRouter.kappStatePage}?stateImage=$closedImage&message=$message",
      );
      // if the app is outDated
    } else if (appVersion == false) {
      final String updateImage = Assets.appStateUpdateRequired;
      final String message = "يجب عليك تحديث التطبيق لاخر إصدار";
      final String url = Constants.appStoreLink;
      router.pushReplacement(
        "${AppRouter.kappStatePage}?stateImage=$updateImage&message=$message&url=$url",
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeInAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: Image.asset(
                        Assets.sltLogo,
                        height: 200.h,
                        width: 200.w,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ArabicTextWidget(
                      text: "اكتر من مجرد فريق",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spaces.inSectionSpace20,
                    Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),

                    const Spacer(),

                    Padding(
                      padding: EdgeInsets.only(right: 30.w),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ArabicTextWidget(
                              text: "تمت البرمجة بواسطة",
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(),
                            ),
                            ArabicTextWidget(
                              text: "عمر رمضان",
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
