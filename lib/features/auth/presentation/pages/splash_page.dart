import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

/// Page 1: Splash Screen
/// Figma Frame: `Splash_Screen` (node-id `20:25191`)
/// Dimensions: 390 x 884
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: 2500), _navigateToWelcome);
  }

  void _navigateToWelcome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scale = screenSize.width / 390.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _navigateToWelcome,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xCCFFFFFF),
            border: Border.all(
              color: AppColors.primary,
              width: 5.0,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Doctor Image with 25% opacity
              Opacity(
                opacity: 0.25,
                child: Image.asset(
                  'assets/images/splash_bg.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, -0.2),
                ),
              ),

              // CareID Brand Graphic Lockup & Domain Pill Badges
              // Figma position: width 427, height 284, top 453 on 884h frame (~51.2% top offset)
              Positioned(
                top: (453.0 / 884.0) * screenSize.height,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 427.0 * scale.clamp(0.85, 1.15),
                    height: 284.0 * scale.clamp(0.85, 1.15),
                    child: Image.asset(
                      'assets/images/care_id_splash_emblem.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
