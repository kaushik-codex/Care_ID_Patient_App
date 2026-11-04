import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 8: Confirmed_Screen (Figma node 20:31401)
///
/// Onboarding Step 6 of 6: Setup Finished & Vault Activated
/// Displays digital Care ID profile credential, category disciplines preview,
/// health profile completion meter, privacy controls, and vault entry CTA.
class ConfirmedScreenPage extends StatefulWidget {
  const ConfirmedScreenPage({super.key});

  @override
  State<ConfirmedScreenPage> createState() => _ConfirmedScreenPageState();
}

class _ConfirmedScreenPageState extends State<ConfirmedScreenPage> {
  // Top Header State
  String _selectedLanguage = 'EN';
  bool _copiedCareId = false;

  void _copyCareId() {
    Clipboard.setData(const ClipboardData(text: 'CI-920512'));
    setState(() => _copiedCareId = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Care ID #CI-920512 copied to clipboard',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF00696B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _copiedCareId = false);
      }
    });
  }

  void _onEnterCareId() {
    Navigator.of(context).pushNamed(AppRoutes.biometricSetup);
  }

  void _onCompleteLater() {
    Navigator.of(context).pushNamed(AppRoutes.biometricSetup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // Top Branding Header with Dead-Center CareID Logo
            _buildTopBrandingHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Top Navigation & Context Bar (Back & Help)
                      _buildTopNavigationContextBar(),

                      const SizedBox(height: 16),

                      // Stepper Card (Step 6 of 6: Setup Finished)
                      _buildStepperCard(),

                      const SizedBox(height: 24),

                      // Hero Status Header
                      _buildHeroStatusHeader(),

                      const SizedBox(height: 24),

                      // Section 1: Care ID Profile Digital Credential Card
                      _buildDigitalCredentialCard(),

                      const SizedBox(height: 24),

                      // Section 2: Care ID Vault Disciplines (Interactive Preview)
                      _buildVaultDisciplinesSection(),

                      const SizedBox(height: 24),

                      // Section 3: Health Profile Completion Meter
                      _buildHealthProfileMeterCard(),

                      const SizedBox(height: 24),

                      // Section 4: Privacy & Ownership Control Callout
                      _buildPrivacyOwnershipCallout(),

                      const SizedBox(height: 16),

                      // Section 5: Security Trust Badge
                      _buildSecurityTrustBadge(),

                      const SizedBox(height: 24),

                      // Primary Call-to-Actions
                      _buildPrimaryCallToActions(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Top Branding Header with Dead-Centered CareID Logo & Language Pill
  Widget _buildTopBrandingHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  /// Top Navigation Context Bar (Back Button + Help & Support Button)
  Widget _buildTopNavigationContextBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Circular Back Button
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF4FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/nav_back_circle.svg',
                  width: 14,
                  height: 14,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Circular Help & Support Button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Care ID Vault Support: support@careid.health',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: const Color(0xFF28006D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF4FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/help_support_circle.svg',
                  width: 17,
                  height: 17,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Stepper Card: Step 6 of 6 — Setup Finished
  Widget _buildStepperCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A28006D),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Row: Step 6 of 6 on left, Setup Finished on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step 6 of 6',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF28006D),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/check_setup_finished.svg',
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Setup Finished',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 5-Item Stepper Indicators
            Row(
              children: [
                Expanded(child: _buildStepperBar('Account', isCompleted: true)),
                const SizedBox(width: 6),
                Expanded(child: _buildStepperBar('Mobile', isCompleted: true)),
                const SizedBox(width: 6),
                Expanded(child: _buildStepperBar('History', isCompleted: true)),
                const SizedBox(width: 6),
                Expanded(child: _buildStepperBar('Consents', isCompleted: true)),
                const SizedBox(width: 6),
                Expanded(child: _buildStepperBar('Vault', isCompleted: true, isActiveVault: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperBar(String label, {required bool isCompleted, bool isActiveVault = false}) {
    return Column(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: isActiveVault
                ? const Color(0xFF28006D)
                : (isCompleted ? const Color(0xFF00696B) : const Color(0xFFEFF4FF)),
            borderRadius: BorderRadius.circular(9999),
            gradient: isActiveVault
                ? const LinearGradient(
                    colors: [Color(0xFF28006D), Color(0xFF56F5F8)],
                  )
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: isActiveVault ? FontWeight.w700 : FontWeight.w500,
            color: isActiveVault ? const Color(0xFF28006D) : const Color(0xFF00696B),
          ),
        ),
      ],
    );
  }

  /// Hero Status Header
  Widget _buildHeroStatusHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          children: [
            // Status Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF00696B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00696B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Onboarding Complete • Vault Activated',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696B),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Gradient Headline: "Your Care ID Vault is ready"
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                'Your Care ID Vault is ready',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.7,
                  height: 1.25,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Your secure health space is ready. You can now add, organize and manage your health information in one place.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF494552),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 1: Care ID Profile Digital Credential Card
  Widget _buildDigitalCredentialCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1428006D),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Brand Watermark Background Silhouette (Bottom Right)
            Positioned(
              right: -30,
              bottom: -30,
              child: Opacity(
                opacity: 0.8,
                child: SvgPicture.asset(
                  'assets/icons/brand_watermark_card.svg',
                  width: 140,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Card Foreground Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Card Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Badge: CARE ID CREDENTIAL
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3F1D8B),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/credential_badge_white.svg',
                                width: 11,
                                height: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'CARE ID CREDENTIAL',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF28006D),
                              letterSpacing: 0.65,
                            ),
                          ),
                        ],
                      ),

                      // Holographic Security Badge Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF56F5F8).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/hologram_vault_tag.svg',
                              width: 9,
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Secure Vault ID',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF006E70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Identity Overview: Avatar, Name, Blood Group, Care ID Pill
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Photo with Verified Status Pin
                      Stack(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5EEFF),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/images/user_avatar_sarah.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00696B),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x0D000000),
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/avatar_verified_pin.svg',
                                  width: 9,
                                  height: 7,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 16),

                      // User Details Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sarah Jenkins',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0B1C30),
                                  ),
                                ),
                                // Blood Group Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Text(
                                    'O+',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.28,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // Care ID Monospaced Pill with Copy Action
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _copyCareId,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF4FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '#CI-920512',
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF28006D),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        SvgPicture.asset(
                                          'assets/icons/copy_care_id.svg',
                                          width: 10,
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: _copiedCareId ? 1.0 : 0.0,
                                  child: Text(
                                    'Copied',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF00696B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 2x2 Details Grid
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildGridItem('Date of Birth', '12/05/1992')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGridItem('Blood Group', 'O Positive (O+)')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _buildGridItem('Mobile Contact', '+91 ••••• ••890')),
                            const SizedBox(width: 10),
                            Expanded(child: _buildGridItem('Registered Email', 'sarah.j@email.com')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Edit Profile Details Action Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Profile editing will be unlocked in your account settings.',
                              style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            backgroundColor: const Color(0xFF28006D),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/pencil_edit_profile.svg',
                              width: 12,
                              height: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Edit Profile Details',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF28006D),
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
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Section 2: Care ID Vault Disciplines (Interactive Preview)
  Widget _buildVaultDisciplinesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Care ID Vault',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF28006D),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your unified personal health repository across four core disciplines:',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),

          // 1. Medical Records Card
          _buildDisciplineCard(
            iconAsset: 'assets/icons/discipline_medical.svg',
            iconBgColor: const Color(0xFFFFDAD6).withOpacity(0.6),
            title: 'Medical Records',
            statusText: 'Ready',
            statusDotColor: const Color(0xFF00696B),
            description: 'Clinical records, diagnoses, prescriptions and medical documents.',
          ),

          const SizedBox(height: 10),

          // 2. Dental Records Card
          _buildDisciplineCard(
            iconAsset: 'assets/icons/discipline_dental.svg',
            iconBgColor: const Color(0xFF56F5F8).withOpacity(0.4),
            title: 'Dental Records',
            statusText: 'Ready',
            statusDotColor: const Color(0xFF00696B),
            description: 'Dental visits, hygiene charting, treatments and oral surgery files.',
          ),

          const SizedBox(height: 10),

          // 3. Vision Records Card
          _buildDisciplineCard(
            iconAsset: 'assets/icons/discipline_vision.svg',
            iconBgColor: const Color(0xFFFFDBC9).withOpacity(0.6),
            title: 'Vision Records',
            statusText: 'Ready',
            statusDotColor: const Color(0xFF00696B),
            description: 'Eye examinations, optical prescriptions and vision test diagnostics.',
          ),

          const SizedBox(height: 10),

          // 4. Pet Records Card
          _buildDisciplineCard(
            iconAsset: 'assets/icons/discipline_pet.svg',
            iconBgColor: const Color(0xFFE8DDFF),
            title: 'Pet Records',
            statusText: 'Pet ready',
            hasBadgeIcon: true,
            badgeIconAsset: 'assets/icons/sparkle_badge_tag.svg',
            badgeBgColor: const Color(0xFFE8DDFF).withOpacity(0.4),
            badgeTextColor: const Color(0xFF28006D),
            description: 'Organize vaccinations, vet visits, prescriptions, and lab results.',
          ),

          const SizedBox(height: 10),

          // 5. Insurance Records Card
          _buildDisciplineCard(
            iconAsset: 'assets/icons/discipline_insurance.svg',
            iconBgColor: const Color(0xFFE8DDFF),
            title: 'Insurance Records',
            statusText: 'AI OCR ready',
            hasBadgeIcon: true,
            badgeIconAsset: 'assets/icons/sparkle_badge_tag.svg',
            badgeBgColor: const Color(0xFFE8DDFF).withOpacity(0.4),
            badgeTextColor: const Color(0xFF28006D),
            description: 'Upload, auto-digitize, and organize insurance reports.',
          ),
        ],
      ),
    );
  }

  Widget _buildDisciplineCard({
    required String iconAsset,
    required Color iconBgColor,
    required String title,
    required String statusText,
    Color? statusDotColor,
    bool hasBadgeIcon = false,
    String? badgeIconAsset,
    Color? badgeBgColor,
    Color? badgeTextColor,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0828006D),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconAsset,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),

                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeBgColor ?? const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (statusDotColor != null) ...[
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: statusDotColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                          if (hasBadgeIcon && badgeIconAsset != null) ...[
                            SvgPicture.asset(
                              badgeIconAsset,
                              width: 11,
                              height: 12,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            statusText,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: badgeTextColor ?? const Color(0xFF00696B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section 3: Health Profile Completion Meter
  Widget _buildHealthProfileMeterCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0828006D),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row: Icon + Health Profile Status + 90% Configured
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/activity_meter_icon.svg',
                      width: 17,
                      height: 17,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Health Profile Status',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                Text(
                  '90% Configured',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00696B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 90% Progress Bar
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFDCE9FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.90,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00696B), Color(0xFF2DDBDE)],
                    ),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Completed Items Check Grid (2 columns)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildCheckItem('Personal details')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCheckItem('Health history')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildCheckItem('Known allergies')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildCheckItem('Medications list')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildCheckItem('Health sharing consents')),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Bottom Prompt Row: "Optional health details can be updated anytime." + "Complete 100%"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Optional health details can be updated anytime.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You can add advanced health metrics anytime from your profile.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: const Color(0xFF28006D),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      'Complete 100%',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF28006D),
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

  Widget _buildCheckItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/check_circle_teal.svg',
          width: 14,
          height: 14,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0B1C30),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Section 4: Privacy & Ownership Control Callout
  Widget _buildPrivacyOwnershipCallout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF4FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/shield_user_control.svg',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your information, your control',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'You decide what information you add to your Care ID Vault and when you authorize it to be shared with healthcare providers.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.privacyConsents);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Manage Privacy & Consents',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/icons/chevron_teal_right.svg',
                    width: 5,
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 5: Security Trust Badge
  Widget _buildSecurityTrustBadge() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0828006D),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF28006D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/lock_vault_protection.svg',
                  width: 14,
                  height: 17,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Care ID Vault Protection',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Your health information is securely protected with private account-level controls.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Primary Call-to-Actions
  Widget _buildPrimaryCallToActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // "Enter Care ID" Button with Gradient
          GestureDetector(
            onTap: _onEnterCareId,
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Care ID',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/icons/arrow_enter_vault.svg',
                    width: 14,
                    height: 14,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // "Complete Later" Button
          GestureDetector(
            onTap: _onCompleteLater,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Complete Later',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF494552),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Reassurance Footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'You can update your profile and health information anytime from your Care ID Vault.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

