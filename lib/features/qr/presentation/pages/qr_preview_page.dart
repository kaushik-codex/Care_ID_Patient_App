import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Navigation arguments passed to [QrPreviewPage] from [ShareOptionsPage].
class QrPreviewArguments {
  final String sharingType;
  final String expiryText;

  const QrPreviewArguments({
    this.sharingType = 'Full Medical Record',
    this.expiryText = 'Expires in 23h 58m 58s',
  });
}

/// Page 17: QR Preview (Figma node 20:23338)
/// Displays an encrypted temporary vault access QR code with countdown expiry,
/// action buttons for sharing and downloading, and security notices.
class QrPreviewPage extends StatelessWidget {
  final QrPreviewArguments? arguments;

  const QrPreviewPage({
    super.key,
    this.arguments,
  });

  void _handleShareSecureLink(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.accessVerification);
  }

  void _handleDownloadImage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'High-resolution QR code image saved to gallery.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006971),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Read route arguments if not directly provided in constructor
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final args = arguments ??
        (routeArgs is QrPreviewArguments
            ? routeArgs
            : const QrPreviewArguments());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Scrollable Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Top App Bar
                        _buildTopAppBar(context),

                        const SizedBox(height: 8),

                        // Premium QR Card
                        _buildPremiumQrCard(),

                        const SizedBox(height: 24),

                        // Details Section
                        _buildDetailsSection(args),

                        const SizedBox(height: 24),

                        // Action Buttons
                        _buildActionButtons(context),

                        const SizedBox(height: 8),

                        // Security Footer
                        _buildSecurityFooter(),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Persistent Unified Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: 1),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Back Arrow, Title "QR Preview", Patient Avatar)
  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: const Color(0xFFF8F9FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Group: Back Arrow Button + Title
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/qr_preview_back.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'QR Preview',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                  height: 28 / 20,
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

          // Right Group: Patient Avatar with #DCE9FF background and border
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFDCE9FF),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFCBC4D4),
                width: 1.0,
              ),
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
    );
  }

  /// Premium QR Card (Figma node 20:23379)
  Widget _buildPremiumQrCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF006971).withValues(alpha: 0.12),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(-2, 0),
          ),
          BoxShadow(
            color: const Color(0xFF28006D).withValues(alpha: 0.12),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFCBC4D4),
            width: 1.0,
          ),
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
            // Header row: Vault lock + "SECURE VAULT ACCESS" + Status Dot
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/vault_lock.svg',
                        width: 10,
                        height: 12,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'SECURE VAULT ACCESS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF28006D),
                            letterSpacing: 0.8,
                            height: 24 / 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF006971),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // QR Code Container
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFCBC4D4).withValues(alpha: 0.3),
                  width: 1.0,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                width: 176,
                height: 176,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/qr_preview_matrix.svg',
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      width: 44,
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/card_id_badge.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Security Badge: End-to-End Encrypted
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFF75F2FE).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFF006971).withValues(alpha: 0.1),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/shield_encrypted.svg',
                    width: 16,
                    height: 21,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'End-to-End Encrypted',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF006D76),
                        height: 24 / 16,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  /// Details Section (Figma node 20:23419)
  Widget _buildDetailsSection(QrPreviewArguments args) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Sharing Type
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sharing Type',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        args.sharingType,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1C30),
                          height: 24 / 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/sharing_type_arrow.svg',
                  width: 16,
                  height: 20,
                ),
              ],
            ),
          ),

          // Divider Line
          Container(
            height: 1,
            color: const Color(0xFFCBC4D4).withValues(alpha: 0.1),
          ),

          const SizedBox(height: 16),

          // Row 2: Expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                        height: 24 / 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      args.expiryText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFBA1A1A),
                        height: 24 / 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/icons/expiry_clock.svg',
                width: 18,
                height: 21,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Action Buttons (Figma node 20:23436)
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // 1. Share Secure Link Button
        GestureDetector(
          onTap: () => _handleShareSecureLink(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA44CFF),
                  Color(0xFF5B14B8),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x335B14B8),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/share_secure_link.svg',
                  width: 18,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Share Secure Link',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 24 / 16,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 2. Download Image Button
        GestureDetector(
          onTap: () => _handleDownloadImage(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: const Color(0xFF006971),
                width: 2.0,
              ),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/download_image.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Download Image',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF006971),
                    height: 24 / 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Security Footer (Figma node 20:23446)
  Widget _buildSecurityFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552).withValues(alpha: 0.8),
            height: 26 / 16,
          ),
          children: [
            const TextSpan(text: 'This QR is temporary and will rotate\nfor your protection. '),
            TextSpan(
              text: 'Learn more',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF28006D),
              ),
            ),
            const TextSpan(text: '\n'),
            TextSpan(
              text: 'about Vault Security.',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF28006D),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
