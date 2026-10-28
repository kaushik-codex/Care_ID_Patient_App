import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/biometric_setup_page.dart';
import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/mobile_number_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/onboarding/presentation/pages/add_insurance_page.dart';
import '../../features/onboarding/presentation/pages/confirmed_screen_page.dart';
import '../../features/onboarding/presentation/pages/health_info_page.dart';
import '../../features/onboarding/presentation/pages/privacy_consents_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String createAccount = '/create-account';
  static const String mobileNumber = '/mobile-number';
  static const String healthInfo = '/health-info';
  static const String addInsurance = '/add-insurance';
  static const String privacyConsents = '/privacy-consents';
  static const String confirmedScreen = '/confirmed-screen';
  static const String biometricSetup = '/biometric-setup';
  static const String login = '/login';
  static const String loginOtp = '/login-otp';
  static const String accountRecovery = '/account-recovery';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashPage(),
        welcome: (context) => const WelcomePage(),
        createAccount: (context) => const CreateAccountPage(),
        mobileNumber: (context) => const MobileNumberPage(),
        healthInfo: (context) => const HealthInfoPage(),
        addInsurance: (context) => const AddInsurancePage(),
        privacyConsents: (context) => const PrivacyConsentsPage(),
        confirmedScreen: (context) => const ConfirmedScreenPage(),
        biometricSetup: (context) => const BiometricSetupPage(),
        login: (context) => const LoginPage(),
        loginOtp: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final phoneNumber = args is String ? args : null;
          return OtpVerificationPage(phoneNumber: phoneNumber);
        },
        accountRecovery: (context) => const Scaffold(body: Center(child: Text('Account Recovery'))),
        home: (context) => const Scaffold(body: Center(child: Text('Home Dashboard'))),
      };
}
