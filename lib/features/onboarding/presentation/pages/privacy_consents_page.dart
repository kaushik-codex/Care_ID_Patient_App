import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 7: Privacy & Consents (Figma node 20:31164)
///
/// Onboarding Step 5 of 6: Legal & Clinical Consents
/// Allows the patient to review and accept Terms of Service, acknowledge
/// Privacy Policy, configure zero-knowledge vault storage & sharing permissions,
/// and customize notification preferences.
class PrivacyConsentsPage extends StatefulWidget {
  const PrivacyConsentsPage({super.key});

  @override
  State<PrivacyConsentsPage> createState() => _PrivacyConsentsPageState();
}

class _PrivacyConsentsPageState extends State<PrivacyConsentsPage> {
  // Top Header State
  String _selectedLanguage = 'EN';

  // Section 1: Mandatory Consents
  bool _termsAgreed = false;
  bool _privacyAcknowledged = false;

  // Section 2 & 3: Toggles
  bool _allowHealthStorage = true; // On by default
  bool _allowSharing = true; // On by default

  // Section 4: Communication Preferences
  bool _serviceNotifications = false;
  bool _appointmentReminders = true;
  // Security alerts is always true and cannot be disabled

  int get _configuredCommunicationsCount {
    int count = 1; // Security alerts is always 1
    if (_serviceNotifications) count++;
    if (_appointmentReminders) count++;
    return count;
  }

  bool get _canProceed => _termsAgreed && _privacyAcknowledged;

  void _onAcceptAndContinue() {
    if (!_canProceed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms of Service and Privacy Policy to continue.',
            style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.of(context).pushNamed(AppRoutes.confirmedScreen);
  }

  void _onReviewLater() {
    // Show polite notice that mandatory terms are required
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Essential legal terms are required before entering your Care ID Vault.',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF00696B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Terms of Service',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF0B1C30)),
        ),
        content: SingleChildScrollView(
          child: Text(
            'Care ID provides a secure, patient-owned cryptographic health passport. By activating your account, you maintain sole ownership of your health records with end-to-end zero-knowledge encryption.',
            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF494552), height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() => _termsAgreed = true);
            },
            child: Text(
              'Accept Terms',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: const Color(0xFF5B14B8)),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF0B1C30)),
        ),
        content: SingleChildScrollView(
          child: Text(
            'Your privacy is our utmost clinical priority. Care ID will never sell or monetize your medical records. Data is accessed strictly under your per-encounter explicit consent.',
            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF494552), height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() => _privacyAcknowledged = true);
            },
            child: Text(
              'Acknowledge Policy',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: const Color(0xFF5B14B8)),
            ),
          ),
        ],
      ),
    );
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
              // 1. Top App Bar Header (Figma frame 20:31394)
              _buildTopHeader(),

              const SizedBox(height: 16),

              // 2. Step Progress Indicator ("VERIFICATION STEP" + "Step 5 of 6")
              _buildStepProgressIndicator(),

              const SizedBox(height: 20),

              // 3. Screen Header: Title & Subtitle
              _buildScreenHeader(),

              const SizedBox(height: 20),

              // 4. Section 1: Required for Your Care ID (Mandatory)
              _buildRequiredConsentsSection(),

              const SizedBox(height: 20),

              // 5. Section 2: Health Information Consent (End-to-End Encrypted)
              _buildHealthInformationSection(),

              const SizedBox(height: 20),

              // 6. Section 3: Healthcare Sharing Permission
              _buildSharingPermissionSection(),

              const SizedBox(height: 20),

              // 7. Section 4: Communication Preferences
              _buildCommunicationPreferencesSection(),

              const SizedBox(height: 20),

              // 8. Section 5: Data Control Information Card ("You're always in control")
              _buildDataControlCard(),

              const SizedBox(height: 20),

              // 9. Section 6: Consent Summary Card
              _buildConsentSummaryCard(),

              const SizedBox(height: 24),

              // 10. Section 7: Primary & Secondary Actions + Footnote
              _buildActionsSection(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HEADER (Dead centered logo & right aligned EN/ESP pill)
  // ===========================================================================
  Widget _buildTopHeader() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dead Center: CareID Logo (CareIDlogo 1, node 20:31395)
          Center(
            child: Image.asset(
              'assets/images/care_id_logo_wordmark.png',
              width: 79,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),

          // Right Aligned: Language Selector Pill (node 20:31396)
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

  // ===========================================================================
  // 2. STEP PROGRESS INDICATOR (Figma frame 20:31167)
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
              'Step 5 of 6',
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
              widthFactor: 0.8324, // Step 5 of 6 = ~83.3%
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
  // 3. SCREEN HEADER (Figma frame 20:31176)
  // ===========================================================================
  Widget _buildScreenHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your privacy & consents',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'You control how your health information is stored, accessed, and shared through Care ID.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. SECTION 1: REQUIRED FOR YOUR CARE ID (Figma frame 20:31182)
  // ===========================================================================
  Widget _buildRequiredConsentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title & Mandatory Pill
        Row(
          children: [
            Text(
              'REQUIRED FOR YOUR CARE ID',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
                letterSpacing: 0.35,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDAD6),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'MANDATORY',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF93000A),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Card 1: Terms of Service
        Container(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms of Service',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Review and accept the terms that apply to your Care ID account and cryptographic health passport.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF494552),
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _showTermsDialog,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Terms',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF00696B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            'assets/icons/external_link_teal.svg',
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => setState(() => _termsAgreed = !_termsAgreed),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _termsAgreed ? const Color(0xFF28006D) : Colors.white,
                        borderRadius: BorderRadius.circular(2.5),
                        border: Border.all(
                          color: _termsAgreed ? const Color(0xFF28006D) : const Color(0xFF767676),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _termsAgreed
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'I agree to the Care ID Terms of Service',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Card 2: Privacy Policy
        Container(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Learn how Care ID collects, stores, and protects your identity credentials and personal data.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF494552),
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _showPrivacyDialog,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Policy',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF00696B),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            'assets/icons/external_link_teal.svg',
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => setState(() => _privacyAcknowledged = !_privacyAcknowledged),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _privacyAcknowledged ? const Color(0xFF28006D) : Colors.white,
                        borderRadius: BorderRadius.circular(2.5),
                        border: Border.all(
                          color: _privacyAcknowledged ? const Color(0xFF28006D) : const Color(0xFF767676),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _privacyAcknowledged
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'I acknowledge the Care ID Privacy Policy',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 5. SECTION 2: HEALTH INFORMATION CONSENT (Figma frame 20:31226)
  // ===========================================================================
  Widget _buildHealthInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HEALTH INFORMATION',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
                letterSpacing: 0.35,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF56F5F8),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/lock_encrypted_badge.svg',
                    width: 9,
                    height: 12,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'End-to-End Encrypted',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF006E70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Prominent Feature Card with soft lavender tint
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EFFF),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/shield_storage_white.svg',
                      width: 15,
                      height: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Secure Health Information Storage',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Care ID Vault Zero-Knowledge Architecture',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Allow Care ID to securely store your clinical records, health metrics, and medical data in your encrypted personal Care ID Vault.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF494552),
                  height: 1.43,
                ),
              ),
              const SizedBox(height: 12),
              // Inner white container with Switch
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Allow secure storage of my health information',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildSwitch(
                      value: _allowHealthStorage,
                      onChanged: (val) => setState(() => _allowHealthStorage = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. SECTION 3: HEALTHCARE SHARING PERMISSION (Figma frame 20:31254)
  // ===========================================================================
  Widget _buildSharingPermissionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SHARING YOUR HEALTH INFORMATION',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
            letterSpacing: 0.35,
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/clinical_auth_blue.svg',
                      width: 17,
                      height: 17,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explicit Clinical Authorization',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'You decide when your health information can be shared with healthcare professionals or other authorized people.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF494552),
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Prominent Callout Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/shield_protected_banner.svg',
                      width: 14,
                      height: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: const Color(0xFF494552),
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: 'Protected Protocol: ',
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0B1C30),
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'You will always be prompted before any data is unlocked. Care ID never shares your data automatically without your explicit per-encounter authorization.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Allow sharing when I authorize it',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildSwitch(
                    value: _allowSharing,
                    onChanged: (val) => setState(() => _allowSharing = val),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 7. SECTION 4: COMMUNICATION PREFERENCES (Figma frame 20:31280)
  // ===========================================================================
  Widget _buildCommunicationPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COMMUNICATION PREFERENCES',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
            letterSpacing: 0.35,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Choose which non-essential updates and reminders you would like to receive.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
              // Item 1: Service notifications
              GestureDetector(
                onTap: () => setState(() => _serviceNotifications = !_serviceNotifications),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: _serviceNotifications ? const Color(0xFF28006D) : Colors.white,
                        borderRadius: BorderRadius.circular(2.5),
                        border: Border.all(
                          color: _serviceNotifications ? const Color(0xFF28006D) : const Color(0xFF767676),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _serviceNotifications
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Care ID service notifications',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                          Text(
                            'Service announcements, app improvements & feature tips',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Item 2: Appointment reminders
              GestureDetector(
                onTap: () => setState(() => _appointmentReminders = !_appointmentReminders),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: _appointmentReminders ? const Color(0xFF28006D) : Colors.white,
                        borderRadius: BorderRadius.circular(2.5),
                        border: Border.all(
                          color: _appointmentReminders ? const Color(0xFF28006D) : const Color(0xFF767676),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _appointmentReminders
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment and healthcare reminders',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                          Text(
                            'Clinical alerts, upcoming visit reminders & prescription status',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Item 3: Important account & security alerts (Fixed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5FE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3E4FE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/lock_security_alerts.svg',
                        width: 11,
                        height: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Important account & security alerts',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF0B1C30),
                                ),
                              ),
                              const SizedBox(width: 6),
                              SvgPicture.asset(
                                'assets/icons/info_circle_blue.svg',
                                width: 13,
                                height: 13,
                              ),
                            ],
                          ),
                          Text(
                            'Required for account security • Cannot be disabled',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 8. SECTION 5: DATA CONTROL INFORMATION CARD (Figma frame 20:31321)
  // ===========================================================================
  Widget _buildDataControlCard() {
    final bullets = [
      'You can review, modify, and revoke authorizations at any time.',
      'Modify optional communication preferences later from account settings.',
      'Manage live provider access anytime from your Care ID Vault dashboard.',
      'Every consent decision is recorded with a tamper-resistant cryptographic audit timestamp.',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/shield_control.svg',
                width: 15,
                height: 18,
              ),
              const SizedBox(width: 8),
              Text(
                "You're always in control",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00696B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        b,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                          height: 1.33,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ===========================================================================
  // 9. SECTION 6: CONSENT SUMMARY CARD (Figma frame 20:31349)
  // ===========================================================================
  Widget _buildConsentSummaryCard() {
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consent Status',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00696B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Active Session',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 2x2 Grid of Status Chips
          Row(
            children: [
              Expanded(
                child: _buildStatusChip(
                  title: 'Terms of Service',
                  status: _termsAgreed ? 'Accepted' : 'Pending',
                  isOk: _termsAgreed,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatusChip(
                  title: 'Privacy Policy',
                  status: _privacyAcknowledged ? 'Accepted' : 'Pending',
                  isOk: _privacyAcknowledged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildStatusChip(
                  title: 'Health Storage',
                  status: _allowHealthStorage ? 'Authorized 🔒' : 'Restricted',
                  isOk: _allowHealthStorage,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatusChip(
                  title: 'Communications',
                  status: 'Configured ($_configuredCommunicationsCount of 3)',
                  isNeutral: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip({
    required String title,
    required String status,
    bool isOk = false,
    bool isNeutral = false,
  }) {
    Color statusColor;
    if (isNeutral) {
      statusColor = const Color(0xFF0B1C30);
    } else if (isOk) {
      statusColor = const Color(0xFF00696B);
    } else {
      statusColor = const Color(0xFFBA1A1A);
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            status,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 10. SECTION 7: PRIMARY & SECONDARY ACTIONS (Figma frame 20:31377)
  // ===========================================================================
  Widget _buildActionsSection() {
    return Column(
      children: [
        // Primary CTA Button: "Accept & Continue →"
        GestureDetector(
          onTap: _onAcceptAndContinue,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              gradient: _canProceed
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                    )
                  : null,
              color: _canProceed ? null : const Color(0x6628006D),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: _canProceed
                  ? const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Accept & Continue',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/arrow_right_continue.svg',
                  width: 12,
                  height: 12,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Secondary Link: "Review later"
        GestureDetector(
          onTap: _onReviewLater,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            child: Text(
              'Review later',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF00696B),
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),

        // Subtitle Copy
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Essential legal terms are required before entering your Care ID Vault.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Security Footnote
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/lock_footnote.svg',
              width: 11,
              height: 14,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Your choices are securely recorded and can be reviewed from your Care ID account settings.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF494552),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Custom Animated Switch matching Figma 48x28 pill
  Widget _buildSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF28006D) : const Color(0xFFC0C6D6),
          borderRadius: BorderRadius.circular(9999),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

