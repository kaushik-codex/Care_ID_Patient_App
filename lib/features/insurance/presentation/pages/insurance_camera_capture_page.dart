import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../widgets/insurance_assets.dart';

/// Screen 3: Insurance Card - Camera Capture (`20:20258`)
class InsuranceCameraCapturePage extends StatefulWidget {
  const InsuranceCameraCapturePage({super.key});

  @override
  State<InsuranceCameraCapturePage> createState() => _InsuranceCameraCapturePageState();
}

class _InsuranceCameraCapturePageState extends State<InsuranceCameraCapturePage>
    with SingleTickerProviderStateMixin {
  bool _isFlashOn = false;
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  void _onCapture() {
    Navigator.of(context).pushNamed(AppRoutes.insuranceOcrProcessing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Viewport & Placeholder
            Positioned.fill(
              child: Image.asset(
                InsuranceAssets.cameraPlaceholder,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF0F172A),
                  child: const Center(
                    child: Icon(
                      Icons.camera,
                      color: Colors.white24,
                      size: 96,
                    ),
                  ),
                ),
              ),
            ),

            // Top Gradient & Bottom Gradient Overlays
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF0B1C30).withOpacity(0.6),
                      Colors.transparent,
                      Colors.transparent,
                      const Color(0xFF0B1C30).withOpacity(0.85),
                    ],
                    stops: const [0.0, 0.25, 0.75, 1.0],
                  ),
                ),
              ),
            ),

            // Card Frame Guide & Scan Laser
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.586,
                      child: Stack(
                        children: [
                          // Card Border
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF75F2FE).withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x66000000),
                                  blurRadius: 40,
                                ),
                              ],
                            ),
                          ),

                          // Animated Scan Line
                          AnimatedBuilder(
                            animation: _scanAnimation,
                            builder: (context, child) {
                              return Align(
                                alignment: Alignment(0, (_scanAnimation.value * 2) - 1),
                                child: Container(
                                  height: 2.5,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF75F2FE),
                                        Color(0xFF75F2FE),
                                        Colors.transparent,
                                      ],
                                      stops: [0.0, 0.3, 0.7, 1.0],
                                    ),
                                    boxShadow: [
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

                          // 4 Corner Guides
                          // Top-Left
                          Positioned(
                            top: -2,
                            left: -2,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFF006971), width: 4.5),
                                  left: BorderSide(color: Color(0xFF006971), width: 4.5),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          // Top-Right
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFF006971), width: 4.5),
                                  right: BorderSide(color: Color(0xFF006971), width: 4.5),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          // Bottom-Left
                          Positioned(
                            bottom: -2,
                            left: -2,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF006971), width: 4.5),
                                  left: BorderSide(color: Color(0xFF006971), width: 4.5),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),
                          // Bottom-Right
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xFF006971), width: 4.5),
                                  right: BorderSide(color: Color(0xFF006971), width: 4.5),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(14),
                                ),
                              ),
                            ),
                          ),

                          // Center Focus Icon
                          Center(
                            child: Opacity(
                              opacity: 0.35,
                              child: SvgPicture.asset(
                                InsuranceAssets.cameraShutterCenter,
                                width: 45,
                                height: 45,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.crop_free,
                                  color: Colors.white,
                                  size: 44,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Floating tip pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            InsuranceAssets.cameraTipInfo,
                            width: 18,
                            height: 18,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.lightbulb_outline,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Align card within the frame',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: const Color(0xFFF8F9FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                InsuranceAssets.backArrow,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Scan Card',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          InsuranceAssets.careIdLogo4,
                          width: 25,
                          height: 18,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.help_outline,
                          color: Color(0xFF494552),
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Controls Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 36),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1C30).withOpacity(0.65),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flash Toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFlashOn = !_isFlashOn;
                            });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _isFlashOn
                                      ? const Color(0xFF58D8E4).withOpacity(0.3)
                                      : Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    InsuranceAssets.cameraFlash,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      _isFlashOn ? const Color(0xFF58D8E4) : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                    errorBuilder: (_, __, ___) => Icon(
                                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Flash',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: const Color(0xFFCBC4D4),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Shutter Button
                        GestureDetector(
                          onTap: _onCapture,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),

                        // Gallery / Library Button
                        GestureDetector(
                          onTap: _onCapture,
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    InsuranceAssets.cameraGallery,
                                    width: 20,
                                    height: 20,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.photo_library,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Gallery',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: const Color(0xFFCBC4D4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                            letterSpacing: 1.6,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
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
}

