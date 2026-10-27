import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String createAccount = '/create-account';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashPage(),
        welcome: (context) => const WelcomePage(),
        // Destination routes for Phase 1 Page 3 and Page 11
        createAccount: (context) => const Scaffold(body: Center(child: Text('Create Account Flow'))),
        login: (context) => const Scaffold(body: Center(child: Text('Login Flow'))),
      };
}
