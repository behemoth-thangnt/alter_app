import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Authentication
import '../../features/authentication/presentation/pages/sign_in_page.dart';

// Profile
import '../../features/profile/presentation/pages/profile_page.dart';

// Shared
import '../../shared/presentation/pages/splash_page.dart';
import '../../shared/presentation/pages/home_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',
      routes: [
        // Splash Route
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),

        // Authentication Routes
        GoRoute(
          path: '/sign-in',
          name: 'sign-in',
          builder: (context, state) => const SignInPage(),
        ),

        // Main App Routes (Protected)
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );
  }
}
