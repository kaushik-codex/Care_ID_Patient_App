import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 10: Login - Refined Auth Flow v2 (Figma node 20:24965)
///
/// Returning user sign-in screen allowing authentication via mobile number
/// (receiving a 4-digit verification OTP) or quick biometric login, backed by
/// AES-256 encryption & end-to-end encrypted storage safeguards.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Top Header State
  String _selectedLanguage = 'EN';

  // Form State
  final TextEditingController _mobileController = TextEditingController();
  bool _hasError = false;
  String _selectedCountryCode = '+1';

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _onSendOtp() {
    final text = _mobileController.text.trim().replaceAll(RegExp(r'\D'), '');
    if (text.length < 10) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 10-digit mobile number',
            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _hasError = false);
    Navigator.of(context).pushNamed(
      AppRoutes.loginOtp,
      arguments: '$_selectedCountryCode ${_mobileController.text.trim()}',
    );
  }

  void _onBiometricLogin() {
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
                color: Color(0xFFE8FBF7),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/bio_login_fingerprint.svg',
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF007261),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Biometrics Recognized',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Identity verified. Entering your secure Care ID Vault...',
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
                  'Continue to Vault',
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

  void _onNeedHelp() {
    Navigator.of(context).pushNamed(AppRoutes.accountRecovery);
  }

  void _onCreateAccount() {
    Navigator.of(context).pushNamed(AppRoutes.createAccount);
  }

  void _showPolicyModal(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF0B1C30)),
        ),
        content: SingleChildScrollView(
          child: Text(
            content,
            style: GoogleFonts.plusJakartaSans(fontSize: 13, color: const Color(0xFF494552), height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF5B14B8)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      body: SafeArea(
        child: Stack(
          children: [
            // Ambient Decorative Glow Surfaces
            _buildAmbientBackground(),

            // Foreground Content
            Column(
              children: [
                // Top Header with Dead-Centered CareID Logo & Language Switch
                _buildTopHeader(),

                // Scrollable Form Canvas
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),

                          // Main Login Canvas (Frosted Card)
                          _buildMainLoginCard(),

                          const SizedBox(height: 20),

                          // Security AES-256 Info Card
                          _buildSecurityInfoCard(),

                          const SizedBox(height: 20),

                          // Security Badge & Compliance Links
                          _buildSecurityBadgeAndCompliance(),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Ambient Lighting & Decorative Glow Surfaces (Figma Radial Gradients & 60px Blur Bloom)
  Widget _buildAmbientBackground() {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          size: Size.infinite,
          painter: _AmbientGlowPainter(),
        ),
      ),
    );
  }

  /// Top Branding Header with Dead-Centered CareID Logo & Language Switch
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
            // Dead-Centered Logo
            Center(
              child: Image.asset(
                'assets/images/care_id_logo_wordmark.png',
                height: 18,
                fit: BoxFit.contain,
              ),
            ),

            // Right-aligned Language Pill
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3FE),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFC0C6D6)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLanguageButton('EN'),
                    _buildLanguageButton('ESP'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String lang) {
    final bool isSelected = _selectedLanguage == lang;
    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = lang),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B14B8) : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          lang,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF414754),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  /// Main Login Canvas (Frosted Glass Card)
  Widget _buildMainLoginCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.70),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF3F1D8B).withOpacity(0.1)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header: "Welcome Back" & Subtitle
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5B14B8),
                  letterSpacing: -0.8,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Secure access to your medical\necosystem.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF414754),
                  letterSpacing: 0.5,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // Form: Mobile Number Input Group
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mobile Number',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF414754),
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input Box
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _hasError ? const Color(0xFFBA1A1A) : const Color(0xFFC0C6D6),
                        width: _hasError ? 1.5 : 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Country Code Prefix (+1)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedCountryCode,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF181C23),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/icons/dropdown_chevron_country.svg',
                              width: 6,
                              height: 3,
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Text Field
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
                              letterSpacing: 0.5,
                            ),
                            decoration: InputDecoration(
                              hintText: '(555) 000-0000',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF717786),
                                letterSpacing: 0.5,
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

                        // Right Mobile Phone Icon
                        SvgPicture.asset(
                          'assets/icons/login_mobile_input.svg',
                          width: 15,
                          height: 22,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // "Need help?" Link (Right-aligned)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _onNeedHelp,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Need help?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3F1D8B),
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // "Send OTP" Button
                  GestureDetector(
                    onTap: _onSendOtp,
                    child: Container(
                      height: 56,
                      width: double.infinity,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send OTP',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.8,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            'assets/icons/arrow_send_otp.svg',
                            width: 17,
                            height: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // "OR" Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFFC0C6D6),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF717786),
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFFC0C6D6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // "Login with Biometrics" Button
              GestureDetector(
                onTap: _onBiometricLogin,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF68FADD),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bio_login_fingerprint.svg',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Login with Biometrics',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF007261),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Footer: "Don't have a vault? Create Account"
              GestureDetector(
                onTap: _onCreateAccount,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have a vault? ",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF414754),
                        letterSpacing: 0.25,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create Account',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF3F1D8B),
                            letterSpacing: 0.25,
                          ),
                        ),
                      ],
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

  /// Security Info Card (AES-256 Encryption)
  Widget _buildSecurityInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/aes_lock_card.svg',
            width: 16,
            height: 21,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your health information is protected using AES-256 encryption.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF414754),
                letterSpacing: 0.25,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Security Reassurance Badge & Compliance Links Footer
  Widget _buildSecurityBadgeAndCompliance() {
    return Column(
      children: [
        // End-to-End Encrypted Storage Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/e2e_storage_lock.svg',
              width: 16,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'END-TO-END ENCRYPTED STORAGE',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF414754),
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Compliance Links Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _showPolicyModal(
                'Privacy Policy',
                'Care ID protects patient health information according to strict zero-knowledge cryptographic vault standards.',
              ),
              child: Text(
                'Privacy Policy',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF717786),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => _showPolicyModal(
                'Terms of Service',
                'By using Care ID, you retain complete and immutable ownership of your personal health credentials.',
              ),
              child: Text(
                'Terms of Service',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF717786),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => _showPolicyModal(
                'Compliance',
                'Care ID is fully compliant with HIPAA technical safeguards, ISO 27001, and SOC-2 Type II standards.',
              ),
              child: Text(
                'Compliance',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF717786),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// CustomPainter rendering the exact ambient lighting gradients & 60px diffuse bloom
/// from Figma node 20:24965 (Top-left lavender glow, top-right cyan glow, bottom-left 60px blur purple bloom).
class _AmbientGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Base clean background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF9F9FF),
    );

    // 2. Top-Left Lavender Radial Glow (Figma: rgba(236,230,255,1) at center (0,0))
    final topLeftPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.topLeft,
        radius: 1.1,
        colors: [
          const Color(0xFFECE6FF),
          const Color(0xFFECE6FF).withOpacity(0.65),
          const Color(0xFFECE6FF).withOpacity(0.20),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.70, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width * 1.3, size.height * 0.55));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), topLeftPaint);

    // 3. Top-Right Cyan Radial Glow (Figma: rgba(230,255,255,1) at center (390,0))
    final topRightPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.topRight,
        radius: 1.1,
        colors: [
          const Color(0xFFCCFFFF),
          const Color(0xFFE6FFFF).withOpacity(0.70),
          const Color(0xFFE6FFFF).withOpacity(0.25),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.70, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), topRightPaint);

    // 4. Bottom-Left Purple Ambient Glow Bloom (Figma node 20:24966: 384x384, blur 60px, rgba(63,29,139,0.1))
    // We render this as a wide, lush diffuse radial light bloom with 0 hard circular edges.
    final bottomLeftPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-1.1, 1.1),
        radius: 1.1,
        colors: [
          const Color(0xFF3F1D8B).withOpacity(0.22),
          const Color(0xFF3F1D8B).withOpacity(0.14),
          const Color(0xFF3F1D8B).withOpacity(0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.70, 1.0],
      ).createShader(Rect.fromLTWH(-120, size.height - 420, 500, 500));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bottomLeftPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


