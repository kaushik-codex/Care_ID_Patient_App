import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 6: Add Insurance Info (Figma node 20:33068)
///
/// Onboarding Step 4 of 6: Insurance & Coverage
/// Allows the patient to either scan their physical insurance card via camera
/// or manually enter their Insurance Provider, Member ID, and Group Number.
class AddInsurancePage extends StatefulWidget {
  const AddInsurancePage({super.key});

  @override
  State<AddInsurancePage> createState() => _AddInsurancePageState();
}

class _AddInsurancePageState extends State<AddInsurancePage> {
  // Top Header State
  String _selectedLanguage = 'EN';

  // Form Controllers
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _groupNumberController = TextEditingController();

  @override
  void dispose() {
    _providerController.dispose();
    _memberIdController.dispose();
    _groupNumberController.dispose();
    super.dispose();
  }

  void _onSaveAndContinue() {
    Navigator.of(context).pushNamed(AppRoutes.privacyConsents);
  }

  void _onSkipLater() {
    Navigator.of(context).pushNamed(AppRoutes.privacyConsents);
  }

  void _openCameraSimulator() {
    // Simulated instant OCR card scan
    setState(() {
      _providerController.text = 'Blue Cross Blue Shield';
      _memberIdController.text = 'BCBS-98421049';
      _groupNumberController.text = 'GRP-00482';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Card captured: Blue Cross Blue Shield details auto-filled',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF00696B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header with White Background (Figma frame 20:33069)
            _buildTopHeader(),

            // 2. Scrollable Body Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Progress Indicator ("VERIFICATION STEP" + "Step 4 of 6")
                    _buildStepProgressIndicator(),

                    const SizedBox(height: 20),

                    // Heading & Subtitle
                    _buildHeaderSection(),

                    const SizedBox(height: 24),

                    // Card 1: Scan Insurance Card Hero Card
                    _buildScanCardHero(),

                    const SizedBox(height: 20),

                    // Card 2: Manual Insurance Details Form Card
                    _buildInsuranceDetailsForm(),

                    const SizedBox(height: 28),

                    // Action Buttons & Vault Reassurance
                    _buildActionsSection(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HEADER (White background, dead-centered logo, right-aligned pill)
  // ===========================================================================
  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Dead Center: CareID Logo (CareIDlogo 1, node 20:33070)
            Center(
              child: Image.asset(
                'assets/images/card_id_badge.png',
                height: 24,
                fit: BoxFit.contain,
              ),
            ),

            // Right Aligned: Language Selector Pill (node 20:33071)
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
      ),
    );
  }

  // ===========================================================================
  // 2. STEP PROGRESS INDICATOR (Figma frame 20:33080)
  // ===========================================================================
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
                color: const Color(0xFF00696B),
                letterSpacing: 0.6,
              ),
            ),
            Text(
              'Step 4 of 6',
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
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.666, // Step 4 of 6 = ~66.6%
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF28006D),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. HEADER SECTION (Figma frame 20:33089)
  // ===========================================================================
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add your insurance',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
            letterSpacing: -0.7,
            height: 1.28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Adding your insurance now helps speed up your first visit. You can also skip this and add it later.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 1.625,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. SCAN INSURANCE CARD HERO CARD (Figma frame 20:33095)
  // ===========================================================================
  Widget _buildScanCardHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE9FF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Badge with Camera SVG
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF4FF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/camera_scan.svg',
              width: 24,
              height: 24,
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            'Scan Insurance Card',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
              letterSpacing: -0.0176,
            ),
          ),

          const SizedBox(height: 4),

          // Subtitle
          Text(
            'Quickly capture your card details',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF767676),
            ),
          ),

          const SizedBox(height: 16),

          // Action Button: "Open Camera"
          GestureDetector(
            onTap: _openCameraSimulator,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                'Open Camera',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3F1D8B),
                  letterSpacing: -0.0938,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. MANUAL INSURANCE DETAILS FORM CARD (Figma frame 20:33107)
  // ===========================================================================
  Widget _buildInsuranceDetailsForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/insurance_details.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Insurance Details',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                  letterSpacing: -0.0625,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Field 1: Insurance Provider
          _buildFormField(
            label: 'Insurance Provider',
            controller: _providerController,
            hintText: 'Enter provider name',
          ),

          const SizedBox(height: 16),

          // Field 2: Member ID
          _buildFormField(
            label: 'Member ID',
            controller: _memberIdController,
            hintText: 'Enter member ID',
          ),

          const SizedBox(height: 16),

          // Field 3: Group Number (Optional)
          _buildFormField(
            label: 'Group Number (Optional)',
            controller: _groupNumberController,
            hintText: 'Enter group number',
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0B1C30),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF767676),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. ACTIONS & NAVIGATION SECTION (Figma frame 20:33136)
  // ===========================================================================
  Widget _buildActionsSection() {
    return Column(
      children: [
        // Primary CTA Button: "Save & Continue →"
        GestureDetector(
          onTap: _onSaveAndContinue,
          child: Container(
            width: double.infinity,
            height: 52,
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
                  color: Color(0x1A000000),
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save & Continue',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.0156,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/arrow_right_ins.svg',
                  width: 13,
                  height: 13,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Secondary Action CTA: "I'll do this later"
        GestureDetector(
          onTap: _onSkipLater,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              "I'll do this later",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF494552),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Vault Security Trust Note
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/lock_vault_ins.svg',
                width: 9,
                height: 14,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Your insurance data is encrypted and stored in your private Care ID Vault.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
