import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:care_id_patient_app/main.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/create_account_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/splash_page.dart';
import 'package:care_id_patient_app/features/auth/presentation/pages/welcome_page.dart';

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
}
