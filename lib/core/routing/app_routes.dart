import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/account_recovery_page.dart';
import '../../features/auth/presentation/pages/biometric_setup_page.dart';
import '../../features/auth/presentation/pages/create_account_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/mobile_number_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/emergency/presentation/pages/emergency_center_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/smart_digital_health_card_page.dart';
import '../../features/medication/presentation/pages/medication_reminder_detail_page.dart';
import '../../features/notifications/presentation/pages/notification_center_page.dart';
import '../../features/onboarding/presentation/pages/add_insurance_page.dart';
import '../../features/records/presentation/pages/dental_record_detail_page.dart';
import '../../features/records/presentation/pages/dental_records_page.dart';
import '../../features/records/presentation/pages/document_viewer_page.dart';
import '../../features/records/presentation/pages/health_records_landing_page.dart';
import '../../features/records/presentation/pages/medical_records_page.dart';
import '../../features/records/presentation/pages/record_details_hub_page.dart';
import '../../features/records/presentation/pages/vision_record_detail_page.dart';
import '../../features/records/presentation/pages/vision_records_page.dart';
import '../../features/qr/presentation/pages/access_history_page.dart';
import '../../features/qr/presentation/pages/access_verification_page.dart';
import '../../features/qr/presentation/pages/manage_shared_access_page.dart';
import '../../features/qr/presentation/pages/qr_dashboard_page.dart';
import '../../features/qr/presentation/pages/qr_preview_page.dart';
import '../../features/qr/presentation/pages/share_options_page.dart';
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
  static const String smartHealthCard = '/smart-health-card';
  static const String qrDashboard = '/qr-dashboard';
  static const String shareOptions = '/share-options';
  static const String qrPreview = '/qr-preview';
  static const String accessHistory = '/access-history';
  static const String manageSharedAccess = '/manage-shared-access';
  static const String accessVerification = '/access-verification';
  static const String notificationCenter = '/notification-center';
  static const String emergencyCenter = '/emergency-center';
  static const String medicationReminderDetail = '/medication-reminder-detail';
  static const String recordDetailsHub = '/record-details-hub';
  static const String healthRecordsLanding = '/health-records-landing';
  static const String medicalRecords = '/medical-records';
  static const String dentalRecords = '/dental-records';
  static const String dentalRecordDetail = '/dental-record-detail';
  static const String visionRecords = '/vision-records';
  static const String visionRecordDetail = '/vision-record-detail';
  static const String documentViewer = '/document-viewer';

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
        accountRecovery: (context) => const AccountRecoveryPage(),
        home: (context) => const HomePage(),
        smartHealthCard: (context) => const SmartDigitalHealthCardPage(),
        qrDashboard: (context) => const QrDashboardPage(),
        shareOptions: (context) => const ShareOptionsPage(),
        qrPreview: (context) => const QrPreviewPage(),
        accessHistory: (context) => const AccessHistoryPage(),
        manageSharedAccess: (context) => const ManageSharedAccessPage(),
        accessVerification: (context) => const AccessVerificationPage(),
        notificationCenter: (context) => const NotificationCenterPage(),
        emergencyCenter: (context) => const EmergencyCenterPage(),
        medicationReminderDetail: (context) => const MedicationReminderDetailPage(),
        recordDetailsHub: (context) => const RecordDetailsHubPage(),
        healthRecordsLanding: (context) => const HealthRecordsLandingPage(),
        medicalRecords: (context) => const MedicalRecordsPage(),
        dentalRecords: (context) => const DentalRecordsPage(),
        dentalRecordDetail: (context) => const DentalRecordDetailPage(),
        visionRecords: (context) => const VisionRecordsPage(),
        visionRecordDetail: (context) => const VisionRecordDetailPage(),
        documentViewer: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final title = args is String ? args : null;
          return DocumentViewerPage(documentTitle: title);
        },
      };
}
