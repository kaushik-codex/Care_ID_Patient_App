import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:care_id_patient_app/main.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/create_account_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/mobile_number_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/splash_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:care_id_patient_app/features/onboarding/presentation/pages/health_info_page.dart';

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
}

