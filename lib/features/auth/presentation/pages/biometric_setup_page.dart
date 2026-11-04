import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 9: Biometric Setup - Refined Polish (Figma node 20:25097)
///
/// Onboarding Security & Quick Authentication Setup
/// Allows the user to configure biometric authentication (Face ID / Fingerprint)
/// to safeguard their private Care ID Vault, or skip to proceed directly to Home.
class BiometricSetupPage extends StatefulWidget {
  const BiometricSetupPage({super.key});

  @override
  State<BiometricSetupPage> createState() => _BiometricSetupPageState();
}

class _BiometricSetupPageState extends State<BiometricSetupPage> {
  bool _isAuthenticating = false;

  void _onEnableBiometrics() {
    setState(() => _isAuthenticating = true);

    // Simulate device biometric authentication dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF4FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/avatar_verified_pin.svg',
                  width: 24,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF00696B),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Biometrics Activated',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your biometric credentials are now securely linked to your Care ID Vault.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  setState(() => _isAuthenticating = false);
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B14B8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Enter Care ID Vault',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMaybeLater() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _onSkipForNow() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 6),

                // Top Branding Header with Centered CareID Logo
                _buildTopBrandingHeader(),

                const SizedBox(height: 28),

                // Hero Illustration Composition: Concentric Rings & Frosted Shield Card
                _buildHeroIllustrationSection(),

                const SizedBox(height: 24),

                // Value Proposition Typography
                _buildTextContentSection(),

                const SizedBox(height: 28),

                // Action Options (Enable Biometrics, Maybe Later, Skip for Now)
                _buildActionSection(),

                const SizedBox(height: 28),

                // Security Badge (Military-Grade Encryption with Shield Icon)
                _buildSecurityBadge(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top Branding Header with Dead-Centered CareID Logo
  Widget _buildTopBrandingHeader() {
    return SizedBox(
      width: double.infinity,
      height: 24,
      child: Center(
        child: Image.asset(
          'assets/images/card_id_badge.png',
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Hero Asset: Refined Concentric Rings, Satellites & Centered Biometric Shield
  Widget _buildHeroIllustrationSection() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Perfectly bounded within mobile screen dimensions without cutting off
          final double maxAllowedWidth = constraints.maxWidth > 300 ? 300 : constraints.maxWidth;
          final double computedHeight = maxAllowedWidth * (280.0 / 320.0);

          return SizedBox(
            width: maxAllowedWidth,
            height: computedHeight,
            child: Image.asset(
              'assets/images/biometric_shield_hero.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }

  /// Value Proposition Typography
  Widget _buildTextContentSection() {
    return Column(
      children: [
        Text(
          'Secure Your CareID Vault',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF181C23),
            letterSpacing: -0.7,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enable Biometrics for instant, secure\naccess to your health records.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF414754),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Action Buttons Section
  Widget _buildActionSection() {
    return Column(
      children: [
        // Primary Action: Enable Biometrics
        GestureDetector(
          onTap: _isAuthenticating ? null : _onEnableBiometrics,
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x335B14B8),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/figma_button_fingerprint.svg',
                  width: 18,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Text(
                  'Enable Biometrics',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Secondary Action: Maybe Later
        GestureDetector(
          onTap: _onMaybeLater,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC0C6D6)),
            ),
            child: Center(
              child: Text(
                'Maybe Later',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF005AB3),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Tertiary Action: Skip for Now
        GestureDetector(
          onTap: _onSkipForNow,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Skip for Now',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF414754).withOpacity(0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Security Reassurance Badge Footer (Shield Icon)
  Widget _buildSecurityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3FE),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: const Color(0xFFC0C6D6).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/figma_security_shield.svg',
            width: 12,
            height: 15,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Text(
            'MILITARY-GRADE ENCRYPTION',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF414754),
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

