import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';

/// Page 2: Welcome Screen
/// Figma Frame: `Welcome - Option 2` (node-id `20:19794`)
/// Dimensions: 390 x 1072
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Language toggle selection state ('EN' or 'ESP')
  String _selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Right: Language Toggle Segmented Control
              Align(
                alignment: Alignment.topRight,
                child: _buildLanguageToggle(),
              ),

              const SizedBox(height: 12),

              // Hero Logo
              Center(
                child: Image.asset(
                  'assets/images/care_id_logo_welcome.png',
                  width: 200,
                  height: 113,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 8),

              // Hero Heading: "Your Health \n All In One Place"
              Text(
                'Your Health\nAll In One Place',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 48 / 36,
                  letterSpacing: -0.8,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Securely store and share your\nverifiable health records anywhere\nyou go.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 4 Core Domain Cards (Medical, Dental, Vision, Pets)
              _buildFeatureCard(
                title: 'Medical',
                subtitle: 'Access history, labs, and vitals.',
                iconPath: 'assets/icons/medical_stethoscope.svg',
                iconBgColor: const Color(0x1A3F1D8B),
                innerBgColor: const Color(0xFFE5EEFF),
                iconSize: 20,
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                title: 'Dental',
                subtitle: 'Oral health history & imaging.',
                iconPath: 'assets/icons/dental_tooth.svg',
                iconBgColor: const Color(0x4D75F2FE),
                iconSize: 20,
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                title: 'Vision',
                subtitle: 'Prescriptions and eye exams.',
                iconPath: 'assets/icons/vision_eye.svg',
                iconBgColor: const Color(0x1A3F1D8B),
                iconSize: 22,
              ),

              const SizedBox(height: 16),

              _buildFeatureCard(
                title: 'Pets',
                subtitle: 'Prescriptions and eye exams.',
                iconPath: 'assets/icons/pets_paw.svg',
                iconBgColor: const Color(0x1A3F1D8B),
                iconSize: 24,
              ),

              const SizedBox(height: 36),

              // Primary Action: "Get Started ->"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.createAccount);
                },
                child: Container(
                  height: 60,
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
                        color: Color(0x335B14B8),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
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
              ),

              const SizedBox(height: 16),

              // Secondary Action: "I already have an account"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.login);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(
                      color: const Color(0x4D006971),
                      width: 2.0,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'I already have an account',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Language selector pill: EN / ESP
  Widget _buildLanguageToggle() {
    return Container(
      height: 32,
      width: 96,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3FE),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: const Color(0xFFC0C6D6),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // EN
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedLanguage = 'EN');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'EN'
                      ? AppColors.primary
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
                    letterSpacing: 0.5,
                    color: _selectedLanguage == 'EN'
                        ? Colors.white
                        : const Color(0xFF414754),
                  ),
                ),
              ),
            ),
          ),
          // ESP
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedLanguage = 'ESP');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: _selectedLanguage == 'ESP'
                      ? AppColors.primary
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
                    letterSpacing: 0.5,
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
    );
  }

  /// Feature pillar card matching Figma frame 20:19812 / 20:19823 / 20:19834 / 20:19853
  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required String iconPath,
    required Color iconBgColor,
    Color? innerBgColor,
    required double iconSize,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: const Color(0x1ACBC4D4),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A28006D),
            blurRadius: 16,
            offset: Offset(0, 4),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Icon badge
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: innerBgColor != null
                ? Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: innerBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      iconPath,
                      width: iconSize,
                      height: iconSize,
                    ),
                  )
                : SvgPicture.asset(
                    iconPath,
                    width: iconSize,
                    height: iconSize,
                  ),
          ),

          const SizedBox(width: 16),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 32 / 24,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
