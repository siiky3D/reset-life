import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/src/features/authentication/data/auth_repository.dart';
import 'package:my_app/src/features/home/presentation/home.dart';
import 'package:my_app/src/routing/go_router_refresh_stream.dart';
import 'package:my_app/src/routing/not_found_screen.dart';
import 'package:my_app/src/routing/scaffold_with_nested_navigation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');

/// All the supported routes in the app.
/// By using an enum, we route by name using this syntax:
/// ```dart
/// context.goNamed(AppRoute.orders.name)
/// ```
enum AppRoute {
  home,
  statistics,
  activity,
  profile,
  signin,
  signup,
}

/// returns the GoRouter instance that defines all the routes in the app
final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    // * redirect logic based on the authentication state
    redirect: (context, state) async {
      final user = authRepository.currentUser;
      final isLoggedIn = user != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
        final isAdmin = await user.isAdmin();
        // prevent non-admin users to navigate to any of the admin pages
        if (!isAdmin && path.startsWith('/admin')) {
          return '/';
        }
      } else {
        if (path == '/account' || path == '/orders') {
          return '/';
        }
        // prevent non signed-in users to navigate to any of the admin pages
        if (path.startsWith('/admin')) {
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      // GoRoute(
      //   path: '/',
      //   name: AppRoute.home.name,
      //   builder: (context, state) => const HomeScreen(),
      //   routes: [],
      // ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
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
                builder: (context, state) => const HomeScreen(),
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
