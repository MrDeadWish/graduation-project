import 'package:binevir/components/scaffold_with_nav_bar.dart';
import 'package:binevir/screens/error_screen.dart';
import 'package:binevir/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:binevir/screens/home_screen.dart';
import 'package:binevir/screens/calculator/calculator_screen.dart';
import 'package:binevir/screens/catalog/catalog_screen.dart';
import 'package:binevir/screens/profile/profile_screen.dart';


final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
    initialLocation: '/welcome',
  errorBuilder: (context, state) => ErrorScreen(),
 routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/catalog',
          builder: (context, state) => const CatalogScreen(),
        ),
        GoRoute(
          path: '/calculator',
          builder: (context, state) => const CalculatorScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    
    /*
    // Страницы без навбара (Splash, Guide и т.п.)
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
        */
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const OnboardingScreen(),
    ),

  ],
);

