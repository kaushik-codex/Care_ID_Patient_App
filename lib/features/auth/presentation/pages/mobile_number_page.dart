import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/app_routes.dart';

/// Page 4: Mobile Number Verification Screen
/// Figma Frame: `Mobile_number` (node-id `20:30756`)
/// Dimensions: 390 x 1207
class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({super.key});

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  // Language toggle selection ('EN' or 'ESP')
  String _selectedLanguage = 'EN';

  // 6-digit OTP code state (pre-filled with 4 digits matching Figma screen mock: '4', '8', '2', '9', '', '')
  final List<String> _otpDigits = ['4', '8', '2', '9', '', ''];
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (i) => TextEditingController(text: i < 4 ? ['4', '8', '2', '9'][i] : ''),
  );

  int _focusedIndex = 3; // Figma shows the 4th cell focused with underline

  // Error alert banner visibility (Figma shows it visible)
  bool _showErrorBanner = true;

  // Countdown timer simulation (00:45)
  int _secondsRemaining = 45;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _autofillCode() {
    const code = '482910';
    setState(() {
      for (int i = 0; i < 6; i++) {
        _otpDigits[i] = code[i];
        _controllers[i].text = code[i];
      }
      _focusedIndex = 5;
      _showErrorBanner = false;
    });
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      setState(() {
        _otpDigits[index] = value.characters.last;
        _controllers[index].text = value.characters.last;
      });
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
        setState(() => _focusedIndex = index + 1);
      }
    } else {
      setState(() {
        _otpDigits[index] = '';
        _controllers[index].text = '';
      });
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        setState(() => _focusedIndex = index - 1);
      }
    }
  }

  void _verifyAndContinue() {
    // Navigate to next onboarding step (Health Info Intake: Step 3 of 6)
    Navigator.of(context).pushNamed(AppRoutes.healthInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top App Bar Header
              _buildTopHeader(),

              const SizedBox(height: 16),

              // 2. Step Progress Indicator ("VERIFICATION STEP" + "Step 2 of 6")
              _buildStepProgressIndicator(),

              const SizedBox(height: 20),

              // 3. Title & Context Area
              _buildTitleAndContext(),

              const SizedBox(height: 20),

              // 4. Masked Recipient Phone Badge with Action ("Change")
              _buildMaskedPhoneBadge(),

              const SizedBox(height: 16),

              // 5. Autofill Chip Suggestion ("Autofill code: 482910")
              _buildAutofillChip(),

              const SizedBox(height: 16),

              // 6. 6-Digit OTP Code Input Cells
              _buildOtpInputSection(),

              const SizedBox(height: 16),

              // 7. Interactive Error Alert Banner
              if (_showErrorBanner) ...[
                _buildErrorAlertBanner(),
                const SizedBox(height: 20),
              ],

              // 8. Timer & Resend Controls Card
              _buildTimerAndResendCard(),

              const SizedBox(height: 24),

              // 9. Primary Action Button ("Verify & Continue")
              _buildPrimaryActionButton(),

              const SizedBox(height: 16),

              // Secondary link: "Preview Verified Confirmation Screen →"
              Center(
                child: GestureDetector(
                  onTap: _verifyAndContinue,
                  child: Text(
                    'Preview Verified Confirmation Screen →',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 10. Trust & Security Reassurance Card ("Two-Step Clinical Safeguard")
              _buildClinicalSafeguardCard(),

              const SizedBox(height: 20),

              // 11. Support Footer Action
              _buildSupportFooter(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Top App Bar Header matching Figma frame 20:30890 (Dead-centered logo)
  Widget _buildTopHeader() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Back Button (Left aligned)
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCE9FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/back_arrow_blue.svg',
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ),

          // Dead Center: CareID Logo (CareIDlogo 1, node 20:30894)
          Center(
            child: Image.asset(
              'assets/images/care_id_logo_wordmark.png',
              width: 79,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),

          // Language Selector Pill (Right aligned)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 32,
              width: 92,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FE),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: const Color(0xFFC0C6D6), width: 1),
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
                  Expanded(
                    child: GestureDetector(
                    onTap: () => setState(() => _selectedLanguage = 'EN'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: _selectedLanguage == 'EN'
                            ? const Color(0xFF5B14B8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'EN',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: _selectedLanguage == 'EN'
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _selectedLanguage == 'EN'
                              ? Colors.white
                              : const Color(0xFF414754),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedLanguage = 'ESP'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: _selectedLanguage == 'ESP'
                            ? const Color(0xFF5B14B8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'ESP',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: _selectedLanguage == 'ESP'
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _selectedLanguage == 'ESP'
                              ? Colors.white
                              : const Color(0xFF414754),
                        ),
                      ),
                    ),
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

  /// Step Progress Indicator matching Figma frame 20:30760
  Widget _buildStepProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VERIFICATION STEP',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                color: const Color(0xFF00696B),
              ),
            ),
            Text(
              'Step 2 of 6',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFDCE9FF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 2.0 / 6.0, // 33.3% progress (Step 2 of 6)
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF28006D),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Title & Context Area matching Figma frame 20:30769
  Widget _buildTitleAndContext() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your mobile number',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 35 / 28,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a 6-digit verification code to your\nregistered mobile number.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 22 / 16,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }

  /// Masked Recipient Phone Badge matching Figma frame 20:30776
  Widget _buildMaskedPhoneBadge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/phone_recipient.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipient Number',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '+91 ••••• ••890',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x80E8DDFF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/edit_pencil.svg',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Change',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF28006D),
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

  /// Autofill Chip Suggestion matching Figma frame 20:30792
  Widget _buildAutofillChip() {
    return Center(
      child: GestureDetector(
        onTap: _autofillCode,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(9999),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/sparkle.svg',
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF28006D),
                  ),
                  children: [
                    const TextSpan(text: 'Autofill code: '),
                    TextSpan(
                      text: '482910',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 6-Digit OTP Code Input Cells matching Figma frame 20:30798
  Widget _buildOtpInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Enter verification code',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/lock_encrypted.svg',
                  width: 10,
                  height: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Encrypted OTP',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF00696B),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            final isFilled = _otpDigits[index].isNotEmpty;
            final isFocused = _focusedIndex == index;

            return Expanded(
              child: Container(
                height: 56,
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : 4,
                  right: index == 5 ? 0 : 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isFocused
                        ? const Color(0xFF28006D)
                        : (isFilled ? const Color(0xFF28006D) : Colors.transparent),
                    width: 2.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: isFilled ? null : '•',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFCBC4D4),
                        ),
                      ),
                      onChanged: (val) => _onDigitChanged(index, val),
                      onTap: () => setState(() => _focusedIndex = index),
                    ),
                    if (isFocused && isFilled)
                      Positioned(
                        bottom: 8,
                        child: Container(
                          width: 16,
                          height: 2,
                          color: const Color(0xFF28006D),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Interactive Error Alert Banner matching Figma frame 20:30832
  Widget _buildErrorAlertBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDAD6),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/alert_circle.svg',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Incorrect verification code',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF93000A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Please check the SMS code received and try again.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 18 / 12,
                    color: const Color(0xFF93000A),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() => _showErrorBanner = false);
            },
            child: SvgPicture.asset(
              'assets/icons/close_x.svg',
              width: 12,
              height: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Timer & Resend Controls Card matching Figma frame 20:30844
  Widget _buildTimerAndResendCard() {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Didn't receive the code?",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF494552),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/clock_timer.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Resend code in $minutes:$seconds',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _secondsRemaining = 45;
                      _showErrorBanner = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/resend_sms.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Resend SMS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _secondsRemaining = 45;
                      _showErrorBanner = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/phone_call.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Call me with code',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Primary Action Button ("Verify & Continue") matching Figma frame 20:30866
  Widget _buildPrimaryActionButton() {
    return GestureDetector(
      onTap: _verifyAndContinue,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA44CFF),
              Color(0xFF5B14B8),
            ],
          ),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify & Continue',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Trust & Security Reassurance Card matching Figma frame 20:30875
  Widget _buildClinicalSafeguardCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0x4D56F5F8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/shield_safeguard.svg',
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Two-Step Clinical Safeguard',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your verified mobile number protects patient health privacy and authorizes critical medical data sharing with your care team.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 19.5 / 12,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Support Footer Action matching Figma frame 20:30886
  Widget _buildSupportFooter() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Having trouble? ',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          Text(
            'Contact Care ID Support',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF28006D),
            ),
          ),
        ],
      ),
    );
  }
}
