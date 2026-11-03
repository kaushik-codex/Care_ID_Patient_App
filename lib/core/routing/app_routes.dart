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
import '../../features/records/presentation/pages/add_health_record_page.dart';
import '../../features/records/presentation/pages/dental_record_detail_page.dart';
import '../../features/records/presentation/pages/dental_records_page.dart';
import '../../features/records/presentation/pages/document_viewer_page.dart';
import '../../features/records/presentation/pages/health_records_landing_page.dart';
import '../../features/records/presentation/pages/medical_records_page.dart';
import '../../features/records/presentation/pages/ocr_processing_report_page.dart';
import '../../features/records/presentation/pages/record_details_hub_page.dart';
import '../../features/records/presentation/pages/record_saved_success_page.dart';
import '../../features/records/presentation/pages/review_health_record_page.dart';
import '../../features/records/presentation/pages/scan_reports_page.dart';
import '../../features/records/presentation/pages/upload_medical_record_page.dart';
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
import '../../features/family/presentation/pages/add_family_member_access_page.dart';
import '../../features/family/presentation/pages/add_family_member_form_page.dart';
import '../../features/family/presentation/pages/add_family_member_review_page.dart';
import '../../features/family/presentation/pages/family_consent_requests_page.dart';
import '../../features/family/presentation/pages/family_dashboard_page.dart';
import '../../features/family/presentation/pages/family_member_list_page.dart';
import '../../features/family/presentation/pages/invitation_sent_page.dart';
import '../../features/family/presentation/pages/member_permissions_sharing_page.dart';
import '../../features/family/presentation/pages/shared_health_card_dependent_page.dart';
import '../../features/family/presentation/pages/shared_medical_records_page.dart';
import '../../features/appointments/presentation/pages/doctors_page.dart';
import '../../features/appointments/presentation/pages/doctor_profile_page.dart';
import '../../features/appointments/presentation/pages/book_appointment_type_page.dart';
import '../../features/appointments/presentation/pages/book_appointment_date_time_page.dart';
import '../../features/appointments/presentation/pages/review_appointment_page.dart';
import '../../features/appointments/presentation/pages/appointment_confirmation_page.dart';
import '../../features/appointments/presentation/pages/my_appointments_page.dart';
import '../../features/appointments/presentation/pages/appointment_details_page.dart';
import '../../features/appointments/presentation/pages/appointment_details_actions_page.dart';
import '../../features/appointments/presentation/pages/reschedule_appointment_page.dart';
import '../../features/appointments/presentation/widgets/cancel_appointment_dialog.dart';
import '../../features/appointments/presentation/pages/live_chat_page.dart';
import '../../features/appointments/presentation/pages/full_kiosk_pass_page.dart';
import '../../features/appointments/domain/models/appointment_models.dart';
import '../../features/insurance/presentation/pages/insurance_dashboard_page.dart';
import '../../features/insurance/presentation/pages/add_insurance_select_method_page.dart';
import '../../features/insurance/presentation/pages/insurance_camera_capture_page.dart';
import '../../features/insurance/presentation/pages/insurance_ocr_processing_page.dart';
import '../../features/insurance/presentation/pages/insurance_extraction_results_page.dart';
import '../../features/insurance/presentation/pages/insurance_manual_review_page.dart';
import '../../features/insurance/presentation/pages/insurance_card_details_page.dart';
import '../../features/insurance/presentation/pages/insurance_financing_hub_page.dart';

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
  static const String uploadMedicalRecord = '/upload-medical-record';
  static const String scanReports = '/scan-reports';
  static const String ocrProcessingReport = '/ocr-processing-report';
  static const String reviewHealthRecord = '/review-health-record';
  static const String addHealthRecord = '/add-health-record';
  static const String recordSavedSuccess = '/record-saved-success';
  static const String familyDashboard = '/family-dashboard';
  static const String familyMemberList = '/family-member-list';
  static const String addFamilyMemberForm = '/add-family-member-form';
  static const String addFamilyMemberAccess = '/add-family-member-access';
  static const String addFamilyMemberReview = '/add-family-member-review';
  static const String invitationSent = '/invitation-sent';
  static const String familyConsentRequests = '/family-consent-requests';
  static const String memberPermissionsSharing = '/member-permissions-sharing';
  static const String sharedHealthCardDependent = '/shared-health-card-dependent';
  static const String sharedMedicalRecords = '/shared-medical-records';
  static const String doctors = '/doctors';
  static const String doctorProfile = '/doctor-profile';
  static const String bookAppointmentType = '/book-appointment-type';
  static const String bookAppointmentDateTime = '/book-appointment-datetime';
  static const String reviewAppointment = '/review-appointment';
  static const String appointmentConfirmation = '/appointment-confirmation';
  static const String myAppointments = '/my-appointments';
  static const String appointmentDetails = '/appointment-details';
  static const String appointmentDetailsActions = '/appointment-details-actions';
  static const String rescheduleAppointment = '/reschedule-appointment';
  static const String cancelAppointmentDialog = '/cancel-appointment-dialog';
  static const String liveChat = '/live-chat';
  static const String kioskPass = '/kiosk-pass';
  static const String insuranceDashboard = '/insurance-dashboard';
  static const String addInsuranceMethod = '/add-insurance-method';
  static const String insuranceCameraCapture = '/insurance-camera-capture';
  static const String insuranceOcrProcessing = '/insurance-ocr-processing';
  static const String insuranceExtractionResults = '/insurance-extraction-results';
  static const String insuranceManualReview = '/insurance-manual-review';
  static const String insuranceCardDetails = '/insurance-card-details';
  static const String insuranceFinancingHub = '/insurance-financing-hub';

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
        uploadMedicalRecord: (context) => const UploadMedicalRecordPage(),
        scanReports: (context) => const ScanReportsPage(),
        ocrProcessingReport: (context) => const OcrProcessingReportPage(),
        reviewHealthRecord: (context) => const ReviewHealthRecordPage(),
        addHealthRecord: (context) => const AddHealthRecordPage(),
        recordSavedSuccess: (context) => const RecordSavedSuccessPage(),
        familyDashboard: (context) => const FamilyDashboardPage(),
        familyMemberList: (context) => const FamilyMemberListPage(),
        addFamilyMemberForm: (context) => const AddFamilyMemberFormPage(),
        addFamilyMemberAccess: (context) => const AddFamilyMemberAccessPage(),
        addFamilyMemberReview: (context) => const AddFamilyMemberReviewPage(),
        invitationSent: (context) => const InvitationSentPage(),
        familyConsentRequests: (context) => const FamilyConsentRequestsPage(),
        memberPermissionsSharing: (context) => const MemberPermissionsSharingPage(),
        sharedHealthCardDependent: (context) => const SharedHealthCardDependentPage(),
        sharedMedicalRecords: (context) => const SharedMedicalRecordsPage(),
        doctors: (context) => const DoctorsPage(),
        doctorProfile: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final doc = args is Doctor ? args : null;
          return DoctorProfilePage(doctor: doc);
        },
        bookAppointmentType: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final doc = args is Doctor ? args : null;
          return BookAppointmentTypePage(doctor: doc);
        },
        bookAppointmentDateTime: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          Doctor? doc;
          ConsultationOption? type;
          if (args is Map<String, dynamic>) {
            if (args['doctor'] is Doctor) doc = args['doctor'];
            if (args['consultationType'] is ConsultationOption) {
              type = args['consultationType'];
            }
          }
          return BookAppointmentDateTimePage(
            doctor: doc,
            consultationType: type,
          );
        },
        reviewAppointment: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          Doctor? doc;
          ConsultationOption? type;
          DateTime? date;
          String? time;
          if (args is Map<String, dynamic>) {
            if (args['doctor'] is Doctor) doc = args['doctor'];
            if (args['consultationType'] is ConsultationOption) {
              type = args['consultationType'];
            }
            if (args['appointmentDate'] is DateTime) {
              date = args['appointmentDate'];
            }
            if (args['timeSlot'] is String) time = args['timeSlot'];
          }
          return ReviewAppointmentPage(
            doctor: doc,
            consultationType: type,
            appointmentDate: date,
            timeSlot: time,
          );
        },
        appointmentConfirmation: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return AppointmentConfirmationPage(appointment: apt);
        },
        myAppointments: (context) => const MyAppointmentsPage(),
        appointmentDetails: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return AppointmentDetailsPage(appointment: apt);
        },
        appointmentDetailsActions: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return AppointmentDetailsActionsPage(appointment: apt);
        },
        rescheduleAppointment: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return RescheduleAppointmentPage(appointment: apt);
        },
        cancelAppointmentDialog: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return CancelAppointmentPage(appointment: apt);
        },
        liveChat: (context) => const LiveChatPage(),
        kioskPass: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final apt = args is PatientAppointment ? args : null;
          return FullKioskPassPage(appointment: apt);
        },
        insuranceDashboard: (context) => const InsuranceDashboardPage(),
        addInsuranceMethod: (context) => const AddInsuranceSelectMethodPage(),
        insuranceCameraCapture: (context) => const InsuranceCameraCapturePage(),
        insuranceOcrProcessing: (context) => const InsuranceOcrProcessingPage(),
        insuranceExtractionResults: (context) => const InsuranceExtractionResultsPage(),
        insuranceManualReview: (context) => const InsuranceManualReviewPage(),
        insuranceCardDetails: (context) => const InsuranceCardDetailsPage(),
        insuranceFinancingHub: (context) => const InsuranceFinancingHubPage(),
      };
}
