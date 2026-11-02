import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 31: Document Viewer
/// Figma node: 20:32097
/// Canvas: Careid patient app (x: 14104, y: 0, width: 390, height: 862)
///
/// Features:
/// - Fixed Frosted Top App Bar (Document title, back chevron, "Done" button)
/// - Floating Zoom & Orientation Controls Bar (Zoom In, Zoom Out, 100% scale indicator, Rotate 90°, Fullscreen toggle)
/// - Interactive pan/zoom Document Canvas with TransformationController
/// - Care ID Verified Security Protocol bottom floating pill
/// - Floating Action Button for Downloading/Exporting Document
/// - Docked unified CareID Bottom Navigation Bar
class DocumentViewerPage extends StatefulWidget {
  final String? documentTitle;

  const DocumentViewerPage({
    super.key,
    this.documentTitle,
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;
  int _rotationQuarterTurns = 0;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(_onTransformationChanged);
  }

  void _onTransformationChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (mounted && (scale - _currentScale).abs() > 0.05) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final newScale = (_currentScale * 1.25).clamp(0.5, 4.0);
    _setScale(newScale);
  }

  void _zoomOut() {
    final newScale = (_currentScale / 1.25).clamp(0.5, 4.0);
    _setScale(newScale);
  }

  void _resetZoom() {
    _setScale(1.0);
  }

  void _setScale(double targetScale) {
    setState(() {
      _currentScale = targetScale;
      _transformationController.value = Matrix4.diagonal3Values(targetScale, targetScale, 1.0);
    });
  }

  void _rotateDocument() {
    setState(() {
      _rotationQuarterTurns = (_rotationQuarterTurns + 1) % 4;
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
  }

  void _downloadDocument(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download_done_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Downloading $title to device storage...',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF006971),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final title = widget.documentTitle ??
        (routeArgs is String ? routeArgs : 'Dental X-Ray Observations.pdf');

    final bool isRetinal = title.toLowerCase().contains('retinal') ||
        title.toLowerCase().contains('oct') ||
        title.toLowerCase().contains('fundus');

    final String imageAsset = isRetinal
        ? 'assets/images/retinal_oct_scan.png'
        : 'assets/images/dental_panoramic_xray.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Interactive Document Canvas
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: _isFullscreen ? 0 : 136,
                bottom: _isFullscreen ? 0 : 20,
              ),
              child: Center(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: RotatedBox(
                    quarterTurns: _rotationQuarterTurns,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF213145),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F000000),
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imageAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 280,
                            color: const Color(0xFF213145),
                            child: const Center(
                              child: Icon(Icons.picture_as_pdf_rounded, color: Colors.white70, size: 64),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Care ID Security Protocol Overlay Badge (Figma node 20:32102)
          if (!_isFullscreen)
            Positioned(
              left: 16,
              right: 16,
              bottom: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF).withValues(alpha: 0.90),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.50),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF28006D),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: Color(0xFF56F5F8),
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0B1C30),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Verified by Care ID Security Protocol • May 14, 2024',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF494552),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Floating Download FAB (Figma node 20:32112)
          Positioned(
            right: 20,
            bottom: 24,
            child: GestureDetector(
              key: const Key('document_viewer_download_fab'),
              onTap: () => _downloadDocument(title),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA44CFF),
                      Color(0xFF5B14B8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x335B14B8),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.file_download_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),

          // Floating Viewer Controls Bar (Figma node 20:32116)
          if (!_isFullscreen)
            Positioned(
              top: 72 + MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
              child: _buildControlsBar(),
            ),

          // Top Header App Bar (Figma node 20:32136)
          if (!_isFullscreen)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildTopAppBar(title),
            ),
        ],
      ),

      // Docked unified Bottom Navigation Bar (Tab 1: Records active)
      bottomNavigationBar: _isFullscreen
          ? null
          : const CareIDBottomNavBar(
              currentIndex: 1,
            ),
    );
  }

  /// Top App Bar (Figma node 20:32136)
  Widget _buildTopAppBar(String title) {
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
            color: Colors.white.withValues(alpha: 0.92),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFFE5E7EB),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Back button + Document title
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      key: const Key('document_viewer_back_button'),
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
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right: Done button
              GestureDetector(
                key: const Key('document_viewer_done_button'),
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE7ECF6)),
                  ),
                  child: Text(
                    'Done',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
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

  /// Floating Controls Bar (Figma node 20:32116)
  Widget _buildControlsBar() {
    final scalePercent = (_currentScale * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Zoom Out
          IconButton(
            onPressed: _zoomOut,
            icon: const Icon(Icons.remove_rounded, color: Color(0xFF0B1C30), size: 20),
            visualDensity: VisualDensity.compact,
            tooltip: 'Zoom Out',
          ),

          _buildVerticalDivider(),

          // Scale Percentage Indicator / Reset
          GestureDetector(
            onTap: _resetZoom,
            child: Container(
              constraints: const BoxConstraints(minWidth: 48),
              child: Text(
                '$scalePercent%',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ),
          ),

          _buildVerticalDivider(),

          // Zoom In
          IconButton(
            onPressed: _zoomIn,
            icon: const Icon(Icons.add_rounded, color: Color(0xFF0B1C30), size: 20),
            visualDensity: VisualDensity.compact,
            tooltip: 'Zoom In',
          ),

          _buildVerticalDivider(),

          // Rotate
          IconButton(
            onPressed: _rotateDocument,
            icon: const Icon(Icons.rotate_right_rounded, color: Color(0xFF0B1C30), size: 20),
            visualDensity: VisualDensity.compact,
            tooltip: 'Rotate 90°',
          ),

          _buildVerticalDivider(),

          // Fullscreen Toggle
          IconButton(
            onPressed: _toggleFullscreen,
            icon: Icon(
              _isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
              color: const Color(0xFF0B1C30),
              size: 20,
            ),
            visualDensity: VisualDensity.compact,
            tooltip: 'Toggle Fullscreen',
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 20,
      color: const Color(0xFFE5E7EB),
    );
  }
}

