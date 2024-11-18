import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reset_life/src/common_widgets/app_bar.dart';
import 'package:reset_life/src/common_widgets/scaffold.dart';
import 'package:reset_life/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:reset_life/src/themes/colors.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController.animateTo(0.0);
    _pageController = PageController();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    super.dispose();
  }

  void _onSkipClick() {
    _animationController.animateTo(0.8, duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController.value >= 0 && _animationController.value <= 0.2) {
      _animationController.animateTo(0.0);
    } else if (_animationController.value > 0.2 && _animationController.value <= 0.4) {
      _animationController.animateTo(0.2);
    } else if (_animationController.value > 0.4 && _animationController.value <= 0.6) {
      _animationController.animateTo(0.4);
    } else if (_animationController.value > 0.6 && _animationController.value <= 0.8) {
      _animationController.animateTo(0.6);
    } else if (_animationController.value > 0.8 && _animationController.value <= 1.0) {
      _animationController.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController.value >= 0 && _animationController.value <= 0.2) {
      _animationController.animateTo(0.4);
    } else if (_animationController.value > 0.2 && _animationController.value <= 0.4) {
      _animationController.animateTo(0.6);
    } else if (_animationController.value > 0.4 && _animationController.value <= 0.6) {
      _animationController.animateTo(0.8);
    } else if (_animationController.value > 0.6 && _animationController.value <= 0.8) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final demoData = ref.read(onboardingControllerProvider.notifier).demoData;
    return AppScaffold(
      backgroundColor: AppColors.beige,
      body: Column(
        children: [
          // PageView.builder(
          //   itemCount: demoData,
          //   itemBuilder: (context, index) {
          //     return Column(
          //       children: [Text('ref.')],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
