import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 16: Share Options (Figma node 20:23195)
///
/// Data module selector for secure CareID QR sharing:
/// - Frosted Top App Bar with back navigation, "Choose Sharing Type" title, patient avatar
/// - Header: "What would you like to share?" and instructions
/// - 7 Data Module Selection Cards:
///   1. Entire Health Card
///   2. Medical Records
///   3. Dental Records
///   4. Vision Records
///   5. Insurance Information
///   6. Family Member Access
///   7. Pet Records
/// - Access Duration Segmented Selector: "Temporary (24h)" vs "Permanent"
/// - Primary Action CTA: "Generate Secure QR" with sparkle icon
/// - End-to-end encrypted protocol security footnote
/// - Unified frosted bottom navigation bar
class ShareOptionsPage extends StatefulWidget {
  const ShareOptionsPage({super.key});

  @override
  State<ShareOptionsPage> createState() => _ShareOptionsPageState();
}

enum AccessDuration { temporary24h, permanent }

class _ShareOptionsPageState extends State<ShareOptionsPage> {
  // Selected module keys
  final Set<String> _selectedModules = {'entire_card'};
  AccessDuration _selectedDuration = AccessDuration.temporary24h;

  void _toggleModule(String key) {
    setState(() {
      if (_selectedModules.contains(key)) {
        _selectedModules.remove(key);
      } else {
        _selectedModules.add(key);
      }
    });
  }

  void _onGenerateSecureQr() {
    if (_selectedModules.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select at least one module to share.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Navigate to Page 17 (QR Preview) if registered, otherwise show confirmation feedback
    final durationLabel = _selectedDuration == AccessDuration.temporary24h
        ? 'Temporary (24h)'
        : 'Permanent';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Generating secure QR with ${_selectedModules.length} module(s) ($durationLabel)...',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5B14B8),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Scrollable Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 72, bottom: 120),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Headline Section
                    _buildHeadline(),

                    const SizedBox(height: 32),

                    // Selection Cards Grid/List
                    _buildSelectionList(),

                    const SizedBox(height: 36),

                    // Access Duration Selector Section
                    _buildDurationSelector(),

                    const SizedBox(height: 36),

                    // Primary CTA Button & Security Footnote
                    _buildPrimaryActionSection(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // 2. Fixed Glassmorphic Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Persistent Unified Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: -1),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Back Arrow, Title "Choose Sharing Type", Patient Avatar)
  Widget _buildTopAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FF).withValues(alpha: 0.90),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Group: Back Arrow + "Choose Sharing Type" Title
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/share_back_arrow.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    'Choose Sharing Type',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Right Group: Patient Avatar with #DCE9FF background
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCE9FF),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/patient_avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Headline Section (Figma node 20:23235)
  Widget _buildHeadline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What would you like to\nshare?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF28006D),
            height: 1.28,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select the data modules you wish to include in\nyour secure session.',
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

  /// 7 Selection Cards (Figma node 20:23240)
  Widget _buildSelectionList() {
    return Column(
      children: [
        // 1. Entire Health Card
        _buildModuleCard(
          moduleKey: 'entire_card',
          title: 'Entire Health Card',
          description:
              'A complete summary of your medical profile including allergies, surgeries, and history.',
          iconWidget: SvgPicture.asset(
            'assets/icons/share_card_illo.svg',
            width: 58,
            height: 64,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        // 2. Medical Records
        _buildModuleCard(
          moduleKey: 'medical',
          title: 'Medical Records',
          description:
              'Specific lab reports, imaging scans, and individual clinical notes from recent visits.',
          iconWidget: SvgPicture.asset(
            'assets/icons/share_medical_illo.svg',
            width: 61,
            height: 66,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        // 3. Dental Records
        _buildModuleCard(
          moduleKey: 'dental',
          title: 'Dental Records',
          description: 'Dental data and sharing permissions for the infos.',
          iconWidget: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAD8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/share_dental_tooth.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 4. Vision Records
        _buildModuleCard(
          moduleKey: 'vision',
          title: 'Vision Records',
          description:
              'Dependent health data and sharing permissions for eye infos.',
          iconWidget: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDAD8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/share_vision_glasses.svg',
                width: 24,
                height: 18,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 5. Insurance Information
        _buildModuleCard(
          moduleKey: 'insurance',
          title: 'Insurance Information',
          description:
              'Current policy details, carrier information, and verification QR codes for instant check-in.',
          iconWidget: SvgPicture.asset(
            'assets/icons/share_insurance_illo.svg',
            width: 54,
            height: 64,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        // 6. Family Member Access
        _buildModuleCard(
          moduleKey: 'family',
          title: 'Family Member Access',
          description:
              'Dependent health data and sharing permissions for children or elderly family members.',
          iconWidget: SvgPicture.asset(
            'assets/icons/share_family_illo.svg',
            width: 58,
            height: 66,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        // 7. Pet Records
        _buildModuleCard(
          moduleKey: 'pet',
          title: 'Pet Records',
          description:
              'Specific lab reports, imaging scans, and individual clinical notes from recent visits.',
          iconWidget: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFDCE9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/share_pet_paw.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Single Module Card with custom illustration and selection indicator
  Widget _buildModuleCard({
    required String moduleKey,
    required String title,
    required String description,
    required Widget iconWidget,
  }) {
    final isSelected = _selectedModules.contains(moduleKey);

    return GestureDetector(
      onTap: () => _toggleModule(moduleKey),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.70),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF28006D)
                : const Color(0xFFCBC4D4),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0x1F28006D)
                  : const Color(0x0A000000),
              blurRadius: isSelected ? 16 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Illustration Icon & Selection Checkbox/Radio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustration Icon Container
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: iconWidget,
                ),

                // Selection Radio/Checkbox Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFF28006D)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF28006D)
                          : const Color(0xFF7A7583),
                      width: 2.0,
                    ),
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Card Title
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF28006D),
                letterSpacing: -0.2,
              ),
            ),

            const SizedBox(height: 4),

            // Card Description
            Text(
              description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 1.42,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Access Duration Segmented Selector (Figma node 20:23320)
  Widget _buildDurationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACCESS DURATION',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
            letterSpacing: 0.7,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 384),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Segment 1: Temporary (24h)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedDuration = AccessDuration.temporary24h);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedDuration == AccessDuration.temporary24h
                          ? const Color(0xFF3F1D8B)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedDuration == AccessDuration.temporary24h
                          ? const [
                              BoxShadow(
                                color: Color(0x1F000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        'Temporary (24h)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _selectedDuration == AccessDuration.temporary24h
                              ? const Color(0xFFAB8EFD)
                              : const Color(0xFF494552),
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Segment 2: Permanent
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedDuration = AccessDuration.permanent);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedDuration == AccessDuration.permanent
                          ? const Color(0xFF3F1D8B)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _selectedDuration == AccessDuration.permanent
                          ? const [
                              BoxShadow(
                                color: Color(0x1F000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        'Permanent',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _selectedDuration == AccessDuration.permanent
                              ? const Color(0xFFAB8EFD)
                              : const Color(0xFF494552),
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Primary CTA Action Button & Encrypted Footnote (Figma node 20:23328)
  Widget _buildPrimaryActionSection() {
    return Column(
      children: [
        // Full-width Gradient Pill Button: "Generate Secure QR"
        GestureDetector(
          onTap: _onGenerateSecureQr,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 448),
            padding: const EdgeInsets.symmetric(vertical: 18),
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
                  color: Color(0x3328006D),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/share_sparkle_qr.svg',
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  'Generate Secure QR',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // End-to-end encrypted sharing protocol active Footnote
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/share_lock_e2e.svg',
              width: 10,
              height: 12,
            ),
            const SizedBox(width: 6),
            Text(
              'End-to-end encrypted sharing protocol active',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
