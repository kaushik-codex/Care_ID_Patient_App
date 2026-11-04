import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 12: Account Recovery (Figma node 20:25143)
///
/// Final screen of Phase 1 (Authentication, Onboarding & Setup).
/// Allows returning users who forgot credentials or need mobile access recovery
/// to enter their registered phone number and receive a recovery OTP code.
/// Features authentic multi-layered ambient glow background from Figma,
/// glassmorphic card with identity badge, phone input, primary action gradient CTA,
/// "Back to Login" navigation, and AES-256 protection footer.
class AccountRecoveryPage extends StatefulWidget {
  const AccountRecoveryPage({super.key});

  @override
  State<AccountRecoveryPage> createState() => _AccountRecoveryPageState();
}

class _AccountRecoveryPageState extends State<AccountRecoveryPage> {
  final TextEditingController _mobileController = TextEditingController();
  final String _selectedCountryCode = '+1';
  bool _hasError = false;

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _onSendRecoveryCode() {
    final rawNumber = _mobileController.text.trim();
    if (rawNumber.length < 10) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 10-digit mobile number',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _hasError = false);
    // Navigate to OTP verification passing the recovery phone number
    Navigator.of(context).pushNamed(
      AppRoutes.loginOtp,
      arguments: '$_selectedCountryCode $rawNumber',
    );
  }

  void _onBackToLogin() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: Stack(
        children: [
          // 1. Exact Ambient Glow Background (Top-left blue bloom, right cyan, bottom-right lavender)
          _buildAmbientBackground(),

          // 2. Foreground Content
          SafeArea(
            child: Column(
              children: [
                // Top Header with Centered CareID Logo
                _buildTopHeader(),

                // Center Scrollable Canvas
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Main Glassmorphism Card
                            _buildRecoveryCard(),

                            const SizedBox(height: 36),

                            // Footer Trust Indicators
                            _buildFooterCompliance(),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Ambient Lighting & Decorative Glow Background
  /// Faithfully recreates Figma node 20:25144 (Container with opacity-30):
  /// - Top-left deep blue bloom (#0073E0, blur 60px, mix-blend-multiply)
  /// - Right cyan bloom (#68FADD, blur 40px, opacity 0.3)
  /// - Bottom-right lavender bloom (#C0C1FF, blur 50px, mix-blend-screen)
  Widget _buildAmbientBackground() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          size: Size.infinite,
          painter: _RecoveryAmbientGlowPainter(),
        ),
      ),
    );
  }

  /// Top Branding Header with Dead-Centered CareID Logo
  Widget _buildTopHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered CareID Logo
            Center(
              child: Image.asset(
                'assets/images/card_id_badge.png',
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Main Glassmorphic Recovery Card (Figma node 20:25151)
  Widget _buildRecoveryCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 448),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top Identity Recovery Circular Badge (48x48)
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0x1A75F2FE),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/recovery_key_icon.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Heading: "Recover Mobile Access"
          Text(
            'Recover Mobile\nAccess',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF181C23),
              height: 1.28,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle: "Enter your registered mobile number."
          Text(
            'Enter your registered mobile number.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF414754),
              letterSpacing: 0.25,
            ),
          ),

          const SizedBox(height: 28),

          // Mobile Number Input Box (with +1 prefix and chevron)
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hasError ? const Color(0xFFBA1A1A) : const Color(0xFFC0C6D6),
                width: _hasError ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // Country Code Prefix Selector
                Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F3FE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      bottomLeft: Radius.circular(11),
                    ),
                    border: Border(
                      right: BorderSide(color: Color(0xFFC0C6D6), width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountryCode,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF181C23),
                          letterSpacing: 0.25,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/icons/dropdown_chevron_country.svg',
                        width: 7.5,
                        height: 3.75,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14),

                // Text Field Input
                Expanded(
                  child: TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF181C23),
                    ),
                    decoration: InputDecoration(
                      hintText: '(555) 000-0000',
                      hintStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFC0C6D6),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (val) {
                      if (_hasError) setState(() => _hasError = false);
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Primary "Send Recovery Code" Button
          GestureDetector(
            onTap: _onSendRecoveryCode,
            child: Container(
              height: 56,
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 320),
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
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Send Recovery Code',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // "Back to Login" Navigation Link
          GestureDetector(
            onTap: _onBackToLogin,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/recovery_back_arrow.svg',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Back to Login',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4648D4),
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Footer Compliance / Trust Indicators (Figma node 20:25183)
  Widget _buildFooterCompliance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/recovery_aes_shield.svg',
          width: 13.33,
          height: 17.5,
          colorFilter: const ColorFilter.mode(
            Color(0xFF717786),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'PROTECTED BY AES-256 ENCRYPTION',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF717786),
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

/// CustomPainter rendering the exact multi-stop ambient lighting gradients
/// from Figma node 20:25143 / 20:25144.
/// Softly washes the canvas with zero hard edges:
/// - Top-left deep blue atmospheric glow (#0073E0)
/// - Right cyan highlight glow (#68FADD)
/// - Bottom-right lavender warm ambient glow (#C0C1FF)
class _RecoveryAmbientGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base clean background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF9F9FF),
    );

    // 2. Top-Left Blue Atmospheric Radial Glow (Figma: #0073E0, blur 60px, mix-blend-multiply at 30%)
    // Creates the serene medical blue wash on the upper left side of the canvas
    final topLeftPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.85, -0.65),
        radius: 1.25,
        colors: [
          const Color(0xFF0073E0).withValues(alpha: 0.22),
          const Color(0xFF0073E0).withValues(alpha: 0.12),
          const Color(0xFF0073E0).withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.38, 0.72, 1.0],
      ).createShader(Rect.fromLTWH(-60, -100, size.width * 1.3, size.height * 0.75));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), topLeftPaint);

    // 3. Right Cyan Subtle Ambient Glow (Figma: #68FADD, blur 40px, opacity 0.3 * 0.3 = ~0.09)
    final rightCyanPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.9, -0.35),
        radius: 0.85,
        colors: [
          const Color(0xFF68FADD).withValues(alpha: 0.09),
          const Color(0xFF68FADD).withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromLTWH(size.width * 0.4, 100, size.width * 0.8, 360));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), rightCyanPaint);

    // 4. Bottom-Right Lavender Ambient Glow (Figma: #C0C1FF, blur 50px, mix-blend-screen at 30%)
    final bottomRightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.95, 0.95),
        radius: 1.05,
        colors: [
          const Color(0xFFC0C1FF).withValues(alpha: 0.20),
          const Color(0xFFC0C1FF).withValues(alpha: 0.10),
          const Color(0xFFC0C1FF).withValues(alpha: 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.42, 0.78, 1.0],
      ).createShader(Rect.fromLTWH(size.width * 0.25, size.height * 0.45, size.width * 0.85, size.height * 0.65));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bottomRightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

