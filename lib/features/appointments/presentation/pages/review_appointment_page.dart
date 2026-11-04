import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 5: Care ID - Review Appointment (`20:28595`)
class ReviewAppointmentPage extends StatefulWidget {
  final Doctor? doctor;
  final ConsultationOption? consultationType;
  final DateTime? appointmentDate;
  final String? timeSlot;

  const ReviewAppointmentPage({
    super.key,
    this.doctor,
    this.consultationType,
    this.appointmentDate,
    this.timeSlot,
  });

  @override
  State<ReviewAppointmentPage> createState() => _ReviewAppointmentPageState();
}

class _ReviewAppointmentPageState extends State<ReviewAppointmentPage> {
  late Doctor _doctor;
  late ConsultationOption _consultationType;
  late DateTime _appointmentDate;
  late String _timeSlot;

  @override
  void initState() {
    super.initState();
    _doctor = widget.doctor ?? MockAppointmentsRepository.instance.getDoctors()[1];
    _consultationType = widget.consultationType ??
        MockAppointmentsRepository.instance.getConsultationOptions()[0];
    _appointmentDate =
        widget.appointmentDate ?? DateTime(2023, 11, 16);
    _timeSlot = widget.timeSlot ?? '09:45 AM';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      if (args['doctor'] is Doctor) _doctor = args['doctor'];
      if (args['consultationType'] is ConsultationOption) {
        _consultationType = args['consultationType'];
      }
      if (args['selectedDate'] is DateTime) {
        _appointmentDate = args['selectedDate'];
      } else if (args['appointmentDate'] is DateTime) {
        _appointmentDate = args['appointmentDate'];
      }
      if (args['selectedTime'] is String) {
        _timeSlot = args['selectedTime'];
      } else if (args['timeSlot'] is String) {
        _timeSlot = args['timeSlot'];
      }
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
            // Fixed Top App Bar with CareID Logo Wordmark & Notification Bell
            _buildTopAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Progress Indicator: STEP 3 OF 4
                    _buildStepIndicator(),
                    const SizedBox(height: 14),

                    // Reassuring Notice Banner
                    _buildNoticeBanner(),
                    const SizedBox(height: 16),

                    // Summary Card 1: Doctor Profile & Facility
                    _buildDoctorSummaryCard(),
                    const SizedBox(height: 14),

                    // Summary Card 2: Schedule & Consultation
                    _buildAppointmentTimeCard(),
                    const SizedBox(height: 14),

                    // Summary Card 3: Patient & Clinical Context
                    _buildPatientContextCard(),
                    const SizedBox(height: 14),

                    // Summary Card 4: Insurance & Estimated Copay
                    _buildInsurancePaymentCard(),
                    const SizedBox(height: 14),

                    // Fast Check-In Protocol Banner
                    _buildFastCheckInBanner(),
                    const SizedBox(height: 14),

                    // Cancellation & Policy Card
                    _buildPolicyCard(),
                    const SizedBox(height: 16),
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
          // Persistent Bottom Actions Panel
          _buildBottomBar(),

          // Persistent Locked 5-Tab Bottom Navigation Bar with Doctor Tab Activated
          const CareIDBottomNavBar(currentIndex: 2),
        ],
      ),
    );
  }

  /// Top App Bar (Back Arrow, Center Wordmark Logo, Notification Bell)
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
                'Review Appointment',
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
          const SizedBox(width: 36),
        ],
      ),
    );
  }

  /// Progress Tracker: STEP 3 OF 4 • Verify Booking
  Widget _buildStepIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STEP 3 OF 4',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
                letterSpacing: 0.7,
              ),
            ),
            Text(
              'Verify Booking',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFDCE9FF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.75,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF28006D),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Reassuring Notice Banner
  Widget _buildNoticeBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 20, color: Color(0xFF28006D)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF494552),
                  height: 1.45,
                ),
                children: [
                  const TextSpan(text: 'Please review your consultation details before confirming with '),
                  TextSpan(
                    text: _doctor.clinic,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Summary Card 1: Doctor Profile & Facility
  Widget _buildDoctorSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDCE9FF),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _doctor.avatarAsset,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 32,
                          color: Color(0xFF28006D),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF56F5F8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 12, color: Color(0xFF004F51)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _doctor.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _doctor.specialty,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF0F1F5)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.local_hospital_outlined, size: 16, color: Color(0xFF28006D)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_doctor.clinic} • Heart Center',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF494552)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Suite 400 Reception, Building B',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF494552),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF5AF8FB).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 13, color: Color(0xFF004F51)),
                const SizedBox(width: 4),
                Text(
                  'Care ID Verified Partner',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004F51),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Summary Card 2: Schedule & Consultation
  Widget _buildAppointmentTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
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
                'APPOINTMENT TIME',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF494552),
                  letterSpacing: 0.6,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text(
                      'Edit Schedule',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.edit, size: 14, color: Color(0xFF00696B)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3E4FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.calendar_month, size: 20, color: Color(0xFF28006D)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thursday, November ${_appointmentDate.day}, ${_appointmentDate.year}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$_timeSlot (${_consultationType.duration})',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.medical_services_outlined, size: 16, color: Color(0xFF494552)),
                  const SizedBox(width: 6),
                  Text(
                    'Consultation Type',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DDFF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  _consultationType.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF28006D),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Summary Card 3: Patient & Clinical Context
  Widget _buildPatientContextCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
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
                'PATIENT & CLINICAL CONTEXT',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF494552),
                  letterSpacing: 0.6,
                ),
              ),
              const Icon(Icons.shield_outlined, size: 16, color: Color(0xFF00696B)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Sarah Jenkins',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD3E4FE),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'CID #8472-9901',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF494552),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '12 May 1985 (Age 38) • (555) 234-8901',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
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
          const SizedBox(height: 12),
          Text(
            'REASON FOR VISIT',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF7A7583),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Follow-up consultation after lipid panel test and routine cardiovascular checkup.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF0B1C30),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF5AF8FB).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock_outline, size: 16, color: Color(0xFF004F51)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '5 Vault Documents will be securely shared at check-in',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004F51),
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

  /// Summary Card 4: Insurance & Estimated Copay
  Widget _buildInsurancePaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
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
                'INSURANCE & ESTIMATED COPAY',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF494552),
                  letterSpacing: 0.6,
                ),
              ),
              const Icon(Icons.credit_card, size: 16, color: Color(0xFF28006D)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Blue Cross Blue Shield',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  Text(
                    'Plan: PPO Gold • Member #BC-99182',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    r'$35.00',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                  Text(
                    'Estimated Copay',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Fast Check-In Protocol Banner
  Widget _buildFastCheckInBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF28006D),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
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
              color: Color(0xFF3F1D8B),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.qr_code_scanner_rounded, size: 20, color: Color(0xFF56F5F8)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Care ID Fast Check-In',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Your appointment QR pass will be issued immediately upon confirmation for instant clinic tap-and-scan arrival.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFCFBDFF),
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

  /// Policy & Cancellation Advisory Card
  Widget _buildPolicyCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF28006D)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Free cancellation or rescheduling up to 24 hours prior to appointment.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF494552),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Persistent Bottom Actions (Confirm & Book Appointment + Back / Modify)
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFCBC4D4).withValues(alpha: 0.25),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Action: Confirm & Book Appointment
          GestureDetector(
            onTap: () {
              final newApt = PatientAppointment(
                id: '#APT-88204-NY',
                doctor: _doctor,
                consultationType: _consultationType,
                appointmentDate: _appointmentDate,
                timeSlot: _timeSlot,
                status: AppointmentStatus.upcoming,
                patientName: 'Sarah Jenkins',
                careIdNumber: 'CID #8472-9901',
                reasonForVisit:
                    'Routine cardiovascular checkup and lipid panel analysis.',
                copay: r'$35.00',
                insuranceName: 'Blue Cross Blue Shield • PPO Gold',
                vaultRecordsSynced: 5,
                qrPassRef: 'APT-88204',
              );
              MockAppointmentsRepository.instance.addAppointment(newApt);

              Navigator.of(context).pushNamed(
                AppRoutes.appointmentConfirmation,
                arguments: newApt,
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
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Confirm & Book Appointment',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
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
          const SizedBox(height: 8),

          // Secondary Action: Back / Modify
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Center(
                child: Text(
                  'Back / Modify',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF28006D),
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
