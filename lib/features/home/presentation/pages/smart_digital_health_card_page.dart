import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 14: Smart Digital Health Card (Figma node 20:19873)
///
/// Expanded full-credential view of the patient's Smart Digital Health Card.
/// Reached by tapping "Add to Wallet" on the Home dashboard.
/// Features:
/// - Top App Bar with back navigation, user avatar, CareID logo, notification bell
/// - High-fidelity Smart Health Card with 80x80 patient photo, Richard name, CI number,
///   digital signature badge, 80x80 QR matrix, and authentic CareID ID fingerprint badge
/// - Apple Wallet & Google Wallet one-tap integration action buttons
/// - Patient Credentials bento grid with verified badge, DOB, O+ blood group,
///   active insurance, emergency contact, known allergies, last-updated timestamp,
///   and interactive "Refresh QR" action
/// - Secondary actions: "Download PDF" and "Share QR Code"
/// - "Encrypted Access" security banner
/// - Persistent frosted bottom navigation bar
class SmartDigitalHealthCardPage extends StatefulWidget {
  const SmartDigitalHealthCardPage({super.key});

  @override
  State<SmartDigitalHealthCardPage> createState() => _SmartDigitalHealthCardPageState();
}

class _SmartDigitalHealthCardPageState extends State<SmartDigitalHealthCardPage> {
  String _lastUpdatedTime = 'Oct 24, 2023 • 14:22 PM';
  bool _isRefreshing = false;

  void _onRefreshQr() {
    setState(() => _isRefreshing = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        final now = DateTime.now();
        final formatted =
            'Oct ${now.day}, ${now.year} • ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';
        setState(() {
          _lastUpdatedTime = formatted;
          _isRefreshing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Digital QR signature refreshed successfully',
              style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            backgroundColor: const Color(0xFF28006D),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _onWalletAction(String walletName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Adding Smart Health Card to $walletName...',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF0B1C30),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onDownloadPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Downloading official CareID Medical Credential PDF...',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF3F1D8B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onShareQr() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening Secure Share Options...',
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
              padding: const EdgeInsets.only(top: 72, bottom: 120),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),

                    // Hero Smart Digital Health Card
                    _buildSmartHealthCard(),

                    const SizedBox(height: 24),

                    // Wallet Actions (Apple Wallet & Google Wallet)
                    _buildWalletActions(),

                    const SizedBox(height: 24),

                    // Patient Credentials Bento Grid
                    _buildPatientCredentialsCard(),

                    const SizedBox(height: 20),

                    // Secondary Quick Actions (Download PDF & Share QR Code)
                    _buildSecondaryActions(),

                    const SizedBox(height: 16),

                    // Encrypted Access Security Banner
                    _buildEncryptedAccessBanner(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // 2. Fixed Top App Bar (Back Arrow, Avatar, Centered CareID Logo, Notification Bell)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Fixed Unified Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Back navigation at left end, Dead Center Wordmark Logo, Notification Bell and Avatar at right end)
  Widget _buildTopAppBar() {
    final topPadding = MediaQuery.of(context).padding.top;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64 + topPadding,
          padding: EdgeInsets.only(top: topPadding),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Back Nav Arrow placed at the far left end (like other screens)
              Positioned(
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'assets/icons/card_header_back.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
              ),

              // 2. Dead Center Logo: Exact same logo as in dashboard screen
              Center(
                child: Image.asset(
                  'assets/images/care_id_logo_wordmark.png',
                  height: 18,
                  fit: BoxFit.contain,
                ),
              ),

              // 3. Right End: Notification Bell + Profile Avatar
              Positioned(
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Notification Bell Button
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

                    const SizedBox(width: 8),

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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hero Smart Digital Health Card
  Widget _buildSmartHealthCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 440),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment(-0.85, -0.85),
          end: Alignment(0.85, 0.85),
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
            // Top-right cyan ambient circular orb
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

            // Bottom-left purple ambient circular orb
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

            // Watermark pattern
            Positioned(
              left: 40,
              top: 50,
              child: Opacity(
                opacity: 0.22,
                child: Image.asset(
                  'assets/images/home_card_watermark.png',
                  width: 320,
                  height: 320,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Card Foreground Content
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: 80x80 Patient Photo + Richard + CI Number
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 80x80 Circular Patient Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 4,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/patient_avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 18),

                      // Name & Identifier
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Richard',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 44,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1.2,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'CI-882-0911',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Digital Health Signature Label & Verified Row
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DIGITAL HEALTH SIGNATURE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.65),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/digital_sig_check.svg',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ENCRYPTED CAREID',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Bottom Badges Row: 80x80 QR Code & 89x66 Brand Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 80x80 QR Code Card
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/home_qr_code.svg',
                            width: 68,
                            height: 68,
                          ),
                        ),
                      ),

                      // 89x66 Official CareID ID Brand Badge
                      Container(
                        width: 89,
                        height: 66,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F000000),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/card_id_badge.png',
                            fit: BoxFit.contain,
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
    );
  }

  /// Wallet Actions (Apple Wallet & Google Wallet)
  Widget _buildWalletActions() {
    return Column(
      children: [
        // "Add to Apple Wallet" Button (Black pill, radius 8px)
        GestureDetector(
          onTap: () => _onWalletAction('Apple Wallet'),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/apple_wallet_logo.svg',
                  width: 18,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Add to Apple Wallet',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // "Add to Google Wallet" Button (Cyan tint, radius 8px)
        GestureDetector(
          onTap: () => _onWalletAction('Google Wallet'),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF75F2FE).withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBC4D4)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/google-tile.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Pay',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF5F6368),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add to Google Wallet',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Patient Credentials Bento Grid
  Widget _buildPatientCredentialsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Patient Credentials + CareID VERIFIED badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Patient Credentials',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF75F2FE),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/careid_verified_badge.svg',
                      width: 12,
                      height: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'CareID VERIFIED',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF006D76),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Row 1: Date of Birth & Blood Group
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCredentialItem(
                  label: 'DATE OF BIRTH',
                  value: '12 May 1992',
                ),
              ),
              Expanded(
                child: _buildCredentialItem(
                  label: 'BLOOD GROUP',
                  value: 'O Positive (O+)',
                  valueColor: const Color(0xFFBA1A1A),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Row 2: Insurance Status & Emergency Contact
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INSURANCE STATUS',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494552),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF22C55E),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Active',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildCredentialItem(
                  label: 'EMERGENCY CONTACT',
                  value: 'John Doe (+1 555-0123)',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Row 3: Known Allergies (Full width)
          _buildCredentialItem(
            label: 'KNOWN ALLERGIES',
            value: 'Penicillin, Peanuts, Latex',
            valueColor: const Color(0xFF28006D),
          ),

          const SizedBox(height: 20),
          const Divider(color: Color(0xFFCBC4D4), height: 1),
          const SizedBox(height: 18),

          // Footer Row: Last Updated + Refresh QR Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Last Updated Timestamp
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/clock_history.svg',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Last Updated: $_lastUpdatedTime',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ],
              ),

              // "Refresh QR" Action
              GestureDetector(
                onTap: _isRefreshing ? null : _onRefreshQr,
                child: Row(
                  children: [
                    AnimatedRotation(
                      turns: _isRefreshing ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 600),
                      child: SvgPicture.asset(
                        'assets/icons/refresh_qr.svg',
                        width: 13,
                        height: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Refresh QR',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Credential Item Text Pair
  Widget _buildCredentialItem({
    required String label,
    required String value,
    Color valueColor = const Color(0xFF0B1C30),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  /// Secondary Quick Actions (Download PDF & Share QR Code)
  Widget _buildSecondaryActions() {
    return Column(
      children: [
        // Download PDF
        GestureDetector(
          onTap: _onDownloadPdf,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F1D8B).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/download_pdf_doc.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Download PDF',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/card_chevron_right.svg',
                  width: 8,
                  height: 12,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Share QR Code
        GestureDetector(
          onTap: _onShareQr,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF75F2FE).withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/share_qr_nodes.svg',
                      width: 18,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Share QR Code',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/card_chevron_right.svg',
                  width: 8,
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Encrypted Access Security Banner
  Widget _buildEncryptedAccessBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF3F1D8B).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF28006D).withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/encrypted_access_info.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 14),
          Text(
            'Encrypted Access',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF28006D),
            ),
          ),
        ],
      ),
    );
  }
}
