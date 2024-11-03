import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/cat/presentation/pages/home_page.dart';
import '../features/cat/presentation/pages/splash_page.dart';
import 'route_name.dart';
import 'route_path.dart';

/// A global key for the navigator.
final navigatorKey = GlobalKey<NavigatorState>();

/// A global instance of the GoRouter.
final GoRouter routeConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePath.splash,
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: RouteName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.home,
      name: RouteName.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
