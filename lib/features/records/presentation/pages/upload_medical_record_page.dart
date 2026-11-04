import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:care_id_patient_app/core/routing/app_routes.dart';
import 'package:care_id_patient_app/core/widgets/care_id_bottom_nav_bar.dart';

/// Upload Medical Record - Refined Flow (Figma node 20:21451)
class UploadMedicalRecordPage extends StatefulWidget {
  const UploadMedicalRecordPage({super.key});

  @override
  State<UploadMedicalRecordPage> createState() => _UploadMedicalRecordPageState();
}

class _UploadMedicalRecordPageState extends State<UploadMedicalRecordPage> {
  // Selected category index: 0 = Medical, 1 = Dental, 2 = Vision, 3 = Pet
  int _selectedCategoryIndex = 0;

  // Selected subcategories by category index
  final Map<int, String> _selectedSubcategories = {
    0: 'Lab Report',
    1: 'Dental X-Ray',
    2: 'Retinal Scan',
    3: 'Vaccination',
  };

  // Selected document source: 0 = Scan Camera, 1 = Gallery, 2 = PDF / DICOM
  int _selectedDocumentSource = 0;

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Medical Record',
      'description': 'Consultation notes, prescriptions, and lab tests',
      'icon': Icons.medical_services_outlined,
      'themeColor': const Color(0xFF28006D),
      'iconBg': const Color(0xFFDCE9FF),
      'subcategories': ['Lab Report', 'Prescription', 'Clinical Note'],
    },
    {
      'title': 'Dental Record',
      'description': 'Dental radiographs, routine exams, and scaling',
      'icon': Icons.cleaning_services_outlined,
      'themeColor': const Color(0xFF00696B),
      'iconBg': const Color(0xFF56F5F8),
      'subcategories': ['Dental X-Ray', 'Dental Report', 'Treatment Record'],
    },
    {
      'title': 'Vision Record',
      'description': 'Eye examinations, retinal scans, and optical prescriptions',
      'icon': Icons.remove_red_eye_outlined,
      'themeColor': const Color(0xFF28006D),
      'iconBg': const Color(0xFFDCE9FF),
      'subcategories': ['Retinal Scan', 'Optometry Report', 'Glasses Rx', 'Visual Acuity'],
    },
    {
      'title': 'Pet Record',
      'description': 'Veterinary examinations, vaccination tags, and prescriptions',
      'icon': Icons.pets_rounded,
      'themeColor': const Color(0xFF00696B),
      'iconBg': const Color(0xFFDCE9FF),
      'subcategories': ['Vaccination', 'Vet Visit', 'Lab Test'],
    },
  ];

  void _proceedToScanOrOcr() {
    if (_selectedDocumentSource == 0) {
      // Camera Scan flow
      Navigator.of(context).pushNamed(AppRoutes.scanReports);
    } else {
      // Gallery or PDF direct to OCR processing
      Navigator.of(context).pushNamed(AppRoutes.ocrProcessingReport);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _categories[_selectedCategoryIndex];

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
                  // Page Heading & Subtitle (Figma node 20:21453)
                  Text(
                    'Upload Health Record',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.5,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Choose how you'd like to import your medical records into your secure vault.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      height: 1.45,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Instruction Banner Card (Figma node 20:21460)
                  _buildInstructionBanner(),

                  const SizedBox(height: 20),

                  // Category Selection Section (Figma node 20:21471)
                  Text(
                    'RECORD CATEGORY',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(_categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _buildCategoryCard(index),
                    );
                  }),

                  const SizedBox(height: 16),

                  // Document Source Selection (Figma node 20:21582)
                  _buildDocumentSourceSection(),

                  const SizedBox(height: 20),

                  // Target Vault Preview Card (Figma node 20:21611)
                  _buildTargetVaultCard(selectedCategory['title'] as String),

                  const SizedBox(height: 24),

                  // Bottom Action CTA (Figma node 20:21621)
                  GestureDetector(
                    key: const Key('upload_continue_to_ocr_button'),
                    onTap: _proceedToScanOrOcr,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
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
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x335B14B8),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.document_scanner_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Continue to AI OCR & Upload',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.35,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // HIPAA & Encryption Disclaimer (Figma node 20:21630)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_rounded,
                        size: 13,
                        color: Color(0xFF494552),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '256-Bit Encrypted Healthcare Vault • HIPAA Compliant',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Fixed Frosted Top App Bar (Figma node 20:21635)
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

  /// Top App Bar (Figma node 20:21635)
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
              // Left: Back button + Title + Badge
              Row(
                children: [
                  GestureDetector(
                    key: const Key('upload_record_back_button'),
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.healthRecordsLanding);
                      }
                    },
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
                    'Upload Record',
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

  /// Instruction Banner Card (Figma node 20:21460)
  Widget _buildInstructionBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE8DDFF),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.folder_open_rounded,
                color: Color(0xFF28006D),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Record Category',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose classification so Care ID can securely index, encrypt, and extract relevant clinical fields with high accuracy.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Category Card (Figma nodes 20:21473, 20:21497, 20:21523, 20:21550)
  Widget _buildCategoryCard(int index) {
    final category = _categories[index];
    final isSelected = _selectedCategoryIndex == index;
    final subcategories = category['subcategories'] as List<String>;
    final selectedSub = _selectedSubcategories[index] ?? subcategories.first;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF4FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF28006D) : const Color(0xFFE7ECF6),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? const Color(0x1A28006D) : const Color(0x0D000000),
              blurRadius: isSelected ? 8 : 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Icon + Title/Description + Selection Radio
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: category['iconBg'] as Color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      category['icon'] as IconData,
                      color: category['themeColor'] as Color,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['title'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        category['description'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFF28006D) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF28006D) : const Color(0xFFCBC4D4),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Subcategory Pills Row
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: subcategories.map((sub) {
                final isSubSelected = isSelected && selectedSub == sub;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                      _selectedSubcategories[index] = sub;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSubSelected
                          ? const Color(0xFF28006D)
                          : (isSelected ? Colors.white : const Color(0xFFEFF4FF)),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: isSubSelected ? const Color(0xFF28006D) : const Color(0xFFE7ECF6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSubSelected ? const Color(0xFF56F5F8) : const Color(0xFF7A7583),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          sub,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: isSubSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSubSelected ? Colors.white : const Color(0xFF494552),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Document Source Selection Section (Figma node 20:21582)
  Widget _buildDocumentSourceSection() {
    final sources = [
      {
        'title': 'Scan Camera',
        'icon': Icons.camera_alt_outlined,
      },
      {
        'title': 'Gallery',
        'icon': Icons.photo_library_outlined,
      },
      {
        'title': 'PDF / DICOM',
        'icon': Icons.picture_as_pdf_outlined,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Document Source',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF56F5F8).withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Auto-Enhance Active',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00696B),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(sources.length, (i) {
            final source = sources[i];
            final isSelected = _selectedDocumentSource == i;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDocumentSource = i;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(
                    left: i == 0 ? 0 : 5,
                    right: i == sources.length - 1 ? 0 : 5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE5EEFF) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF28006D) : const Color(0xFFE7ECF6),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE8DDFF) : const Color(0xFFEFF4FF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            source['icon'] as IconData,
                            color: const Color(0xFF28006D),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        source['title'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected ? const Color(0xFF28006D) : const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Target Vault Preview Card (Figma node 20:21611)
  Widget _buildTargetVaultCard(String targetName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7ECF6)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF56F5F8),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.verified_user_rounded,
                color: Color(0xFF00696B),
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Target: $targetName',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  'Clinical tags will map directly to encrypted vault',
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
    );
  }
}

