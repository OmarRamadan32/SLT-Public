import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page10_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page11_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page1_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page2_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page3_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page4_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page5_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page6_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page8_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page9_body.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: "أهلا بيك"),
      bodyWidget: const OnboardingPage1Body(),
      image: SvgPicture.asset(Assets.page1),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'المواعيد'),
      bodyWidget: const OnboardingPage2Body(),
      image: SvgPicture.asset(Assets.page2),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'إضافة مواعيد'),
      bodyWidget: const OnboardingPage3Body(),
      image: SvgPicture.asset(Assets.page3),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'التسجيل في المواعيد'),
      bodyWidget: const OnboardingPage4Body(),
      image: SvgPicture.asset(Assets.page4),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'البوستات'),
      bodyWidget: const OnboardingPage5Body(),
      image: SvgPicture.asset(Assets.page5),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'إضافة بوست'),
      bodyWidget: const OnboardingPage6Body(),
      image: SvgPicture.asset(Assets.page6),
    ),
    // PageViewModel(
    //   titleWidget: const OnboardingTitleWidget(title: 'التسجيل في البوست'),
    //   bodyWidget: const OnboardingPage7Body(),
    //   image: SvgPicture.asset(Assets.postCard),
    // ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'الصلاحيات'),
      bodyWidget: const OnboardingPage8Body(),
      image: SvgPicture.asset(Assets.page8),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'رسائل الفريق'),
      bodyWidget: const OnboardingPage9Body(),
      image: SvgPicture.asset(Assets.page9),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'ازاي تبعت رسالة'),
      bodyWidget: const OnboardingPage10Body(),
      image: SvgPicture.asset(Assets.page10),
    ),
    PageViewModel(
      titleWidget: const OnboardingTitleWidget(title: 'ايه الهدف من كل ده !'),
      bodyWidget: const OnboardingPage11Body(),
      image: SvgPicture.asset(Assets.page11),
    ),
  ];
  Future doneMethod(BuildContext context) async {
    final router = GoRouter.of(context);
    UserCubit userCubit = context.read<UserCubit>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userCubit.userModel != null) {
      prefs.setBool(Constants.isFirstTime, false);
      router.pushReplacement(AppRouter.kHomePage);
    } else {
      prefs.setBool(Constants.isFirstTime, false);
      router.pushReplacement(AppRouter.kLoginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: IntroductionScreen(
          bodyPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
          curve: Curves.easeInOutExpo,
          animationDuration: 500,
          showBackButton: true,
          dotsFlex: 8,
          dotsDecorator: DotsDecorator(
            activeColor: theme.primaryColor,
            size: const Size(10, 10),
            activeSize: const Size(22, 10),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          back: FaIcon(
            FontAwesomeIcons.angleLeft,
            size: 22.sp,
            color: theme.textTheme.titleLarge!.color!,
          ),
          next: FaIcon(
            FontAwesomeIcons.angleRight,
            size: 22.sp,
            color: theme.textTheme.titleLarge!.color!,
          ),
          done: FaIcon(
            FontAwesomeIcons.check,
            size: 22.sp,
            color: theme.textTheme.titleLarge!.color!,
          ),
          onDone: () {
            doneMethod(context);
          },
          pages: pages,
          globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
