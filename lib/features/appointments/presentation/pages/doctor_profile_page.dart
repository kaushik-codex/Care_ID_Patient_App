import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 2: Doctor Profile Page (`20:28961`)
class DoctorProfilePage extends StatefulWidget {
  final Doctor? doctor;

  const DoctorProfilePage({super.key, this.doctor});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Doctor _doctor;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _doctor = widget.doctor ?? MockAppointmentsRepository.instance.getDoctors()[1];
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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            _buildAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      // Breadcrumb row
                      _buildBreadcrumbRow(),
                      const SizedBox(height: 16),

                      // Doctor Header Card
                      _buildDoctorHeaderCard(),
                      const SizedBox(height: 16),

                      // Quick Stats Row
                      _buildQuickStatsRow(),
                      const SizedBox(height: 16),

                      // Direct Connect Action Row
                      _buildDirectActionsRow(),
                      const SizedBox(height: 16),

                      // About Section
                      _buildAboutSection(),
                      const SizedBox(height: 16),

                      // Hospital Affiliation & Directions
                      _buildHospitalCard(),
                      const SizedBox(height: 16),

                      // Accepted Insurance List
                      _buildInsuranceCard(),
                      const SizedBox(height: 16),

                      // Patient Reviews Card
                      _buildReviewsCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomActionPanel(),
          const CareIDBottomNavBar(currentIndex: 2),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE5EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF28006D)),
              ),
            ),
          ),
          Image.asset(
            'assets/images/care_id_logo_wordmark.png',
            height: 18,
            fit: BoxFit.contain,
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Clinician profile link copied to clipboard.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xFF28006D),
                ),
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE5EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.share_outlined, size: 18, color: Color(0xFF28006D)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: [
              const Icon(Icons.chevron_left, size: 20, color: Color(0xFF494552)),
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
        GestureDetector(
          onTap: () {
            setState(() {
              _isSaved = !_isSaved;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isSaved
                      ? '${_doctor.name} added to your saved care team.'
                      : 'Removed from saved care team.',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF00696B),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _isSaved ? Icons.favorite : Icons.favorite_border,
                size: 20,
                color: _isSaved ? const Color(0xFFBA1A1A) : const Color(0xFF28006D),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 80x80 portrait with verified badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDCE9FF),
                ),
                child: ClipOval(
                  child: Image.asset(
                    _doctor.avatarAsset,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      size: 44,
                      color: Color(0xFF28006D),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF28006D),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.verified, size: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Credentials & info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Care ID Verified pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF56F5F8).withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.shield, size: 12, color: Color(0xFF006E70)),
                      const SizedBox(width: 4),
                      Text(
                        'CARE ID VERIFIED',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF006E70),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _doctor.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _doctor.specialty,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00696B),
                  ),
                ),
                const SizedBox(height: 8),
                // Rating row
                Row(
                  children: [
                    const Icon(Icons.star, size: 15, color: Color(0xFFFFB800)),
                    const SizedBox(width: 4),
                    Text(
                      _doctor.rating != null ? '${_doctor.rating}' : '4.9',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${_doctor.reviewsCount > 0 ? _doctor.reviewsCount : 128} reviews)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7A7583),
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

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        _buildStatTile('${_doctor.yearsExperience}+ Years', 'Experience', Icons.work_outline),
        const SizedBox(width: 10),
        _buildStatTile(_doctor.patientsCount, 'Patients', Icons.people_outline),
        const SizedBox(width: 10),
        _buildStatTile(_doctor.successRate, 'Satisfaction', Icons.thumb_up_outlined),
      ],
    );
  }

  Widget _buildStatTile(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF00696B)),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectActionsRow() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Direct chat with ${_doctor.name} clinic will open in Live Chat flow.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xFF28006D),
                ),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF28006D)),
            label: Text(
              'Direct Message',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF28006D),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFDCE9FF),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.qrDashboard);
            },
            icon: const Icon(Icons.qr_code, size: 16, color: Colors.white),
            label: Text(
              'Share CareID',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00696B),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Clinician',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _doctor.bio,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFFE8ECF2)),
          const SizedBox(height: 10),
          Text(
            'Education & Fellowships',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 6),
          ..._doctor.education.map(
            (edu) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.school_outlined, size: 14, color: Color(0xFF00696B)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      edu,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Languages Spoken',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: _doctor.languages
                .map(
                  (lang) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      lang,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hospital Affiliation & Facility',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.local_hospital_outlined, size: 22, color: Color(0xFF28006D)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _doctor.clinic,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _doctor.address,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Opening GPS directions to ${_doctor.clinic}...',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF00696B),
                      ),
                    );
                  },
                  icon: const Icon(Icons.directions, size: 16, color: Color(0xFF00696B)),
                  label: Text(
                    'Get Directions',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF00696B)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Calling clinic reception...',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF28006D),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone_outlined, size: 16, color: Color(0xFF28006D)),
                  label: Text(
                    'Call Reception',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF28006D),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDCE9FF)),
                    backgroundColor: const Color(0xFFEFF4FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
                'Accepted Health Insurance',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Text(
                'In-Network',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00696B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._doctor.acceptedInsurances.map(
            (ins) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Color(0xFF00696B)),
                  const SizedBox(width: 8),
                  Text(
                    ins,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
                'Patient Reviews',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              Text(
                'See all (128)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sample review
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Michael R. • Verified Patient',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (_) => const Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '"Dr. Jenkins is extraordinarily thorough and patient. Having my prior ECG and lab records seamlessly accessible via CareID made the consultation so smooth."',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF494552),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFCBC4D4).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Action CTA: Book an Appointment
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.bookAppointmentType,
                arguments: _doctor,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3328006D),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Book an Appointment',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Secondary Action CTA Row: View Shared Records + Directory
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Viewing 5 records securely shared with ${_doctor.name}',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: const Color(0xFF28006D),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: const Color(0xFFCBC4D4).withValues(alpha: 0.4),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description_outlined, size: 14, color: Color(0xFF28006D)),
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Center(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

