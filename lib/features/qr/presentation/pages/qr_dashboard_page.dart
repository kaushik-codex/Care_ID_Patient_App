import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../../../core/widgets/care_id_notification_button.dart';

/// Page 15: QR Dashboard (Figma node 20:22771)
///
/// Central hub for Patient QR code sharing and management:
/// - Frosted Top App Bar with back navigation, "QR Sharing" title, patient avatar
/// - Main QR Card with "Active & Encrypted" status badge, dedicated header Refresh QR button,
///   256x256 high-resolution QR matrix with center CareID logo badge, patient details
///   ("Eliza V. Reed", "CID-9928"), and last-updated timestamp
/// - 2x2 Bento Quick Actions Grid:
///   1. "Generate New" (Purple Gradient)
///   2. "Share QR" (Soft Ice Blue)
///   3. "Download PDF" (Soft Ice Blue)
///   4. "Access History" (Soft Ice Blue with authentic History Clock icon)
/// - "Data Privacy Guard" informational security banner
/// - Unified frosted bottom navigation bar with dual option bubbles
class QrDashboardPage extends StatefulWidget {
  const QrDashboardPage({super.key});

  @override
  State<QrDashboardPage> createState() => _QrDashboardPageState();
}

class _QrDashboardPageState extends State<QrDashboardPage> {
  String _lastUpdatedText = 'Last Updated: 2 mins ago';
  bool _isRefreshing = false;

  void _onRefreshQr() {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _lastUpdatedText = 'Last Updated: Just now';
          _isRefreshing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Digital QR signature refreshed successfully',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF28006D),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _onGenerateNew() {
    setState(() => _isRefreshing = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          _lastUpdatedText = 'Last Updated: Just now';
          _isRefreshing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'New unique encrypted QR code generated',
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
    });
  }

  void _onShareQr() {
    Navigator.of(context).pushNamed(AppRoutes.shareOptions);
  }

  void _onDownloadPdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Downloading official CareID Medical Credential PDF...',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF3F1D8B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onAccessHistory() {
    Navigator.of(context).pushNamed(AppRoutes.accessHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Scrollable Main Content Area
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
                    const SizedBox(height: 8),

                    // Section 1: Main White QR Card
                    _buildMainQrCard(),

                    const SizedBox(height: 24),

                    // Section 2: 2x2 Bento Quick Actions Grid
                    _buildQuickActionGrid(),

                    const SizedBox(height: 24),

                    // Section 3: Data Privacy Guard Banner
                    _buildDataPrivacyBanner(),

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

  /// Top App Bar (Back chevron, "QR Sharing" Title, Patient Avatar)
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
              // Left Group: Circular Back Button + "QR Sharing" Title
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
                          'assets/icons/qr_back_chevron.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    'QR Sharing',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/card_id_badge.png',
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              // Right Group: Notification Bell + Patient Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CareIDNotificationButton(),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.profileSettingsHub);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE8DDFF),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/patient_avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section 1: Main QR Card (Figma node 20:22812)
  Widget _buildMainQrCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 440),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A3F1D8B),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Header Row: Status Badge & Refresh Button (Figma node 254:89)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Empty spacer for balance
                const SizedBox(width: 40),

                // Center: Status Badge ("Active & Encrypted")
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF75F2FE),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/active_encrypted_badge.svg',
                        width: 12,
                        height: 15,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Active & Encrypted',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF006D76),
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right: Dedicated Header Refresh QR Button (Figma node 254:89)
                GestureDetector(
                  onTap: _onRefreshQr,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF28006D).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: AnimatedRotation(
                        turns: _isRefreshing ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 600),
                        child: SvgPicture.asset(
                          'assets/icons/card_header_refresh.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Centered 256x256 QR Box Container (Figma node 20:22825)
            Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF28006D).withValues(alpha: 0.10),
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // High-fidelity QR Matrix SVG
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: SvgPicture.asset(
                      'assets/icons/home_qr_code.svg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Center CareID Fingerprint Brand Logo Badge
                  Container(
                    width: 88,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/qr_center_careid_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Identity Details: Patient Name & CID
            Text(
              'Eliza V. Reed',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
                height: 1.33,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'CID-9928',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
                letterSpacing: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // Footer Divider + Last Updated Row
            Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFFD3E4FE).withValues(alpha: 0.70),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/last_updated_clock.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _lastUpdatedText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
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
    );
  }

  /// Section 2: 2x2 Bento Quick Actions Grid (Figma node 20:23161)
  Widget _buildQuickActionGrid() {
    return Column(
      children: [
        // Row 1: Generate New & Share QR
        Row(
          children: [
            // Tile 1: Generate New (Purple Gradient)
            Expanded(
              child: GestureDetector(
                onTap: _onGenerateNew,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 128,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFA44CFF),
                        Color(0xFF5B14B8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x335B14B8),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FF).withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/bento_generate_new.svg',
                            width: 18,
                            height: 18,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Text(
                        'Generate New',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Tile 2: Share QR (Ice Blue)
            Expanded(
              child: GestureDetector(
                onTap: _onShareQr,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 128,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE9FF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF28006D).withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/bento_share_qr.svg',
                            width: 18,
                            height: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Share QR',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Row 2: Download PDF & Access History
        Row(
          children: [
            // Tile 3: Download PDF (Ice Blue)
            Expanded(
              child: GestureDetector(
                onTap: _onDownloadPdf,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 128,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE9FF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF28006D).withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/bento_download_pdf.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Download PDF',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                          letterSpacing: 0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Tile 4: Access History (Ice Blue with History Icon, replaced per updated Figma design)
            Expanded(
              child: GestureDetector(
                onTap: _onAccessHistory,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 128,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE9FF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF28006D).withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/bento_access_history.svg',
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      Text(
                        'Access History',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                          letterSpacing: 0.28,
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
    );
  }

  /// Section 3: Data Privacy Guard Banner (Figma node 20:23186)
  Widget _buildDataPrivacyBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EEFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF006971),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/privacy_guard_shield.svg',
                width: 16,
                height: 20,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Privacy Guard',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                    letterSpacing: 0.28,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your QR code expires automatically every 24 hours to ensure your health data stays secure.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.25,
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

