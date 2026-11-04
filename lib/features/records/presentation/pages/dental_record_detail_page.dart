import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 28: Dental Record Detail
/// Figma node: 20:25653 (Framed as "Care ID - Dental Record Detail")
/// Canvas: Careid patient app (x: 12814, y: 0, width: 390, height: 862)
///
/// Features:
/// - Fixed Frosted Top App Bar ("Record Details", CareID logo, profile avatar)
/// - End-to-End Encrypted Verification Strip (ID: #VIS-512-094)
/// - Hero Panoramic X-Ray Document Card (high-res image preview, fullscreen expander, OCT export badge)
/// - 4 Quick Action Buttons (Share Record, Download PDF, Print, Favorite)
/// - Attending Provider Section (Dr. Michael Vance, DDS, Dental Care Specialists, Suite 210)
/// - Clinical Details Section (Record Type, Service Date, Patient Sarah Jenkins, Diagnosis)
/// - Attachments Section (Dental X-Ray Observations.pdf, Dental X-Ray.jpg)
/// - Doctor's Observations card
/// - Docked unified CareID Bottom Navigation Bar
class DentalRecordDetailPage extends StatefulWidget {
  const DentalRecordDetailPage({super.key});

  @override
  State<DentalRecordDetailPage> createState() => _DentalRecordDetailPageState();
}

class _DentalRecordDetailPageState extends State<DentalRecordDetailPage> {
  bool _isFavorite = false;

  void _openDocument(String title) {
    Navigator.of(context).pushNamed(
      AppRoutes.documentViewer,
      arguments: title,
    );
  }

  void _showActionFeedback(String action) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          action,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF28006D),
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
          // Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 72,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Panoramic X-Ray Document Card (Figma node 20:25667)
                  _buildHeroImageCard(),

                  const SizedBox(height: 16),

                  // 4 Quick Actions Grid (Figma node 20:25697)
                  _buildQuickActionsGrid(),

                  const SizedBox(height: 16),

                  // Attending Provider Section (Figma node 20:25723)
                  _buildProviderSection(),

                  const SizedBox(height: 16),

                  // Clinical Details Section (Figma node 20:25755)
                  _buildClinicalDetailsSection(),

                  const SizedBox(height: 16),

                  // Attachments Section (Figma node 20:25796)
                  _buildAttachmentsSection(),

                  const SizedBox(height: 16),

                  // Patient Notes Card: Doctor's Observations (Figma node 20:25833)
                  _buildDoctorObservationsCard(),

                  const SizedBox(height: 16),

                  // Security & Verified Verification Strip (Figma node 20:25658)
                  _buildSecurityStrip(),
                ],
              ),
            ),
          ),

          // Fixed Frosted Top App Bar (Figma node 20:25884)
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

  /// Top App Bar (Figma node 20:25884)
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
              // Left: Back button + Title
              Row(
                children: [
                  GestureDetector(
                    key: const Key('dental_record_detail_back_button'),
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
                    'Record Details',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Right: Wordmark + Profile Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/care_id_logo_wordmark.png',
                    width: 25,
                    height: 17,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF3F1D8B),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Security Verification Strip (Figma node 20:25658)
  Widget _buildSecurityStrip() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lock_rounded,
                size: 15,
                color: Color(0xFF00696B),
              ),
              const SizedBox(width: 8),
              Text(
                'End-to-End Encrypted Health Record',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00696B),
                ),
              ),
            ],
          ),
          Text(
            'ID: #VIS-512-094',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF494552),
            ),
          ),
        ],
      ),
    );
  }

  /// Hero Panoramic X-Ray Document Card (Figma node 20:25667)
  Widget _buildHeroImageCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7ECF6),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Preview Container with Overlays
            Container(
              height: 224,
              width: double.infinity,
              color: const Color(0xFF213145),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/dental_panoramic_xray.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
                    ),
                  ),

                  // Dark gradient scrim
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF213145).withValues(alpha: 0.4),
                          Colors.transparent,
                          const Color(0xFF213145).withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),

                  // Top-Left: PDF Report pill
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF213145).withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.description_outlined, color: Color(0xFFEAF1FF), size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'PDF Report • 2.4 MB',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFEAF1FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top-Right: Fullscreen Expander
                  Positioned(
                    right: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () => _openDocument('Dental Panoramic X-Ray.pdf'),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF213145).withValues(alpha: 0.70),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(Icons.fullscreen_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),

                  // Bottom Bar: High-Res OCT Export & P-78102
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF5AF8FB),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'HIGH-RES OCT EXPORT',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFCBDBF5),
                                letterSpacing: 0.35,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF213145).withValues(alpha: 0.60),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'P-78102',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF8F9FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Card Metadata Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dental X-Ray',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF28006D),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF56F5F8),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified_rounded, size: 13, color: Color(0xFF006E70)),
                            const SizedBox(width: 4),
                            Text(
                              'Care ID',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF006E70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last accessed: Oct 18, 2023 • 11:20 AM',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
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

  /// 4 Quick Action Buttons Grid (Figma node 20:25697)
  Widget _buildQuickActionsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.share_outlined,
                label: 'Share Record',
                onTap: () => _showActionFeedback('Encrypted share link copied to clipboard'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildActionButton(
                icon: Icons.file_download_outlined,
                label: 'Download PDF',
                onTap: () => _openDocument('Dental Panoramic X-Ray.pdf'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.print_outlined,
                label: 'Print',
                onTap: () => _showActionFeedback('Sending file to default printer...'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildActionButton(
                icon: _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                iconColor: _isFavorite ? Colors.red : const Color(0xFF28006D),
                label: _isFavorite ? 'Favorited' : 'Favorite',
                onTap: () {
                  setState(() => _isFavorite = !_isFavorite);
                  _showActionFeedback(_isFavorite ? 'Added to favorites' : 'Removed from favorites');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF28006D),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFD3E4FE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: iconColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
                letterSpacing: 0.28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Attending Provider Section (Figma node 20:25723)
  Widget _buildProviderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7ECF6),
          width: 1,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Stethoscope + Attending Provider
          Row(
            children: [
              const Icon(Icons.medical_services_outlined, color: Color(0xFF28006D), size: 20),
              const SizedBox(width: 8),
              Text(
                'Attending Provider',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // License Tag
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Lic. #OD- 7721',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Doctor Info Row
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF3F1D8B),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'MV',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFAB8EFD),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Dr. Michael Vance',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF00696B)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Dental Care Specialists',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                    Text(
                      'Dentist & Orthodontist',
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

          const SizedBox(height: 14),

          // Facility & Clinic Info bottom strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF28006D)),
                    const SizedBox(width: 6),
                    Text(
                      'Suite 210, Metro Eye Pavilion',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showActionFeedback('Clinic Info: Open Mon-Fri 8am-6pm • Tel: (555) 234-8901'),
                  child: Text(
                    'Clinic Info',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Clinical Details Section (Figma node 20:25755)
  Widget _buildClinicalDetailsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7ECF6),
          width: 1,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.assignment_outlined, color: Color(0xFF28006D), size: 20),
              const SizedBox(width: 8),
              Text(
                'Clinical Details',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _buildDetailRow('Record Type', 'Dental Record'),
          const Divider(height: 18, color: Color(0xFFF2F5FF)),
          _buildDetailRow('Service Date', 'Oct 04, 2023'),
          const Divider(height: 18, color: Color(0xFFF2F5FF)),
          _buildDetailRow('Patient Name', 'Sarah Jenkins\nCID-8472-9901', isMultiLine: true),

          const SizedBox(height: 12),

          // Primary Diagnosis Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Primary Diagnosis / Reason',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7A7583),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Routine Dental Examination',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Security Audit Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Security Audit',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF494552),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00696B),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'Care ID Authenticated',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  Widget _buildDetailRow(String label, String value, {bool isMultiLine = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }

  /// Attachments Section (Figma node 20:25796)
  Widget _buildAttachmentsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7ECF6),
          width: 1,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.attach_file_rounded, color: Color(0xFF28006D), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Attachments (2)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Text(
                'Total 4.5 MB',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A7583),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Attachment 1: PDF
          _buildAttachmentItem(
            icon: Icons.picture_as_pdf_rounded,
            iconBg: const Color(0xFFFFDAD6),
            iconColor: const Color(0xFFBA1A1A),
            fileName: 'Dental X-Ray Observations.pdf',
            fileMeta: '3.1 MB • Official Diagnostic Document',
            onTap: () => _openDocument('Dental X-Ray Observations.pdf'),
          ),

          const SizedBox(height: 10),

          // Attachment 2: JPG Image
          _buildAttachmentItem(
            icon: Icons.image_rounded,
            iconBg: const Color(0xFF3F1D8B),
            iconColor: Colors.white,
            fileName: 'Dental X-Ray.jpg',
            fileMeta: '1.4 MB • High Resolution Scan',
            onTap: () => _openDocument('Dental X-Ray.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String fileName,
    required String fileMeta,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF4FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fileMeta,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_downward_rounded,
                  size: 16,
                  color: Color(0xFF28006D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Patient Notes Card: Doctor's Observations (Figma node 20:25833)
  Widget _buildDoctorObservationsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE7ECF6),
          width: 1,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.comment_outlined, color: Color(0xFF28006D), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "Doctor's Observations",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.bookmark_border_rounded, color: Color(0xFF7A7583), size: 18),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '"Routine panoramic X-ray taken for annual check-up. No significant abnormalities noted in the jaw structure or tooth alignment. Patient advised to continue regular flossing."',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF494552),
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF7A7583)),
              const SizedBox(width: 6),
              Text(
                'Last updated: Oct 05, 2023',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A7583),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

