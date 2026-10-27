import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/app_routes.dart';

/// Page 3: Create Account Screen
/// Figma Frame: `CareID-Create Account` (node-id `20:30644`)
/// Dimensions: 390 x 911
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Navigate to next onboarding step (Mobile Number / Verification)
    Navigator.of(context).pushNamed(AppRoutes.mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Navigation row (Back button)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        color: Color(0xFF0F172A),
                        size: 22,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Care ID Brand Logo
                Center(
                  child: Image.asset(
                    'assets/images/care_id_logo_small.png',
                    width: 108,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 12),

                // Heading 1: "Create your Care ID"
                Text(
                  'Create your Care ID',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 32 / 24,
                    letterSpacing: -0.6,
                    color: const Color(0xFF0F172A),
                  ),
                ),

                const SizedBox(height: 6),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Create your secure account to access and manage your\nhealth information in one place.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 19.5 / 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 1. Full Name Input
                _buildFieldLabel('Full Name'),
                const SizedBox(height: 4),
                _buildTextInput(
                  controller: _fullNameController,
                  hintText: 'Enter your full name',
                  iconPath: 'assets/icons/input_user.svg',
                ),

                const SizedBox(height: 14),

                // 2. Mobile Number Input
                _buildFieldLabel('Mobile Number'),
                const SizedBox(height: 4),
                _buildMobileInput(
                  controller: _mobileController,
                  hintText: 'Enter your mobile number',
                  iconPath: 'assets/icons/input_phone.svg',
                ),

                const SizedBox(height: 14),

                // 3. Email Address Input
                _buildFieldLabel('Email Address'),
                const SizedBox(height: 4),
                _buildTextInput(
                  controller: _emailController,
                  hintText: 'Enter your email address',
                  iconPath: 'assets/icons/input_mail.svg',
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 14),

                // 4. Password Input
                _buildFieldLabel('Password'),
                const SizedBox(height: 4),
                _buildPasswordInput(
                  controller: _passwordController,
                  hintText: 'Create a password',
                  iconPath: 'assets/icons/input_lock.svg',
                  obscureText: _obscurePassword,
                  onToggleObscure: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),

                const SizedBox(height: 6),

                // Password Strength Indicator
                _buildPasswordStrengthBar(),

                const SizedBox(height: 14),

                // 5. Confirm Password Input
                _buildFieldLabel('Confirm Password'),
                const SizedBox(height: 4),
                _buildPasswordInput(
                  controller: _confirmPasswordController,
                  hintText: 'Re-enter your password',
                  iconPath: 'assets/icons/input_refresh_lock.svg',
                  obscureText: _obscureConfirmPassword,
                  onToggleObscure: () {
                    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                  },
                ),

                const SizedBox(height: 16),

                // Terms & Privacy Checkbox
                _buildTermsAgreementRow(),

                const SizedBox(height: 20),

                // Submit Button CTA: "Create Account ->"
                _buildSubmitButton(),

                const SizedBox(height: 16),

                // Sign In Link
                _buildSignInLink(),

                const SizedBox(height: 28),

                // Footer Trust Notice
                _buildFooterTrustNotice(),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
          color: const Color(0xFF0F172A),
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF94A3B8),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileInput({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF94A3B8),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '+1',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 1,
            height: 20,
            color: const Color(0xFFE2E8F0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInput({
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    required bool obscureText,
    required VoidCallback onToggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF94A3B8),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A3B8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggleObscure,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                'assets/icons/eye_off.svg',
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  obscureText ? const Color(0xFF94A3B8) : const Color(0xFF5B14B8),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.75,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Strong security standard',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 16.5 / 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAgreementRow() {
    return GestureDetector(
      onTap: () {
        setState(() => _agreedToTerms = !_agreedToTerms);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: _agreedToTerms ? const Color(0xFF3F1D8B) : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _agreedToTerms ? const Color(0xFF3F1D8B) : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
            ),
            child: _agreedToTerms
                ? const Icon(
                    Icons.check,
                    size: 13,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 19.5 / 12,
                  color: const Color(0xFF64748B),
                ),
                children: [
                  const TextSpan(text: 'I agree to the Care ID '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3F1D8B),
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3F1D8B),
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: _submit,
      child: Container(
        height: 48,
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
              color: Color(0x333F1D8B),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Account',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 12,
              height: 12,
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

  Widget _buildSignInLink() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.login);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have a Care ID account? ',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
          ),
          Text(
            'Sign In',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F1D8B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterTrustNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xB3E2E8F0),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/shield_check.svg',
            width: 13,
            height: 13,
            colorFilter: const ColorFilter.mode(
              Color(0xFF64748B),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              'Your information is protected with secure account controls.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF64748B),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
