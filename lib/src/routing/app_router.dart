import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reset_life/src/features/activity/presentation/activity_screen.dart';
import 'package:reset_life/src/features/authentication/data/auth_repository.dart';
import 'package:reset_life/src/features/home/presentation/home_screen.dart';
import 'package:reset_life/src/features/onboarding/data/onboarding_repository.dart';
import 'package:reset_life/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:reset_life/src/features/profile/presentation/profile_screen.dart';
import 'package:reset_life/src/features/record_relapse/presentation/edit_relapse_screen.dart';
import 'package:reset_life/src/features/statistics/presentation/statistics_screen.dart';
import 'package:reset_life/src/routing/app_startup.dart';
import 'package:reset_life/src/routing/go_router_refresh_stream.dart';
import 'package:reset_life/src/routing/not_found_screen.dart';
import 'package:reset_life/src/routing/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _statisticsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'statistics');
final _activityNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'activity');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

/// All the supported routes in the app.
/// By using an enum, we route by name using this syntax:
/// ```dart
/// context.goNamed(AppRoute.orders.name)
/// ```
enum AppRoute {
  onboarding,
  home,
  statistics,
  activity,
  profile,
  signin,
  signup,
  addRelapse,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final appStartupState = ref.watch(appStartupProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/signIn',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }
      final onboardingRepository = ref.read(onboardingRepositoryProvider).requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/signIn')) {
          return '/home';
        }
      } else {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/home') ||
            path.startsWith('/statistics') ||
            path.startsWith('/activity') ||
            path.startsWith('/profile')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            // * This is just a placeholder
            // * The loaded route will be managed by GoRouter on state change
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const HomeScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _statisticsNavigatorKey,
            routes: [
              GoRoute(
                path: '/statistics',
                name: AppRoute.statistics.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const StatisticsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: AppRoute.addRelapse.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const MaterialPage(
                        fullscreenDialog: true,
                        child: EditRelapseScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _activityNavigatorKey,
            routes: [
              GoRoute(
                path: '/activity',
                name: AppRoute.activity.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const ActivityScreen(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const ProfileScreen(),
                ),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
