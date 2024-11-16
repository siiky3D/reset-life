import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:reset_life/src/app.dart';
import 'package:reset_life/src/app_bootstrap_firebase.dart';

import 'package:reset_life/src/exceptions/error_logger.dart';
import 'package:reset_life/src/l10n/string_hardcoded.dart';

/// Helper class to initialize services and configure the error handlers
class AppBootstrap {
  /// Create the root widget that should be passed to [runApp].
  Widget createRootWidget({required ProviderContainer container}) {
    // * Initialize CartSyncService to start the listener
    // container.read(cartSyncServiceProvider);
    // * Initialize UserTokenRefreshService
    // container.read(userTokenRefreshServiceProvider);

    // * Register error handlers. For more info, see:
    // * https://docs.flutter.dev/testing/errors
    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);

    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }

  // Register Flutter error handlers
  void registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      errorLogger.logError(details.exception, details.stack);
    };
    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.logError(error, stack);
      return true;
    };
    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An error occurred'.hardcoded),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  usePathUrlStrategy();
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // * uncomment this to connect to the Firebase emulators
  // await appBootstrap.setupEmulators();
  // Stripe setup

  // await appBootstrap.setupStripe();

  // create a container configured with all the Firebase repositories
  final container = await appBootstrap.createFirebaseProviderContainer();
  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  // start the app
  runApp(root);
}
