import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashPage(),
        welcome: (context) => const WelcomePage(),
      };
}
