import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:care_id_patient_app/core/routing/app_routes.dart';

/// Scan Reports (Figma node 20:32268)
class ScanReportsPage extends StatefulWidget {
  const ScanReportsPage({super.key});

  @override
  State<ScanReportsPage> createState() => _ScanReportsPageState();
}

class _ScanReportsPageState extends State<ScanReportsPage> with SingleTickerProviderStateMixin {
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    super.dispose();
  }

  void _onCapture() {
    Navigator.of(context).pushNamed(AppRoutes.ocrProcessingReport);
  }

  void _onGallery() {
    Navigator.of(context).pushNamed(AppRoutes.ocrProcessingReport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Simulation Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/scan_report_camera_sample.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF0B1C30),
              ),
            ),
          ),

          // Dark Overlay Gradients
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x990B1C30),
                    Colors.transparent,
                    Colors.transparent,
                    Color(0xCC0B1C30),
                  ],
                  stops: [0.0, 0.25, 0.75, 1.0],
                ),
              ),
            ),
          ),

          // Central Edge Detection Guide
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Edge Detection Target Frame
                  AspectRatio(
                    aspectRatio: 1.25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF75F2FE).withValues(alpha: 0.5),
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x66000000),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Top-Left Corner Guide
                          Positioned(
                            left: -4,
                            top: -4,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFF006971), width: 4),
                                  left: BorderSide(color: Color(0xFF006971), width: 4),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          // Top-Right Corner Guide
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFF006971), width: 4),
                                  right: BorderSide(color: Color(0xFF006971), width: 4),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          // Bottom-Left Corner Guide
                          Positioned(
                            left: -4,
                            bottom: -4,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF006971), width: 4),
                                  left: BorderSide(color: Color(0xFF006971), width: 4),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          // Bottom-Right Corner Guide
                          Positioned(
                            right: -4,
                            bottom: -4,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF006971), width: 4),
                                  right: BorderSide(color: Color(0xFF006971), width: 4),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),

                          // Center Focus Target
                          Center(
                            child: Opacity(
                              opacity: 0.25,
                              child: Icon(
                                Icons.filter_center_focus_rounded,
                                size: 54,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Scanning Laser Effect Line
                          AnimatedBuilder(
                            animation: _scanAnimation,
                            builder: (context, child) {
                              return Align(
                                alignment: Alignment(0, (_scanAnimation.value * 2) - 1.0),
                                child: Container(
                                  height: 3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF75F2FE),
                                        Colors.transparent,
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xFF75F2FE),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Floating Tip Pill
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.center_focus_strong_rounded,
                              size: 18,
                              color: Color(0xFF75F2FE),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Align report within the frame',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),

          // Bottom Controls Container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 24,
                    bottom: 24 + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1C30).withValues(alpha: 0.65),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Shutter Row: Flash, Shutter, Gallery
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Flash Button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFlashOn = !_isFlashOn;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _isFlashOn
                                        ? const Color(0xFF75F2FE).withValues(alpha: 0.25)
                                        : Colors.white.withValues(alpha: 0.10),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _isFlashOn
                                          ? const Color(0xFF75F2FE)
                                          : Colors.white.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                                      color: _isFlashOn ? const Color(0xFF75F2FE) : Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Flash',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFCBC4D4),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Circular Capture Shutter Button (Figma node 20:32295)
                          GestureDetector(
                            key: const Key('scan_report_shutter_button'),
                            onTap: _onCapture,
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Gallery Pick Button (Figma node 20:32300)
                          GestureDetector(
                            key: const Key('scan_report_gallery_button'),
                            onTap: _onGallery,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.10),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.25),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.photo_library_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Gallery',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFCBC4D4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Branding Indicator: SECURE OCR PROCESSING
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF75F2FE),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'SECURE OCR PROCESSING',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: Colors.white.withValues(alpha: 0.70),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Fixed Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
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
                    color: const Color(0xFFF8F9FF).withValues(alpha: 0.85),
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
                      // Left: Back button + Title
                      Row(
                        children: [
                          GestureDetector(
                            key: const Key('scan_report_back_button'),
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
                            'Scan Report',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF28006D),
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

                      // Right: Close Button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F5FF),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE7ECF6)),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: Color(0xFF28006D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

