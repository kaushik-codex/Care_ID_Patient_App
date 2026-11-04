import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 1: Doctors & Providers Directory (`20:28020`)
class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  final repo = MockAppointmentsRepository.instance;

  final List<String> _categories = [
    'All Providers',
    'Medical',
    'Dental',
    'Vision',
    'General Medicine',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queryCategory = _selectedCategory == 'All Providers' ? 'All' : _selectedCategory;
    final doctors = repo.getDoctors(
      category: queryCategory,
      query: _searchController.text.trim(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Greeting & Search Header Area
                    _buildHeader(),
                    const SizedBox(height: 12),

                    // Search Bar
                    _buildSearchBar(),
                    const SizedBox(height: 16),

                    // Horizontal Category Filter Chips
                    _buildCategoryFilter(),
                    const SizedBox(height: 24),

                    // Connected Clinicians Section Header
                    _buildSectionHeader(doctors.length),
                    const SizedBox(height: 16),

                    // Doctor Cards List
                    if (doctors.isEmpty)
                      _buildEmptyState()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: doctors.map((doc) => _buildDoctorCard(doc)).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(
        currentIndex: 2, // Highlight clinician / services tab
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF28006D)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Find Doctors',
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
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationCenter),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE5EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.notifications_none_rounded, size: 20, color: Color(0xFF28006D)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-badge: Secure Clinician Vault
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/shield_encrypted.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(Color(0xFF00696B), BlendMode.srcIn),
              ),
              const SizedBox(width: 6),
              Text(
                'Secure Clinician Vault',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00696B),
                  height: 20 / 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Heading 1
          Text(
            'Doctors/ Providers',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF28006D),
              letterSpacing: -0.7,
              height: 36 / 28,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle
          Text(
            'Find and manage doctors connected to your Care ID vault',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
              height: 22 / 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF28006D).withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/access_search.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(Color(0xFF7A7583), BlendMode.srcIn),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF0B1C30),
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name, clinic, or specialty...',
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A7583),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (_searchController.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.close, size: 18, color: Color(0xFF7A7583)),
                ),
              ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EEFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/access_filter.svg',
                  width: 15,
                  height: 15,
                  colorFilter: const ColorFilter.mode(Color(0xFF28006D), BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = cat;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF28006D) : const Color(0xFFDCE9FF),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  cat,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF0B1C30),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'CONNECTED CLINICIANS ($count)',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF494552),
              letterSpacing: 0.7,
            ),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00696B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'Sync Active',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF00696B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info row: Avatar + Name + Specialty + Clinic
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with verified badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE5EEFF),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        doc.avatarAsset,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 36,
                          color: Color(0xFF28006D),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00696B),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.check, size: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              // Name, specialty & clinic
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF28006D),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      doc.specialty,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/emergency_location_pin.svg',
                          width: 12,
                          height: 12,
                          colorFilter: const ColorFilter.mode(Color(0xFF494552), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            doc.clinic,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Rating summary
          Row(
            children: [
              if (doc.rating != null) ...[
                Row(
                  children: List.generate(
                    5,
                    (i) => const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${doc.rating}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00696B),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${doc.reviewsCount} reviews)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A7583),
                  ),
                ),
              ] else ...[
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(Icons.star_border, size: 14, color: Colors.grey.shade400),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Unrated',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00696B),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Rate in profile',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A7583),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),

          // Verification Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: doc.isPrimary
                  ? const Color(0xFFE8DDFF)
                  : const Color(0xFF56F5F8).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 13,
                  color: doc.isPrimary ? const Color(0xFF21005D) : const Color(0xFF00696B),
                ),
                const SizedBox(width: 5),
                Text(
                  doc.isPrimary
                      ? 'Care ID Verified • Primary Physician'
                      : 'Care ID Verified • Connected Doctor',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: doc.isPrimary ? const Color(0xFF21005D) : const Color(0xFF00696B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Card Action Buttons
          Row(
            children: [
              // View Profile
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.doctorProfile,
                        arguments: doc,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCE9FF),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_outline, size: 16, color: Color(0xFF28006D)),
                        const SizedBox(width: 6),
                        Text(
                          'View Profile',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Book Appointment
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.bookAppointmentType,
                        arguments: doc,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF28006D),
                      elevation: 2,
                      shadowColor: const Color(0xFF28006D).withValues(alpha: 0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month, size: 16, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          'Book Appointment',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 48, color: Color(0xFF7A7583)),
            const SizedBox(height: 12),
            Text(
              'No Clinicians Found',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try clearing search filters or selecting another category.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

