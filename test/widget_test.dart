import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:care_id_patient_app/main.dart';
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
}
