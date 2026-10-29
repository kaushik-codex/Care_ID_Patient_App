import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:care_id_patient_app/main.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/account_recovery_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/biometric_setup_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/create_account_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/login_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/mobile_number_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/splash_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:care_id_patient_app/features/home/presentation/pages/home_page.dart';
import 'package:care_id_patient_app/features/home/presentation/pages/smart_digital_health_card_page.dart';
import 'package:care_id_patient_app/features/onboarding/presentation/pages/add_insurance_page.dart';
import 'package:care_id_patient_app/features/qr/presentation/pages/qr_dashboard_page.dart';
import 'package:care_id_patient_app/features/onboarding/presentation/pages/health_info_page.dart';
import 'package:care_id_patient_app/features/onboarding/presentation/pages/privacy_consents_page.dart';
import 'package:care_id_patient_app/features/onboarding/presentation/pages/confirmed_screen_page.dart';

void main() {
  testWidgets('Splash page renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CareIDPatientApp());
    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets('Welcome page renders all cards and actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomePage(),
      ),
    );

    // Verify key titles
    expect(find.text('Your Health\nAll In One Place'), findsOneWidget);
    expect(find.text('Medical'), findsOneWidget);
    expect(find.text('Dental'), findsOneWidget);
    expect(find.text('Vision'), findsOneWidget);
    expect(find.text('Pets'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('I already have an account'), findsOneWidget);

    // Verify Language toggle
    expect(find.text('EN'), findsOneWidget);
    expect(find.text('ESP'), findsOneWidget);

    // Tap ESP
    await tester.tap(find.text('ESP'));
    await tester.pumpAndSettle();
  });

  testWidgets('CreateAccountPage renders all form inputs, checkbox and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CreateAccountPage(),
      ),
    );

    // Verify Title & Subtitle
    expect(find.text('Create your Care ID'), findsOneWidget);
    expect(
      find.text('Create your secure account to access and manage your\nhealth information in one place.'),
      findsOneWidget,
    );

    // Verify Fields
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Enter your full name'), findsOneWidget);

    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('Enter your mobile number'), findsOneWidget);

    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Enter your email address'), findsOneWidget);

    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create a password'), findsOneWidget);
    expect(find.text('Strong security standard'), findsOneWidget);

    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Re-enter your password'), findsOneWidget);

    // Verify Agreement and CTA
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Already have a Care ID account? '), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    // Enter full name
    await tester.enterText(find.widgetWithText(TextField, 'Enter your full name'), 'Kaushik Doe');
    expect(find.text('Kaushik Doe'), findsOneWidget);
  });

  testWidgets('MobileNumberPage renders step indicator, OTP cells, cards, and autofill', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MobileNumberPage(),
      ),
    );

    // Header & Step Indicator
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0)); // Default tester surface width is 800.0

    expect(find.text('VERIFICATION STEP'), findsOneWidget);
    expect(find.text('Step 2 of 6'), findsOneWidget);
    expect(find.text('Verify your mobile number'), findsOneWidget);

    // Masked phone card
    expect(find.text('Recipient Number'), findsOneWidget);
    expect(find.text('+91 ••••• ••890'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);

    // Autofill Chip
    final autofillFinder = find.byWidgetPredicate(
      (widget) => widget is RichText && widget.text.toPlainText().contains('Autofill code: 482910'),
    );
    expect(autofillFinder, findsOneWidget);

    // OTP Header & Encrypted text
    expect(find.text('Enter verification code'), findsOneWidget);
    expect(find.text('Encrypted OTP'), findsOneWidget);

    // Error Alert Banner
    expect(find.text('Incorrect verification code'), findsOneWidget);
    expect(find.text('Please check the SMS code received and try again.'), findsOneWidget);

    // Resend & Call buttons
    expect(find.text("Didn't receive the code?"), findsOneWidget);
    expect(find.text('Resend SMS'), findsOneWidget);
    expect(find.text('Call me with code'), findsOneWidget);

    // Primary Action
    expect(find.text('Verify & Continue'), findsOneWidget);
    expect(find.text('Preview Verified Confirmation Screen →'), findsOneWidget);

    // Clinical Safeguard Card & Footer
    expect(find.text('Two-Step Clinical Safeguard'), findsOneWidget);
    expect(find.text('Having trouble? '), findsOneWidget);
    expect(find.text('Contact Care ID Support'), findsOneWidget);

    // Tap Autofill code
    await tester.tap(autofillFinder);
    await tester.pump();
  });

  testWidgets('HealthInfoPage renders all 7 clinical sections, unit toggles, and CTAs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HealthInfoPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Step Indicator & Heading
    expect(find.text('VERIFICATION STEP'), findsOneWidget);
    expect(find.text('Step 3 of 6'), findsOneWidget);
    expect(find.text('Tell us about your health'), findsOneWidget);

    // Section 1: Basic Health Information
    expect(find.text('Basic Health Information'), findsOneWidget);
    expect(find.text('Blood Group'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('Unknown / Not sure'), findsOneWidget);
    expect(find.text('Height'), findsOneWidget);
    expect(find.text('Weight'), findsOneWidget);

    // Section 2: Medical History
    expect(find.text('Medical History'), findsOneWidget);
    expect(find.text('High Blood Pressure'), findsWidgets); // Can appear in both sections
    expect(find.text('Diabetes'), findsWidgets);

    // Section 3: Allergies
    expect(find.text('Allergies'), findsOneWidget);
    expect(find.text('1 Recorded'), findsOneWidget);
    expect(find.text('Penicillin (Mild rash)'), findsOneWidget);
    expect(find.text('Add another allergy'), findsOneWidget);

    // Section 4: Current Medications
    expect(find.text('Current Medications'), findsOneWidget);
    expect(find.text('Atorvastatin 20mg'), findsOneWidget);
    expect(find.text("I don't currently take any medication"), findsOneWidget);

    // Section 5: Previous Surgeries
    expect(find.text('Previous Surgeries or Major Procedures'), findsOneWidget);
    expect(find.text('Add Procedure'), findsOneWidget);
    expect(find.text('I have no previous surgeries or major procedures'), findsOneWidget);

    // Section 6: Family Health History
    expect(find.text('Family Health History'), findsOneWidget);

    // Section 7: Documents Notice
    expect(find.text('Already have health documents?'), findsOneWidget);

    // Actions & Reassurance
    expect(find.text('Save & Continue'), findsOneWidget);
    expect(find.text('Skip for now'), findsOneWidget);
    expect(find.text('Your health information is encrypted and securely stored in your Care ID Vault.'), findsOneWidget);
  });

  testWidgets('AddInsurancePage renders camera scan card, form fields, and navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AddInsurancePage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Step Indicator & Heading
    expect(find.text('VERIFICATION STEP'), findsOneWidget);
    expect(find.text('Step 4 of 6'), findsOneWidget);
    expect(find.text('Add your insurance'), findsOneWidget);

    // Scan Insurance Card Hero Card
    expect(find.text('Scan Insurance Card'), findsOneWidget);
    expect(find.text('Quickly capture your card details'), findsOneWidget);
    expect(find.text('Open Camera'), findsOneWidget);

    // Manual Insurance Details Form Card
    expect(find.text('Insurance Details'), findsOneWidget);
    expect(find.text('Insurance Provider'), findsOneWidget);
    expect(find.text('Member ID'), findsOneWidget);
    expect(find.text('Group Number (Optional)'), findsOneWidget);

    // Action CTAs & Vault Note
    expect(find.text('Save & Continue'), findsOneWidget);
    expect(find.text("I'll do this later"), findsOneWidget);
    expect(
      find.text('Your insurance data is encrypted and stored in your private Care ID Vault.'),
      findsOneWidget,
    );

    // Tap Open Camera simulator and verify auto-fill
    await tester.tap(find.text('Open Camera'));
    await tester.pump();
    expect(find.text('Blue Cross Blue Shield'), findsOneWidget);
    expect(find.text('BCBS-98421049'), findsOneWidget);
    expect(find.text('GRP-00482'), findsOneWidget);
  });

  testWidgets('PrivacyConsentsPage renders all 6 sections, validates mandatory checkboxes, and reflects consent summary', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PrivacyConsentsPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Step Indicator & Heading
    expect(find.text('STEP 5 OF 6'), findsOneWidget);
    expect(find.text('Privacy & Consents'), findsOneWidget);
    expect(
      find.text('Review and customize how your health information is protected and managed in your private Care ID Vault.'),
      findsOneWidget,
    );

    // Section 1: Required for Your Care ID
    expect(find.text('Required for Your Care ID'), findsOneWidget);
    expect(find.text('MANDATORY'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);

    // Section 2: Health Information
    expect(find.text('Health Information'), findsOneWidget);
    expect(find.text('End-to-End Encrypted'), findsOneWidget);
    expect(find.text('Zero-Knowledge Storage'), findsOneWidget);

    // Section 3: Healthcare Sharing Permission
    expect(find.text('Healthcare Sharing Permission'), findsOneWidget);
    expect(find.text('Explicit Clinical Authorization'), findsOneWidget);

    // Section 4: Communication Preferences
    expect(find.text('Communication Preferences'), findsOneWidget);
    expect(find.text('Service & Product Updates'), findsOneWidget);
    expect(find.text('Appointment & Clinical Reminders'), findsOneWidget);
    expect(find.text('Account Security Alerts'), findsOneWidget);
    expect(find.text('REQUIRED'), findsOneWidget);

    // Section 5: Data Control Information
    expect(find.text("You're always in control"), findsOneWidget);

    // Section 6: Consent Summary Card
    expect(find.text('Consent Summary'), findsOneWidget);
    expect(find.text('ACTIVE SESSION'), findsOneWidget);
    // Initially, Terms and Privacy are Pending
    expect(find.text('Pending'), findsNWidgets(2));

    // Verify Checkboxes can be toggled
    // Find checkboxes for Terms & Privacy
    final checkBoxes = find.byType(Checkbox);
    expect(checkBoxes, findsNWidgets(4)); // Terms, Privacy, Service Updates, Reminders

    // Tap Terms checkbox
    await tester.tap(checkBoxes.at(0));
    await tester.pump();

    // Now only 1 Pending (Privacy is still pending)
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('Accepted'), findsOneWidget);

    // Tap Privacy checkbox
    await tester.tap(checkBoxes.at(1));
    await tester.pump();

    // Both are now Accepted
    expect(find.text('Accepted'), findsNWidgets(2));
    expect(find.text('Pending'), findsNothing);

    // Actions & Security footnote
    expect(find.text('Accept & Continue'), findsOneWidget);
    expect(find.text('Review later'), findsOneWidget);
    expect(
      find.text('Bank-grade 256-bit AES encryption • HIPAA compliant architecture'),
      findsOneWidget,
    );
  });

  testWidgets('ConfirmedScreenPage renders profile credential, disciplines, completion meter, and CTAs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ConfirmedScreenPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Stepper Card: Step 6 of 6
    expect(find.text('Step 6 of 6'), findsOneWidget);
    expect(find.text('Setup Finished'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text('Mobile'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Consents'), findsOneWidget);
    expect(find.text('Vault'), findsOneWidget);

    // Hero Status Header
    expect(find.text('Onboarding Complete • Vault Activated'), findsOneWidget);
    expect(find.text('Your Care ID Vault is ready'), findsOneWidget);

    // Section 1: Digital Credential Card
    expect(find.text('CARE ID CREDENTIAL'), findsOneWidget);
    expect(find.text('Secure Vault ID'), findsOneWidget);
    expect(find.text('Sarah Jenkins'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('#CI-920512'), findsOneWidget);
    expect(find.text('Date of Birth'), findsOneWidget);
    expect(find.text('12/05/1992'), findsOneWidget);
    expect(find.text('Blood Group'), findsOneWidget);
    expect(find.text('O Positive (O+)'), findsOneWidget);
    expect(find.text('Mobile Contact'), findsOneWidget);
    expect(find.text('+91 ••••• ••890'), findsOneWidget);
    expect(find.text('Registered Email'), findsOneWidget);
    expect(find.text('sarah.j@email.com'), findsOneWidget);
    expect(find.text('Edit Profile Details'), findsOneWidget);

    // Tap #CI-920512 to test copy feedback
    await tester.tap(find.text('#CI-920512'));
    await tester.pump();
    expect(find.text('Copied'), findsOneWidget);

    // Section 2: Vault Disciplines
    expect(find.text('Your Care ID Vault'), findsOneWidget);
    expect(find.text('Medical Records'), findsOneWidget);
    expect(find.text('Dental Records'), findsOneWidget);
    expect(find.text('Vision Records'), findsOneWidget);
    expect(find.text('Pet Records'), findsOneWidget);
    expect(find.text('Insurance Records'), findsOneWidget);
    expect(find.text('Pet ready'), findsOneWidget);
    expect(find.text('AI OCR ready'), findsOneWidget);

    // Section 3: Health Profile Completion Meter
    expect(find.text('Health Profile Status'), findsOneWidget);
    expect(find.text('90% Configured'), findsOneWidget);
    expect(find.text('Personal details'), findsOneWidget);
    expect(find.text('Health history'), findsOneWidget);
    expect(find.text('Known allergies'), findsOneWidget);
    expect(find.text('Medications list'), findsOneWidget);
    expect(find.text('Health sharing consents'), findsOneWidget);
    expect(find.text('Complete 100%'), findsOneWidget);

    // Section 4: Privacy & Ownership Control
    expect(find.text('Your information, your control'), findsOneWidget);
    expect(find.text('Manage Privacy & Consents'), findsOneWidget);

    // Section 5: Security Trust Badge
    expect(find.text('Care ID Vault Protection'), findsOneWidget);

    // Primary Call-to-Actions
    expect(find.text('Enter Care ID'), findsOneWidget);
    expect(find.text('Complete Later'), findsOneWidget);
  });

  testWidgets('BiometricSetupPage renders hero composition, typography, and actions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BiometricSetupPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Verify Hero Illustration Asset
    final heroFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/biometric_shield_hero.png',
    );
    expect(heroFinder, findsOneWidget);

    // Verify Button Fingerprint Icon Asset
    final fpIconFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/figma_button_fingerprint.png',
    );
    expect(fpIconFinder, findsOneWidget);

    // Verify Security Shield Icon Asset
    final shieldIconFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/figma_security_shield.png',
    );
    expect(shieldIconFinder, findsOneWidget);

    // Verify Value Proposition
    expect(find.text('Secure Your CareID Vault'), findsOneWidget);
    expect(
      find.text('Enable Biometrics for instant, secure\naccess to your health records.'),
      findsOneWidget,
    );

    // Verify Action Buttons
    expect(find.text('Enable Biometrics'), findsOneWidget);
    expect(find.text('Maybe Later'), findsOneWidget);
    expect(find.text('Skip for Now'), findsOneWidget);

    // Verify Security Badge
    expect(find.text('MILITARY-GRADE ENCRYPTION'), findsOneWidget);

    // Tap "Enable Biometrics" to test dialog interaction
    await tester.tap(find.text('Enable Biometrics'));
    await tester.pumpAndSettle();

    expect(find.text('Biometrics Activated'), findsOneWidget);
    expect(find.text('Enter Care ID Vault'), findsOneWidget);

    // Tap Enter Care ID Vault in dialog
    await tester.tap(find.text('Enter Care ID Vault'));
    await tester.pumpAndSettle();
  });

  testWidgets('LoginPage renders header, inputs, buttons, security badge, and handles interactions', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Verify Typography
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(
      find.text('Secure access to your medical\necosystem.'),
      findsOneWidget,
    );

    // Verify Form Fields
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('(555) 000-0000'), findsOneWidget);
    expect(find.text('Need help?'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);
    expect(find.text('OR'), findsOneWidget);
    expect(find.text('Login with Biometrics'), findsOneWidget);

    // Verify Sign Up footer
    expect(find.textContaining("Don't have a vault?"), findsOneWidget);
    expect(find.textContaining('Create Account'), findsOneWidget);

    // Verify AES-256 Security Card
    expect(
      find.text('Your health information is protected using AES-256 encryption.'),
      findsOneWidget,
    );

    // Verify Security Badge & Links
    expect(find.text('END-TO-END ENCRYPTED STORAGE'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Compliance'), findsOneWidget);

    // Enter a valid phone number
    await tester.enterText(find.byType(TextField), '5551234567');
    await tester.pump();
    expect(find.text('5551234567'), findsOneWidget);

    // Tap Login with Biometrics
    await tester.tap(find.text('Login with Biometrics'));
    await tester.pumpAndSettle();

    expect(find.text('Biometrics Recognized'), findsOneWidget);
    expect(find.text('Continue to Vault'), findsOneWidget);

    // Tap Continue to Vault in dialog
    await tester.tap(find.text('Continue to Vault'));
    await tester.pumpAndSettle();
  });

  testWidgets('OtpVerificationPage renders cells, timer, cards, error state, and success overlay', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OtpVerificationPage(phoneNumber: '+1 555-123-4567'),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Verify Heading & Subtitle
    expect(find.text('Verify Account'), findsOneWidget);
    expect(find.textContaining('+1 555-123-4567'), findsOneWidget);

    // Verify 4 OTP input fields
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(4));

    // Verify Timer and Verify CTA
    expect(find.textContaining('Resend in 00:'), findsOneWidget);
    expect(find.text('Verify'), findsOneWidget);

    // Verify Contextual Cards
    expect(find.text('Secure Vault'), findsOneWidget);
    expect(find.text('Your data is encrypted with AES-256 standard.'), findsOneWidget);
    expect(find.text('Need Help?'), findsOneWidget);
    expect(find.text('Contact our 24/7 clinical support team.'), findsOneWidget);

    // Tap Need Help? Card to open Clinical Support modal
    await tester.tap(find.text('Need Help?'));
    await tester.pumpAndSettle();
    expect(find.text('Clinical Support Team'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // Trigger Connection Error State by entering '0000'
    for (int i = 0; i < 4; i++) {
      await tester.enterText(textFields.at(i), '0');
    }
    await tester.pump();
    await tester.tap(find.text('Verify'));
    await tester.pump();
    expect(find.text('Connection error. Please try again.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    // Enter valid code '1234' and verify
    await tester.enterText(textFields.at(0), '1');
    await tester.enterText(textFields.at(1), '2');
    await tester.enterText(textFields.at(2), '3');
    await tester.enterText(textFields.at(3), '4');
    await tester.pump();

    await tester.tap(find.text('Verify'));
    await tester.pump();

    // Verify Success Overlay appears
    expect(find.text('Identity Verified'), findsOneWidget);
    expect(find.text('Redirecting to your Health Vault...'), findsOneWidget);
  });

  testWidgets('AccountRecoveryPage renders centered logo, form, error validation, and AES indicator', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AccountRecoveryPage(),
      ),
    );

    // Verify Centered Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);
    final logoCenter = tester.getCenter(logoFinder);
    expect(logoCenter.dx, equals(400.0));

    // Verify Titles
    expect(find.text('Recover Mobile\nAccess'), findsOneWidget);
    expect(find.text('Enter your registered mobile number.'), findsOneWidget);

    // Verify Input Fields
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('(555) 000-0000'), findsOneWidget);
    expect(find.text('Send Recovery Code'), findsOneWidget);
    expect(find.text('Back to Login'), findsOneWidget);

    // Verify Footer Compliance
    expect(find.text('PROTECTED BY AES-256 ENCRYPTION'), findsOneWidget);

    // Tap Send Recovery Code when empty -> shows SnackBar
    await tester.tap(find.text('Send Recovery Code'));
    await tester.pump();
    expect(find.text('Please enter a valid 10-digit mobile number'), findsOneWidget);

    // Enter 10 digits
    await tester.enterText(find.byType(TextField), '5559876543');
    await tester.pump();
    expect(find.text('5559876543'), findsOneWidget);
  });

  testWidgets('HomePage renders top bar, hero health card, bento grids, upcoming activity, and bottom nav', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Top App Bar Logo
    final logoFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName ==
              'assets/images/care_id_logo_wordmark.png',
    );
    expect(logoFinder, findsOneWidget);

    // Hero Digital Health Card details
    expect(find.text('DIGITAL HEALTH ID'), findsOneWidget);
    expect(find.text('Richard\nMalouf'), findsOneWidget);
    expect(find.text('Member since 2021'), findsOneWidget);
    expect(find.text('ICE Active'), findsOneWidget);
    expect(find.text('DOB'), findsOneWidget);
    expect(find.text('15 May 1985'), findsOneWidget);
    expect(find.text('BLOOD GROUP'), findsOneWidget);
    expect(find.text('O Positive'), findsOneWidget);
    expect(find.text('Add to Wallet'), findsOneWidget);

    // Provider invitation link
    expect(find.text('Provider not registered?'), findsOneWidget);
    expect(find.text('Click here to invite your provider to CareID'), findsOneWidget);

    // Health Records 2x2 Bento Grid
    expect(find.text('Health Records'), findsOneWidget);
    expect(find.text('Medical'), findsOneWidget);
    expect(find.text('Lab result & scans'), findsOneWidget);
    expect(find.text('Dental'), findsOneWidget);
    expect(find.text('Checkup & X-rays'), findsOneWidget);
    expect(find.text('Vision'), findsOneWidget);
    expect(find.text('Eye Checkups'), findsOneWidget);
    expect(find.text('Pets'), findsOneWidget);
    expect(find.text('Pet Checkups'), findsOneWidget);

    // Quick Actions 2x2 Grid
    expect(find.text('Quick Actions'), findsOneWidget);
    expect(find.text('Insurance Card'), findsOneWidget);
    expect(find.text('Add Family Member'), findsOneWidget);
    expect(find.text('Book Appointment'), findsOneWidget);
    expect(find.text('PRIMARY'), findsOneWidget);
    expect(find.text('Emergency'), findsOneWidget);
    expect(find.text('SOS'), findsOneWidget);

    // Upcoming Section
    expect(find.text('Upcoming'), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
    expect(find.text('Dental Appointment'), findsOneWidget);
    expect(find.text('City Hospital · 9:00 AM'), findsOneWidget);
    expect(find.text('Prescription Collection'), findsOneWidget);
    expect(find.text('Dr. Smith · 11:30 AM'), findsOneWidget);

    // Bottom Navigation Bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Records'), findsOneWidget);
    expect(find.text('Doctor'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Tap Records tab in bottom nav
    await tester.tap(find.text('Records'));
    await tester.pump();
  });

  testWidgets('SmartDigitalHealthCardPage renders card, credentials, wallet buttons, and actions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SmartDigitalHealthCardPage(),
      ),
    );

    // Verify Patient Name & ID
    expect(find.text('Richard'), findsOneWidget);
    expect(find.text('CI-882-0911'), findsOneWidget);
    expect(find.text('DIGITAL HEALTH SIGNATURE'), findsOneWidget);
    expect(find.text('ENCRYPTED CAREID'), findsOneWidget);

    // Verify Wallet Action Buttons
    expect(find.text('Add to Apple Wallet'), findsOneWidget);
    expect(find.text('Add to Google Wallet'), findsOneWidget);

    // Verify Patient Credentials Bento Card
    expect(find.text('Patient Credentials'), findsOneWidget);
    expect(find.text('CareID VERIFIED'), findsOneWidget);
    expect(find.text('DATE OF BIRTH'), findsOneWidget);
    expect(find.text('12 May 1992'), findsOneWidget);
    expect(find.text('BLOOD GROUP'), findsOneWidget);
    expect(find.text('O Positive (O+)'), findsOneWidget);
    expect(find.text('INSURANCE STATUS'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('EMERGENCY CONTACT'), findsOneWidget);
    expect(find.text('John Doe (+1 555-0123)'), findsOneWidget);
    expect(find.text('KNOWN ALLERGIES'), findsOneWidget);
    expect(find.text('Penicillin, Peanuts, Latex'), findsOneWidget);

    // Verify Last Updated & Refresh QR
    expect(find.textContaining('Last Updated:'), findsOneWidget);
    expect(find.text('Refresh QR'), findsOneWidget);

    // Verify Secondary Actions
    expect(find.text('Download PDF'), findsOneWidget);
    expect(find.text('Share QR Code'), findsOneWidget);
    expect(find.text('Encrypted Access'), findsOneWidget);

    // Verify Persistent Bottom Navigation Bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Records'), findsOneWidget);
    expect(find.text('Doctor'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Interact with Refresh QR
    await tester.tap(find.text('Refresh QR'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    // Interact with Wallet buttons
    await tester.tap(find.text('Add to Apple Wallet'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Add to Google Wallet'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  });

  testWidgets('QrDashboardPage renders card, refreshed layout, bento grid, and bottom nav',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: QrDashboardPage(),
      ),
    );

    // Verify Header
    expect(find.text('QR Sharing'), findsOneWidget);

    // Verify Main QR Card
    expect(find.text('Active & Encrypted'), findsOneWidget);
    expect(find.text('Eliza V. Reed'), findsOneWidget);
    expect(find.text('CID-9928'), findsOneWidget);
    expect(find.textContaining('Last Updated:'), findsOneWidget);

    // Verify 2x2 Bento Quick Action Grid
    expect(find.text('Generate New'), findsOneWidget);
    expect(find.text('Share QR'), findsOneWidget);
    expect(find.text('Download PDF'), findsOneWidget);
    expect(find.text('Access History'), findsOneWidget);

    // Verify Informational Banner
    expect(find.text('Data Privacy Guard'), findsOneWidget);
    expect(
      find.text('Your QR code expires automatically every 24 hours to ensure your health data stays secure.'),
      findsOneWidget,
    );

    // Verify Unified Bottom Navigation Bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Records'), findsOneWidget);
    expect(find.text('Doctor'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Tap Bento Quick Actions
    await tester.tap(find.text('Generate New'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    await tester.tap(find.text('Share QR'));
    await tester.pump();

    await tester.tap(find.text('Download PDF'));
    await tester.pump();

    await tester.tap(find.text('Access History'));
    await tester.pump();

    // Verify Bottom Nav Bar QR FAB toggles Scan/Share QR bubbles
    final fabFinder = find.byType(AnimatedContainer);
    if (fabFinder.evaluate().isNotEmpty) {
      await tester.tap(fabFinder.first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Scan OCR'), findsOneWidget);
      expect(find.text('Share QR'), findsWidgets); // Bento tile + bubble
    }
  });
}









