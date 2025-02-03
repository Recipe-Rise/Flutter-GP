import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/OnBoarding/presentaion/Views/on_Boarding_view.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/splash/presentaion/views/wedgits/sliding_text.dart';
import 'package:fitfork_gp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  @override
  void initState() {
    super.initState();
    InitSlidingAnimation();
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => onBoarding !=null ? OnboardingScreen() : RegisterScreen1(),
          transition: Transition.fade, duration: kTranstionDuration);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetsData.flogo),
        SlidingImage(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void InitSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 8), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }
}
