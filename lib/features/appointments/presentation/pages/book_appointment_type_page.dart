import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 3: Book Appointment - Type Selection (`20:28764`)
class BookAppointmentTypePage extends StatefulWidget {
  final Doctor? doctor;

  const BookAppointmentTypePage({super.key, this.doctor});

  @override
  State<BookAppointmentTypePage> createState() => _BookAppointmentTypePageState();
}

class _BookAppointmentTypePageState extends State<BookAppointmentTypePage> {
  late Doctor _doctor;
  String _selectedTypeId = 'in_person';

  final List<ConsultationOption> _options = MockAppointmentsRepository.instance.getConsultationOptions();

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
            _buildTopAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Progress Indicator
                    _buildStepIndicator(),
                    const SizedBox(height: 12),

                    // Headings
                    Text(
                      'Book Appointment',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Configure consultation context and visit scope',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Doctor Context Card
                    _buildDoctorBanner(),
                    const SizedBox(height: 24),

                    // Consultation Type Selector Section
                    Text(
                      'Select Consultation Type',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose how you would like to consult with ${_doctor.name}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Options List
                    ..._options.map((opt) => _buildOptionTile(opt)),

                    const SizedBox(height: 16),
                    // Reassurance card
                    _buildReassuranceBanner(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomBar(),
          const CareIDBottomNavBar(currentIndex: 2),
        ],
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
                'Book Appointment',
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

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'STEP 1 OF 4',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF00696B),
            letterSpacing: 0.7,
          ),
        ),
        Row(
          children: [
            Container(
              width: 24,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF28006D),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFDCE9FF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFDCE9FF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFDCE9FF),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoctorBanner() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFE5EEFF),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _doctor.avatarAsset,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      size: 32,
                      color: Color(0xFF28006D),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _doctor.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _doctor.specialty,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF494552)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _doctor.clinic,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF00696B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified, size: 13, color: Color(0xFF00696B)),
                    const SizedBox(width: 4),
                    Text(
                      'Care ID Verified Partner',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Connected Vault',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.sync, size: 14, color: Color(0xFF28006D)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Connected to your Care ID Health Vault • Auto-sync active',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF494552),
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

  Widget _buildOptionTile(ConsultationOption opt) {
    final isSelected = opt.id == _selectedTypeId;

    IconData iconData = Icons.local_hospital_outlined;
    if (opt.id == 'telehealth') {
      iconData = Icons.videocam_outlined;
    } else if (opt.id == 'follow_up') {
      iconData = Icons.schedule_outlined;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTypeId = opt.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF28006D) : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF56F5F8) : const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  iconData,
                  size: 22,
                  color: isSelected ? const Color(0xFF004F51) : const Color(0xFF28006D),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opt.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    opt.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          opt.duration,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        opt.price,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00696B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF28006D) : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: isSelected ? const Color(0xFF28006D) : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.circle, size: 8, color: Colors.white),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReassuranceBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.flash_on, size: 18, color: Color(0xFF28006D)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CareID Fast Check-in Included',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pre-authorizes your verified health records and generates a contactless kiosk pass, saving up to 15 minutes upon arrival.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
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

  Widget _buildBottomBar() {
    final selectedOption = _options.firstWhere((o) => o.id == _selectedTypeId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFCBC4D4).withValues(alpha: 0.25),
            width: 1,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.bookAppointmentDateTime,
            arguments: {
              'doctor': _doctor,
              'consultationType': selectedOption,
            },
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: 52,
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
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue to Date & Time',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

