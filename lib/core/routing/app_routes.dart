import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/mobile_number_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/onboarding/presentation/pages/add_insurance_page.dart';
import '../../features/onboarding/presentation/pages/health_info_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String createAccount = '/create-account';
  static const String mobileNumber = '/mobile-number';
  static const String healthInfo = '/health-info';
  static const String addInsurance = '/add-insurance';
  static const String privacyConsents = '/privacy-consents';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashPage(),
        welcome: (context) => const WelcomePage(),
        createAccount: (context) => const CreateAccountPage(),
        mobileNumber: (context) => const MobileNumberPage(),
        healthInfo: (context) => const HealthInfoPage(),
        addInsurance: (context) => const AddInsurancePage(),
        privacyConsents: (context) => const Scaffold(body: Center(child: Text('Privacy & Consents Step'))),
        login: (context) => const Scaffold(body: Center(child: Text('Login Flow'))),
      };
}
