import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 20: Access Verification (Figma node 20:23745)
///
/// Post-authorization confirmation screen displaying:
/// - Fixed frosted Top App Bar with back chevron, CareID logo, patient avatar
/// - Ambient cyan & violet blurred glowing spheres
/// - Hero Success Shield (Teal shield outline, checkmark, floating "SECURE" badge)
/// - Verification text hierarchy ("Verified", personalized doctor subtitle)
/// - Encrypted Session ID card with tap-to-copy interaction
/// - 3 Frosted glassmorphic verification badges (Identity, Doctor, Encryption)
/// - Primary purple gradient "Done →" CTA button
/// - End-to-end encryption security footnote
class AccessVerificationPage extends StatefulWidget {
  final String doctorName;
  final String sessionId;

  const AccessVerificationPage({
    super.key,
    this.doctorName = 'Dr. Marcus Thorne',
    this.sessionId = 'HV-90210-X',
  });

  @override
  State<AccessVerificationPage> createState() => _AccessVerificationPageState();
}

class _AccessVerificationPageState extends State<AccessVerificationPage> {
  void _handleCopySessionId() {
    Clipboard.setData(ClipboardData(text: widget.sessionId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Session ID copied to clipboard: ${widget.sessionId}',
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

  void _handleDone() {
    // Navigate back to Home or pop
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Ambient Background Glow Sphere (Lower Section)
          Positioned(
            right: 20,
            bottom: 120,
            child: IgnorePointer(
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE8DDFF).withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE8DDFF).withValues(alpha: 0.20),
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Main Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 72, bottom: 48),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),

                        // Success Illustration (Shield with Checkmark & Floating Badge)
                        _buildHeroIllustration(),

                        const SizedBox(height: 24),

                        // Verification Text Hierarchy (Verified title, doctor subtitle, session ID)
                        _buildVerificationTextHierarchy(),

                        const SizedBox(height: 32),

                        // Verification Badges (3 Frosted Glassmorphic Cards)
                        _buildVerificationBadges(),

                        const SizedBox(height: 32),

                        // Primary CTA: "Done →" Button
                        _buildPrimaryCtaButton(),

                        const SizedBox(height: 24),

                        // Footer Security Note
                        _buildFooterSecurityNote(),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Fixed Frosted Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),
        ],
      ),
    );
  }

  /// Fixed Frosted Top App Bar (Figma node 20:23746)
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
              // Left: Back Chevron with consistent 16x16 icon in 40x40 tap area
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
                      'assets/icons/qr_preview_back.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),

              // Center: CareID Logo Wordmark (Figma node 20:23750)
              Image.asset(
                'assets/images/care_id_logo_small.png',
                height: 20,
                fit: BoxFit.contain,
              ),

              // Right: Patient Avatar (Figma node 20:23751)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFDCE9FF),
                    width: 2.0,
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
        ),
      ),
    );
  }

  /// Success Illustration Composition (Figma node 20:23785)
  Widget _buildHeroIllustration() {
    return Center(
      child: SizedBox(
        width: 240,
        height: 240,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // 1. Layered Ambient Glow that follows the shield silhouette
            // Layer 1A: Broad soft cyan aura
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
              child: SvgPicture.asset(
                'assets/icons/verification_shield.svg',
                width: 216,
                height: 216,
                colorFilter: ColorFilter.mode(
                  const Color(0xFF75F2FE).withValues(alpha: 0.60),
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Layer 1B: Focused vibrant teal shield contour glow
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: SvgPicture.asset(
                'assets/icons/verification_shield.svg',
                width: 198,
                height: 198,
                colorFilter: ColorFilter.mode(
                  const Color(0xFF006971).withValues(alpha: 0.35),
                  BlendMode.srcIn,
                ),
              ),
            ),

            // 2. Primary Teal Shield SVG (192x192)
            SvgPicture.asset(
              'assets/icons/verification_shield.svg',
              width: 192,
              height: 192,
            ),

            // 3. Bold Checkmark Overlay inside shield
            SvgPicture.asset(
              'assets/icons/verification_checkmark.svg',
              width: 96,
              height: 96,
            ),

            // 4. Floating Pill Badge (Top-Right: lock icon + "SECURE")
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 15,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/verification_floating_lock.svg',
                      width: 12,
                      height: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'SECURE',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494552),
                        letterSpacing: 0.5,
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

  /// Verification Text Hierarchy (Figma node 20:23758)
  Widget _buildVerificationTextHierarchy() {
    return Column(
      children: [
        // Verified Title
        Text(
          'Verified',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
            letterSpacing: -0.96,
            height: 56 / 48,
          ),
        ),

        const SizedBox(height: 16),

        // Personalized Doctor Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 28 / 18,
              ),
              children: [
                const TextSpan(text: 'Your health records have been\nsecurely shared with '),
                TextSpan(
                  text: widget.doctorName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF28006D),
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 20),

        // Encrypted Session ID Card (Figma node 20:23763)
        InkWell(
          onTap: _handleCopySessionId,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFCBC4D4).withValues(alpha: 0.50),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/verification_session_id.svg',
                  width: 14,
                  height: 11,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Encrypted Session ID: ${widget.sessionId}',
                    style: GoogleFonts.spaceMono(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      letterSpacing: 0.7,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Verification Badges Section: 3 Frosted Bento Cards (Figma node 20:23769)
  Widget _buildVerificationBadges() {
    return Column(
      children: [
        _buildBadgeCard(
          iconPath: 'assets/icons/verification_identity.svg',
          iconWidth: 16,
          iconHeight: 20,
          title: 'Identity Verified',
        ),
        const SizedBox(height: 16),
        _buildBadgeCard(
          iconPath: 'assets/icons/verification_doctor.svg',
          iconWidth: 20,
          iconHeight: 20,
          title: 'Doctor Verified',
        ),
        const SizedBox(height: 16),
        _buildBadgeCard(
          iconPath: 'assets/icons/verification_encryption.svg',
          iconWidth: 16,
          iconHeight: 21,
          title: 'Secure Encryption',
        ),
      ],
    );
  }

  /// Single Frosted Glassmorphic Badge Card
  Widget _buildBadgeCard({
    required String iconPath,
    required double iconWidth,
    required double iconHeight,
    required String title,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.40),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF75F2FE).withValues(alpha: 0.50),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: iconWidth,
                    height: iconHeight,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                  letterSpacing: 0.28,
                  height: 16 / 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Primary CTA "Done →" Button (Figma node 20:23801)
  Widget _buildPrimaryCtaButton() {
    return GestureDetector(
      onTap: _handleDone,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 384),
        height: 60,
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
              color: Color(0x3328006D),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Done',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/verification_done_arrow.svg',
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// Footer Security Note (Figma node 20:23806)
  Widget _buildFooterSecurityNote() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SvgPicture.asset(
                    'assets/icons/verification_footer_shield.svg',
                    width: 10,
                    height: 12,
                  ),
                ),
              ),
              TextSpan(
                text: 'This session is protected by end-to-end medical grade encryption.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF494552).withValues(alpha: 0.60),
                  height: 16 / 12,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
