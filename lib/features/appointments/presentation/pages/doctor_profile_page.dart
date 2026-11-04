import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 49: Doctor Profile Page
/// Node ID: 20:28961
class DoctorProfilePage extends StatefulWidget {
  final Doctor? doctor;

  const DoctorProfilePage({super.key, this.doctor});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Doctor _doctor;
  bool _isSaved = false;
  int _userRating = 5;

  @override
  void initState() {
    super.initState();
    _doctor = widget.doctor ?? MockAppointmentsRepository.instance.getDoctors().firstWhere(
          (d) => d.id == 'doc-2' || d.name.contains('Sarah Jenkins'),
          orElse: () => MockAppointmentsRepository.instance.getDoctors().first,
        );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Doctor) {
      _doctor = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF8F9FF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.only(
                top: 64,
                left: 16,
                right: 16,
                bottom: 180, // Space for bottom persistent CTA panel + nav bar
              ),
              children: [
                const SizedBox(height: 8),

                // Top Action Breadcrumb Sub-bar
                _buildTopActionBreadcrumb(),
                const SizedBox(height: 16),

                // Doctor Header Card with Care ID Watermark Glass Frame
                _buildDoctorHeaderCard(),
                const SizedBox(height: 16),

                // Associated Patient Connection Context (Personalized History)
                _buildPatientConnectionContext(),
                const SizedBox(height: 16),

                // Clinical Specializations & Practice Highlights
                _buildClinicalSpecializations(),
                const SizedBox(height: 16),

                // Practice Facility Gallery Showcase
                _buildPracticeFacilityGallery(),
                const SizedBox(height: 16),

                // Verified Care ID Security Assurance Note
                _buildSecurityAssuranceNote(),
                const SizedBox(height: 16),

                // Rate this Doctor Card
                _buildRateThisDoctorCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Top AppBar (CareID logo, Back, Notification bell)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // Persistent Bottom Floating Action Panel & Bottom Nav Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPersistentBottomPanel(),
                const CareIDBottomNavBar(currentIndex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Node 20:28995)
  Widget _buildTopAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button + Title + Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.doctors);
                      }
                    },
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFCBC4D4).withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Color(0xFF28006D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Doctor Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/card_id_badge.png',
                    height: 20,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ],
              ),

              // Notification Bell Button
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCBC4D4).withOpacity(0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 20,
                    color: Color(0xFF28006D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Top Action Breadcrumb Sub-bar (Node 20:29016)
  Widget _buildTopActionBreadcrumb() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed(AppRoutes.doctors);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_ios_new,
                  size: 14,
                  color: Color(0xFF494552),
                ),
                const SizedBox(width: 6),
                Text(
                  'Back to Doctors',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bookmark / Favorite Button
        InkWell(
          onTap: () {
            setState(() {
              _isSaved = !_isSaved;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isSaved
                      ? 'Doctor added to favorites.'
                      : 'Doctor removed from favorites.',
                  style: GoogleFonts.plusJakartaSans(),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: const Color(0xFF28006D),
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  /// Doctor Header Card with Care ID Watermark Glass Frame (Node 20:29025)
  Widget _buildDoctorHeaderCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // CareID Watermark Accent in Top-Right
          Positioned(
            top: -24,
            right: -24,
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/home_card_watermark.png',
                width: 140,
                height: 140,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) => const SizedBox(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Avatar + Title Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Portrait with Verified Ring (Node 20:29030)
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCE9FF),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/d2cf11cdc73d53107f6f7ca91cb50e80129d6109.png',
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Image.asset(
                                _doctor.avatarAsset,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  color: const Color(0xFFDCE9FF),
                                  child: const Icon(
                                    Icons.person,
                                    size: 44,
                                    color: Color(0xFF28006D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Verified Badge at bottom right of avatar
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF28006D),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Credentials & Title (Node 20:29036)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CARE ID VERIFIED Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF56F5F8).withOpacity(0.25),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.shield_outlined,
                                  size: 11,
                                  color: Color(0xFF006E70),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'CARE ID VERIFIED',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF006E70),
                                    letterSpacing: -0.275,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Doctor Name
                          Text(
                            _doctor.name.isNotEmpty
                                ? _doctor.name
                                : 'Dr. Sarah Jenkins',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0B1C30),
                              letterSpacing: -0.6,
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Degree & Specialty
                          Text(
                            _doctor.specialty.isNotEmpty
                                ? 'MD, FACC • ${_doctor.specialty}'
                                : 'MD, FACC • Cardiology',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF28006D),
                            ),
                          ),

                          // Subtitle / Specialty detail
                          Text(
                            'Internal Medicine Specialist',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Practice Location & License Band (Node 20:29050)
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFF28006D),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Mount Sinai Hospital • Heart Center, Suite 400',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.badge_outlined,
                      size: 15,
                      color: Color(0xFF494552),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Lic. #MD-90412 • Encrypted Partner Facility',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Vault Connected Status Pill (Node 20:29061)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00696B),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Connected to Your Care ID Vault',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 16,
                        color: Color(0xFF00696B),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Associated Patient Connection Context (Personalized History) (Node 20:29068)
  Widget _buildPatientConnectionContext() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.people_alt_outlined,
                    size: 16,
                    color: Color(0xFF28006D),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Your Patient Relationship',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Text(
                'CARE ID #8472-9901',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 2 Bento Cards Row
          Row(
            children: [
              // Card 1: Last Consultation
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Consultation',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF494552),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Aug 15, 2023',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Annual Checkup',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF00696B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Card 2: Synced Records
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Synced Records',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF494552),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '5 Care Documents',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '3 Notes • 2 Lab Reports',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF28006D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Clinical Specializations & Practice Highlights (Node 20:29094)
  Widget _buildClinicalSpecializations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Clinical Specializations & Practice',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Primary Clinical Focus Tag Cloud
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.medical_services_outlined,
                    size: 16,
                    color: Color(0xFF28006D),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Primary Clinical Focus',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTagPill('Preventive Cardiology'),
                  _buildTagPill('Lipid Disorders'),
                  _buildTagPill('Hypertension Management'),
                  _buildTagPill('Cardiovascular Screening'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Facility & Languages Detail Bento Stack
        _buildBentoDetailTile(
          icon: Icons.local_hospital_outlined,
          title: 'Hospital Affiliation',
          body: 'Mount Sinai Medical Center (Department of Cardiovascular Health)',
          sub: 'Attending Physician • 12 Years Active',
          subColor: const Color(0xFF00696B),
        ),
        const SizedBox(height: 12),
        _buildBentoDetailTile(
          icon: Icons.translate_rounded,
          title: 'Spoken Languages',
          body: 'English, Spanish (Bilingual Consultations Supported)',
          sub: 'Medical translation services on request',
          subColor: const Color(0xFF494552),
        ),
        const SizedBox(height: 12),
        _buildBentoDetailTile(
          icon: Icons.verified_user_outlined,
          title: 'Coverage & Network Status',
          body: 'Care ID Tier-1 Verified Partner',
          sub: 'In-Network Direct Electronic Verification',
          subColor: const Color(0xFF00696B),
          hasDot: true,
        ),
      ],
    );
  }

  Widget _buildTagPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EEFF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF0B1C30),
        ),
      ),
    );
  }

  Widget _buildBentoDetailTile({
    required IconData icon,
    required String title,
    required String body,
    required String sub,
    required Color subColor,
    bool hasDot = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
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
              color: Color(0xFFDCE9FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF28006D),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF494552),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (hasDot) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: subColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        sub,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight:
                              hasDot ? FontWeight.bold : FontWeight.w500,
                          color: subColor,
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
    );
  }

  /// Practice Facility Gallery Showcase (Node 20:29154)
  Widget _buildPracticeFacilityGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Practice Facility',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Text(
                'Mount Sinai Heart Center',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Gallery 2 Images Row
        Row(
          children: [
            // Image 1: Suite 400 Reception
            Expanded(
              child: Container(
                height: 112,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/234d680e4e5b9440a2ffdfdcb95d4adbf2d669fa.png',
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: const Color(0xFFE5EEFF),
                        child: const Icon(Icons.apartment_rounded, color: Color(0xFF28006D)),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Suite 400 Reception',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Image 2: Diagnostic Lab
            Expanded(
              child: Container(
                height: 112,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/42c90d1d80fbf8098424047c3423d078576d1024.png',
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: const Color(0xFFE5EEFF),
                        child: const Icon(Icons.biotech_rounded, color: Color(0xFF28006D)),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Diagnostic Lab',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Verified Care ID Security Assurance Note (Node 20:29169)
  Widget _buildSecurityAssuranceNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EEFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 20,
            color: Color(0xFF28006D),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  height: 1.4,
                  color: const Color(0xFF0B1C30),
                ),
                children: const [
                  TextSpan(
                    text: 'Care ID Trust Standard: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF28006D),
                    ),
                  ),
                  TextSpan(
                    text:
                        'Medical history is only released when you authorize an in-person or scheduled consultation check-in.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Rate this Doctor Card (Node 20:29174)
  Widget _buildRateThisDoctorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate this doctor',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Text(
                'Your rating',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'How was your visit? Choose a rating to share your experience.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),

          // 5 Stars Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              final starNum = index + 1;
              final isFilled = starNum <= _userRating;
              return InkWell(
                onTap: () {
                  setState(() {
                    _userRating = starNum;
                  });
                },
                borderRadius: BorderRadius.circular(9999),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 38,
                    color: isFilled ? const Color(0xFFF59E0B) : const Color(0xFFCBC4D4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            '1 = Poor · 5 = Excellent',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF00696B),
            ),
          ),
        ],
      ),
    );
  }

  /// Persistent Bottom Floating Action Panel (Node 20:29192)
  Widget _buildPersistentBottomPanel() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FF).withOpacity(0.95),
            border: Border(
              top: BorderSide(
                color: const Color(0xFFCBC4D4).withOpacity(0.3),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primary Action CTA: Book an Appointment
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.bookAppointmentType,
                    arguments: _doctor,
                  );
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  width: double.infinity,
                  height: 48,
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
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF28006D).withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Book an Appointment',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Secondary Actions CTA Row
              Row(
                children: [
                  // View Shared Records (5) Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.medicalRecords);
                      },
                      borderRadius: BorderRadius.circular(9999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              size: 15,
                              color: Color(0xFF28006D),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'View Shared Records (5)',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF28006D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Directory Button
                  InkWell(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.doctors);
                      }
                    },
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'Directory',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF494552),
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
}
