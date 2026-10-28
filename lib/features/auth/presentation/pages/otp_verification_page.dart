import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 11: OTP Verification - Refined States (Figma node 20:25032)
///
/// 4-Digit OTP verification screen for returning user login and account recovery.
/// Includes dynamic timer countdown, active resend action, 4 separate input cells,
/// encrypted vault & clinical support cards, plus full interactive Success Overlay
/// ("Identity Verified") and Network Error Snackbar states.
class OtpVerificationPage extends StatefulWidget {
  final String? phoneNumber;

  const OtpVerificationPage({
    super.key,
    this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // 4-Digit OTP Controllers & FocusNodes
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // Timer & Resend State
  int _secondsRemaining = 58;
  Timer? _timer;

  // Refined State Flags
  bool _showSuccessOverlay = false;
  bool _showErrorSnackbar = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 58);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        t.cancel();
      }
    });
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _onVerify() {
    final code = _otpCode;
    if (code == '0000') {
      // Simulate network error banner state from Figma
      setState(() => _showErrorSnackbar = true);
      return;
    }

    if (code.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter the full 4-digit code',
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Success State from Figma: "Identity Verified"
    setState(() {
      _showErrorSnackbar = false;
      _showSuccessOverlay = true;
    });

    // Auto-redirect to Home Vault after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      }
    });
  }

  void _onResendCode() {
    if (_secondsRemaining > 0) return;
    _startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A new 4-digit verification code was sent to your mobile.',
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF00696B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSupportTapped() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Clinical Support Team',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF0B1C30)),
        ),
        content: Text(
          'Our clinical concierge and account security team is available 24/7 at +1 (800) 555-CARE or support@careid.health.',
          style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF494552), height: 1.5),
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
            // Main Content Canvas
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Branding Header with Centered CareID Logo
                    _buildTopHeader(),

                    const SizedBox(height: 16),

                    // Network Error Snackbar (if triggered)
                    if (_showErrorSnackbar) ...[
                      _buildNetworkErrorSnackbar(),
                      const SizedBox(height: 16),
                    ],

                    // Branding Hero Section (Blue Circular Icon, Verify Account, Subtitle)
                    _buildHeroSection(),

                    const SizedBox(height: 28),

                    // Main OTP Verification Card (Frosted Glass Container)
                    _buildOtpCard(),

                    const SizedBox(height: 24),

                    // Contextual Information Cards (Secure Vault & Clinical Support)
                    _buildContextualCards(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Success Message Overlay ("Identity Verified")
            if (_showSuccessOverlay) _buildSuccessOverlay(),
          ],
        ),
      ),
    );
  }

  /// Top Branding Header with Dead-Centered CareID Logo
  Widget _buildTopHeader() {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left back arrow to return to login
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF4FF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 14,
                    color: Color(0xFF005AB3),
                  ),
                ),
              ),
            ),
          ),

          // Centered CareID Logo
          Center(
            child: Image.asset(
              'assets/images/care_id_logo_wordmark.png',
              height: 18,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  /// Branding Hero Section (Blue Circular Shield Icon, Headline, Subtitle)
  Widget _buildHeroSection() {
    return Column(
      children: [
        // 64x64 Blue Circular Icon
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xFF0073E0),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/otp_hero_security_lock.svg',
              width: 22,
              height: 27,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Headline: "Verify Account"
        Text(
          'Verify Account',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF181C23),
            height: 1.3,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.phoneNumber != null
                ? 'Enter the 4-digit code sent to\n${widget.phoneNumber}.'
                : 'Enter the 4-digit code sent to your\nmobile.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF414754),
              letterSpacing: 0.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  /// Main OTP Verification Card (Frosted Glass Container with 4 Input Cells & Verify CTA)
  Widget _buildOtpCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              // 4 Individual OTP Input Cells
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) => _buildOtpCell(index)),
              ),

              const SizedBox(height: 28),

              // Timer & Resend Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/otp_timer_clock.svg',
                    width: 15,
                    height: 15,
                    colorFilter: const ColorFilter.mode(Color(0xFF414754), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  if (_secondsRemaining > 0)
                    Text(
                      'Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF414754),
                        letterSpacing: 0.1,
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _onResendCode,
                      child: Text(
                        'Resend Code',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4648D4),
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 28),

              // Primary "Verify" CTA Button
              GestureDetector(
                onTap: _onVerify,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 310),
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
                        'Verify',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        'assets/icons/arrow_verify_otp.svg',
                        width: 16,
                        height: 14,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Individual OTP Digit Cell (64x80, rounded 20)
  Widget _buildOtpCell(int index) {
    final bool isFocused = _focusNodes[index].hasFocus;
    return Container(
      width: 64,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFocused ? const Color(0xFF4648D4) : const Color(0xFFC0C6D6),
          width: isFocused ? 1.5 : 1.0,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF181C23),
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (val) {
            if (val.isNotEmpty) {
              if (index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else {
                _focusNodes[index].unfocus();
              }
            } else {
              if (index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  /// Contextual Information Cards (Secure Vault & 24/7 Clinical Support)
  Widget _buildContextualCards() {
    return Column(
      children: [
        // 1. Secure Vault Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3FE),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFC0C6D6).withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/otp_vault_lock.svg',
                width: 16,
                height: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Secure Vault',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF181C23),
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Your data is encrypted with AES-256 standard.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF414754),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 2. Need Help? Card
        GestureDetector(
          onTap: _onSupportTapped,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3FE),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC0C6D6).withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/otp_support_headset.svg',
                  width: 20,
                  height: 18,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF181C23),
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Contact our 24/7 clinical support team.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF414754),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Network Error Alert Banner from Figma (Rose Pink Container with Retry CTA)
  Widget _buildNetworkErrorSnackbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDAD6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBA1A1A).withValues(alpha: 0.2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/otp_network_error_alert.svg',
            width: 18,
            height: 17,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Connection error. Please try again.',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF93000A),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() => _showErrorSnackbar = false);
              _onVerify();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF93000A),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF9F9FF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Success Message Overlay from Figma (Identity Verified + Mint Check Badge + Auto Redirect)
  Widget _buildSuccessOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          color: const Color(0xFFF9F9FF).withValues(alpha: 0.95),
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 128x128 Mint Check Badge
                Container(
                  width: 128,
                  height: 128,
                  decoration: const BoxDecoration(
                    color: Color(0xFF68FADD),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 25,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/otp_success_check.svg',
                      width: 53,
                      height: 53,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF007261),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // "Identity Verified"
                Text(
                  'Identity Verified',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF181C23),
                  ),
                ),

                const SizedBox(height: 12),

                // "Redirecting to your Health Vault..."
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                  ).createShader(bounds),
                  child: Text(
                    'Redirecting to your Health Vault...',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
