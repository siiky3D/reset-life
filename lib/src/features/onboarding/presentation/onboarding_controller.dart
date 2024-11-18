import 'dart:async';

import 'package:reset_life/gen/assets.gen.dart';
import 'package:reset_life/src/features/onboarding/data/onboard.dart';
import 'package:reset_life/src/features/onboarding/data/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  late final List<OnBoard> demoData;

  @override
  FutureOr<void> build() {
    //
    demoData = createDemoData();
  }

  List<OnBoard> createDemoData() {
    return [
      OnBoard(
        image: Assets.svgs.christmas,
        title: "Find Best Christmas All Around Your City",
        desc: "Thousands of musicians around you are waiting to rock your event.",
      ),
      OnBoard(
        image: Assets.svgs.doctors,
        title: "Fastest Way To Book Great Doctors",
        desc: "Find the perfect match to perform for your event and make the day remarkable.",
      ),
      OnBoard(
        image: Assets.svgs.traveling,
        title: "Find Top Sessions Pros For Your Traveling",
        desc: "Find the perfect match to perform for your event and make the day remarkable.",
      ),
    ];
  }

  Future<void> completeOnboarding() async {
    final onboardingRepository = ref.watch(onboardingRepositoryProvider).requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}
