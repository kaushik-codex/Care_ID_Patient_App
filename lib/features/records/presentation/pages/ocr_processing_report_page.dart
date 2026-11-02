import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:care_id_patient_app/core/routing/app_routes.dart';
import 'package:care_id_patient_app/core/widgets/care_id_bottom_nav_bar.dart';

/// OCR Processing - Report (Figma node 20:32321)
class OcrProcessingReportPage extends StatefulWidget {
  const OcrProcessingReportPage({super.key});

  @override
  State<OcrProcessingReportPage> createState() => _OcrProcessingReportPageState();
}

class _OcrProcessingReportPageState extends State<OcrProcessingReportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _progressAnimation = Tween<double>(begin: 0.15, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );

    _progressController.forward();

    // Auto-advance to Review Health Record when completed
    _autoAdvanceTimer = Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        _proceedToReview();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _autoAdvanceTimer?.cancel();
    super.dispose();
  }

  void _proceedToReview() {
    _autoAdvanceTimer?.cancel();
    Navigator.of(context).pushReplacementNamed(AppRoutes.reviewHealthRecord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // Atmospheric Background Glow Elements (Figma node 20:32323)
          Positioned(
            right: -80,
            top: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF75F2FE).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -80,
            bottom: 120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3F1D8B).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable / Centered Content Canvas
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 72,
                  bottom: 24,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Scanning Visual Bento Section (Figma node 20:32349)
                    _buildScanningVisualCard(),

                    const SizedBox(height: 24),

                    // 4-Segment Step Indicator Progress Bar (Figma node 20:32377)
                    _buildStepIndicators(),

                    const SizedBox(height: 24),

                    // Status Text Area (Figma node 20:32328)
                    Text(
                      'Extracting Report Information...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Our secure vault is processing your data with clinical precision. Please wait a moment.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Detail Cards: Security & Storage (Figma node 20:32334)
                    _buildDetailCards(),

                    const SizedBox(height: 24),

                    // Manual Skip / Review Button (allows immediate advance during testing)
                    GestureDetector(
                      key: const Key('ocr_processing_proceed_button'),
                      onTap: _proceedToReview,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(color: const Color(0xFFE7ECF6)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tap to View Extracted Data',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF00696B),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: Color(0xFF00696B),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Fixed Top App Bar (Figma node 20:32383)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),
        ],
      ),

      // Docked unified Bottom Navigation Bar (Tab 1: Records active)
      bottomNavigationBar: const CareIDBottomNavBar(
        currentIndex: 1,
      ),
    );
  }

  /// Top App Bar (Figma node 20:32383)
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
                color: const Color(0xFFCBC4D4).withValues(alpha: 0.25),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Back button
              GestureDetector(
                key: const Key('ocr_processing_back_button'),
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

              // Dead Center: CareID Logo Wordmark
              Image.asset(
                'assets/images/care_id_logo_wordmark.png',
                width: 79,
                height: 18,
                fit: BoxFit.contain,
              ),

              // Right: Notification Bell
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FF),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE7ECF6)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/home_bell.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Scanning Visual Section (Bento Card Layout, Figma node 20:32349)
  Widget _buildScanningVisualCard() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.60),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1428006D),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Blurred Document Skeleton Placeholder
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFCBC4D4),
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFFDCE9FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 12,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCBC4D4).withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  height: 10,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCBC4D4).withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFCBC4D4).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFCBC4D4).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Scanning Line Overlay
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(0, (_progressAnimation.value * 2) - 1.0),
                    child: Container(
                      height: 4,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF006971),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF006971),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Centered Shield Progress Ring (Figma node 20:32365)
              Center(
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    final percent = (_progressAnimation.value * 100).toInt();

                    return Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.90),
                        border: Border.all(
                          color: const Color(0xFF006971),
                          width: 3,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F28006D),
                            blurRadius: 15,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$percent%',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF28006D),
                            ),
                          ),
                          Text(
                            'ACTIVE',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: const Color(0xFF006971),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 4-Segment Step Indicator Progress Bar (Figma node 20:32377)
  Widget _buildStepIndicators() {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final progress = _progressAnimation.value;

        return Row(
          children: List.generate(4, (i) {
            final isFilled = progress >= ((i + 1) * 0.25);
            final isCurrent = !isFilled && (progress >= (i * 0.25));

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: i == 0 ? 0 : 4,
                  right: i == 3 ? 0 : 4,
                ),
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: isFilled
                      ? const Color(0xFF28006D)
                      : (isCurrent ? const Color(0xFF006971) : const Color(0xFFDCE9FF)),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  /// Detail Cards: Security & Storage (Figma node 20:32334)
  Widget _buildDetailCards() {
    return Row(
      children: [
        // Security Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.60)),
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
                const Icon(
                  Icons.shield_outlined,
                  size: 20,
                  color: Color(0xFF006971),
                ),
                const SizedBox(height: 8),
                Text(
                  'SECURITY',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: const Color(0xFF7A7583),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'AES-256 Encrypted',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Storage Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF006971).withValues(alpha: 0.20)),
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
                const Icon(
                  Icons.cloud_done_outlined,
                  size: 20,
                  color: Color(0xFF006971),
                ),
                const SizedBox(height: 8),
                Text(
                  'STORAGE',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: const Color(0xFF7A7583),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cloud Sync Active',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
}

