import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CareIDPatientApp());
}

class CareIDPatientApp extends StatelessWidget {
  const CareIDPatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareID Patient',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
