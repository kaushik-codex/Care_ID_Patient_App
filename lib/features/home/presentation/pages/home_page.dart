import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 13: Home - Option 6 (Figma node 20:19552)
///
/// Central hub of the CareID Patient Experience featuring:
/// - Frosted Top App Bar with patient avatar, status badge, CareID logo, notification bell
/// - Glassmorphic Hero Health Card with dual diffuse ambient glows (via radial gradient shader),
///   watermark pattern, patient details, ICE Active emergency badge, DOB/Blood Group,
///   authentic QR code, and "Add to Wallet" action
/// - Provider invitation notice with dedicated vertical clearance
/// - 2x2 Bento grid for Health Records with soft visible drop shadows
/// - 2x2 Bento grid for Quick Actions with identical drop shadows and badges
/// - Upcoming appointments card (Dental Appointment & Prescription Collection)
/// - Symmetrically aligned Bottom Navigation Bar with centered QR FAB, bright cyan
///   active pill, and uniform 20x20 icons
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeNavIndex = 0;

  void _onCategoryTapped(String categoryName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$categoryName records opening...',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF3F1D8B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onQuickActionTapped(String actionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$actionName selected',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF006971),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
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
              padding: const EdgeInsets.only(top: 68, bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),

                  // Hero Digital Health Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildHeroHealthCard(),
                  ),

                  // Dedicated vertical clearance so the card shadow does not interfere with the text
                  const SizedBox(height: 34),

                  // Provider Invitation Notice
                  _buildProviderInvitation(),

                  const SizedBox(height: 24),

                  // Health Records Section (2x2 Grid)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildHealthRecordsSection(),
                  ),

                  const SizedBox(height: 28),

                  // Quick Actions Section (2x2 Grid with identical drop shadows)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildQuickActionsSection(),
                  ),

                  const SizedBox(height: 28),

                  // Upcoming Appointments Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildUpcomingSection(),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // 2. Fixed Top App Bar (Frosted Glass)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Fixed Unified Bottom Navigation Bar with Central Floating QR Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(
              currentIndex: _activeNavIndex,
              onTabSelected: (index) {
                setState(() => _activeNavIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Frosted Glass, Avatar, Center Logo, Notification Bell)
  Widget _buildTopAppBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 64 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A3F1D8B),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Avatar with Online Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF3F1D8B), width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/patient_avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              // Centered CareID Logo
              Image.asset(
                'assets/images/care_id_logo_wordmark.png',
                height: 18,
                fit: BoxFit.contain,
              ),

              // Notification Bell Button with Red Unread Dot
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5EEFF),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/home_notification_bell.svg',
                        width: 16,
                        height: 20,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBA1A1A),
                            shape: BoxShape.circle,
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
      ),
    );
  }

  /// Hero Digital Health Card
  Widget _buildHeroHealthCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 440),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment(-0.8, -0.8),
          end: Alignment(0.8, 0.8),
          colors: [
            Color(0xFF3F1D8B),
            Color(0xFF006971),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x553F1D8B),
            blurRadius: 36,
            spreadRadius: -8,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Top-Right Cyan Ambient Glow Orb (Figma node 20:19555: size 256x256, blur 32px, top -64, right -64)
            Positioned(
              top: -64,
              right: -64,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                child: Container(
                  width: 256,
                  height: 256,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF75F2FE).withValues(alpha: 0.28),
                  ),
                ),
              ),
            ),

            // Bottom-Left Purple Ambient Glow Orb (Figma node 20:19556: size 256x256, blur 32px, bottom -64, left -64)
            Positioned(
              bottom: -64,
              left: -64,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                child: Container(
                  width: 256,
                  height: 256,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3F1D8B).withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),

            // Watermark logo backdrop pattern
            Positioned(
              left: 40,
              top: 100,
              child: Opacity(
                opacity: 0.22,
                child: Image.asset(
                  'assets/images/home_card_watermark.png',
                  width: 312,
                  height: 312,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Card Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: Digital Health ID & Shield + ICE Active
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Patient Info Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DIGITAL HEALTH ID',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCFBDFF),
                                letterSpacing: 0.7,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Richard\nMalouf',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1.0,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Member since 2021',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFE8DDFF),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Actions Column (Shield Button & ICE Active Badge)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Frosted Shield Button
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.10),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.20),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/home_hero_shield.svg',
                                width: 16,
                                height: 20,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // ICE Active Red Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFBA1A1A).withValues(alpha: 0.95),
                              borderRadius: BorderRadius.circular(9999),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home_ice_star.svg',
                                  width: 10,
                                  height: 10,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'ICE Active',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Glassmorphic Sub-card (DOB, Blood Group, QR Code, Add to Wallet)
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left Column: DOB & Blood Group
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DOB',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCFBDFF),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '15 May 1985',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'BLOOD GROUP',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCFBDFF),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'O Positive',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF83F3FF),
                              ),
                            ),
                          ],
                        ),

                        // Right Column: Authentic QR Code & Add to Wallet CTA
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // QR Code
                            SvgPicture.asset(
                              'assets/icons/home_qr_code.svg',
                              width: 68,
                              height: 68,
                            ),

                            const SizedBox(height: 12),

                            // "Add to Wallet" Button
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.smartHealthCard);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(9999),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.20),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x1A000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/home_wallet.svg',
                                      width: 12,
                                      height: 12,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Add to Wallet',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }

  /// Provider Invitation Notice
  Widget _buildProviderInvitation() {
    return Column(
      children: [
        Text(
          'Provider not registered?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 2),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Provider invitation sheet opening...',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Text(
            'Click here to invite your provider to CareID',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F1D8B),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  /// Health Records Section (2x2 Bento Grid: Medical, Dental, Vision, Pets)
  Widget _buildHealthRecordsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Records',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildRecordCard(
                title: 'Medical',
                subtitle: 'Lab result & scans',
                badgeBg: const Color(0xFFE8F8FA),
                iconPath: 'assets/icons/home_medical_doc.svg',
                onTap: () => _onCategoryTapped('Medical'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildRecordCard(
                title: 'Dental',
                subtitle: 'Checkup & X-rays',
                badgeBg: const Color(0xFFFBEAEB),
                iconPath: 'assets/icons/home_dental_tooth.svg',
                onTap: () => _onCategoryTapped('Dental'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildRecordCard(
                title: 'Vision',
                subtitle: 'Eye Checkups',
                badgeBg: const Color(0xFFEFE8FA),
                iconPath: 'assets/icons/home_vision_eye.svg',
                onTap: () => _onCategoryTapped('Vision'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildRecordCard(
                title: 'Pets',
                subtitle: 'Pet Checkups',
                badgeBg: const Color(0xFFEFE8FA),
                iconPath: 'assets/icons/home_pet_paw.svg',
                onTap: () => _onCategoryTapped('Pets'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Single Record Card
  Widget _buildRecordCard({
    required String title,
    required String subtitle,
    required Color badgeBg,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 156,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE7EAF5)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F3F1D8B),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon Badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                ),
              ),
            ),

            // Typography
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Quick Actions Section (2x2 Grid with identical drop shadows as Health Records)
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                title: 'Insurance Card',
                subtitle: 'Secure vault upload',
                iconBg: const Color(0xFFD3E4FE),
                iconPath: 'assets/icons/home_insurance_card.svg',
                badgeWidget: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00696B),
                    shape: BoxShape.circle,
                  ),
                ),
                onTap: () => _onQuickActionTapped('Insurance Card'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionTile(
                title: 'Add Family Member',
                subtitle: 'Secure health profile',
                iconBg: const Color(0xFFD3E4FE),
                iconPath: 'assets/icons/home_family_member.svg',
                badgeWidget: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00696B),
                    shape: BoxShape.circle,
                  ),
                ),
                onTap: () => _onQuickActionTapped('Add Family Member'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                title: 'Book Appointment',
                subtitle: 'Clinics & Specialists',
                iconBg: const Color(0xFFE8DDFF),
                iconPath: 'assets/icons/home_book_appt.svg',
                badgeWidget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00696B),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'PRIMARY',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () => _onQuickActionTapped('Book Appointment'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionTile(
                title: 'Emergency',
                subtitle: 'Critical medical data',
                iconBg: const Color(0xFFBA1A1A),
                iconPath: 'assets/icons/home_emergency_siren.svg',
                cardBg: const Color(0xFFFFDAD6).withValues(alpha: 0.45),
                titleColor: const Color(0xFF93000A),
                subtitleColor: const Color(0xFF93000A).withValues(alpha: 0.8),
                isEmergency: true,
                badgeWidget: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBA1A1A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'SOS',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF93000A),
                      ),
                    ),
                  ],
                ),
                onTap: () => _onQuickActionTapped('Emergency SOS'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Single Action Tile
  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required Color iconBg,
    required String iconPath,
    required Widget badgeWidget,
    Color cardBg = Colors.white,
    Color titleColor = const Color(0xFF0B1C30),
    Color subtitleColor = const Color(0xFF494552),
    bool isEmergency = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 112,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isEmergency ? const Color(0x14BA1A1A) : const Color(0x0F3F1D8B),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            const BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Icon circle + Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                badgeWidget,
              ],
            ),

            // Typography
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: subtitleColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Upcoming Section (Dental Appointment & Prescription Collection)
  Widget _buildUpcomingSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFE7EAF5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A3F1D8B),
            blurRadius: 28,
            offset: Offset(0, 12),
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
                'Upcoming',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFE7EAF5)),
                ),
                child: Text(
                  'View All',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF28006D),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE7EAF5), height: 1),
          const SizedBox(height: 16),

          // Appointment 1: Dental
          _buildAppointmentCard(
            month: 'JUN',
            day: '12',
            dateBadgeBg: const Color(0xFFEFE8FA),
            monthColor: const Color(0xFF8B30E6),
            dayColor: const Color(0xFF28006D),
            status: 'Confirmed',
            statusBg: const Color(0xFFDCFCE7),
            statusColor: const Color(0xFF15803D),
            title: 'Dental Appointment',
            details: 'City Hospital · 9:00 AM',
            cardBg: const Color(0xFFF8F6FF),
          ),

          const SizedBox(height: 12),

          // Appointment 2: Prescription Collection
          _buildAppointmentCard(
            month: 'JUN',
            day: '18',
            dateBadgeBg: const Color(0xFFD9F4F5),
            monthColor: const Color(0xFF006971),
            dayColor: const Color(0xFF004D52),
            status: 'Pending',
            statusBg: const Color(0xFFFEF9C3),
            statusColor: const Color(0xFF854D0E),
            title: 'Prescription Collection',
            details: 'Dr. Smith · 11:30 AM',
            cardBg: const Color(0xFFF0FAFA),
          ),
        ],
      ),
    );
  }

  /// Single Appointment Card
  Widget _buildAppointmentCard({
    required String month,
    required String day,
    required Color dateBadgeBg,
    required Color monthColor,
    required Color dayColor,
    required String status,
    required Color statusBg,
    required Color statusColor,
    required String title,
    required String details,
    required Color cardBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7EAF5)),
      ),
      child: Row(
        children: [
          // Date Badge
          Container(
            width: 52,
            height: 60,
            decoration: BoxDecoration(
              color: dateBadgeBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: monthColor,
                    letterSpacing: 0.6,
                  ),
                ),
                Text(
                  day,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: dayColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  details,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ),

          // Chevron Right
          SvgPicture.asset(
            'assets/icons/home_chevron_right.svg',
            width: 8,
            height: 12,
          ),
        ],
      ),
    );
  }
}
