import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Placeholder for Welcome Page (`Welcome - Option 2`, node `20:19794`)
/// Will be fully implemented under Phase 1, Page 2 approval gate.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Page',
                style: AppTypography.titleLarge.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                'Awaiting Phase 1 Page 2 Approval',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
