import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 8: Care ID - Appointment Details (`20:29399`)
class AppointmentDetailsPage extends StatefulWidget {
  final PatientAppointment? appointment;

  const AppointmentDetailsPage({super.key, this.appointment});

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  late PatientAppointment _appointment;

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment ??
        MockAppointmentsRepository.instance.getAppointments()[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is PatientAppointment) {
      _appointment = args;
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
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Utility Context Bar
                    _buildTopContextBar(),
                    const SizedBox(height: 12),

                    // Countdown / Schedule Highlight Banner
                    _buildCountdownBanner(),
                    const SizedBox(height: 16),

                    // Doctor & Location Card
                    _buildDoctorLocationCard(),
                    const SizedBox(height: 16),

                    // Digital Arrival Pass / QR Card
                    _buildDigitalArrivalPassCard(),
                    const SizedBox(height: 16),

                    // Clinical Records & Vault Synced Card
                    _buildClinicalVaultCard(),
                    const SizedBox(height: 16),

                    // Consultation Parameters Card
                    _buildParametersCard(),
                    const SizedBox(height: 20),

                    // Primary Action Buttons Area
                    _buildActionButtonsArea(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(currentIndex: 2),
    );
  }

  /// Top App Bar (Back Arrow, Center Wordmark Logo, Notification Bell)
  Widget _buildTopAppBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
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
          ),
          Center(
            child: Image.asset(
              'assets/images/care_id_logo_wordmark.png',
              height: 18,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Text(
                'CareID',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF28006D),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }

  /// Top Utility Context Bar
  Widget _buildTopContextBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF56F5F8),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00696B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Confirmed • Upcoming',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF006E70),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                const Icon(Icons.verified, size: 15, color: Color(0xFF28006D)),
                const SizedBox(width: 4),
                Text(
                  'Care ID Verified',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF28006D),
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment pass shared to CareID vault contacts.'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFE5EEFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share_outlined, size: 16, color: Color(0xFF28006D)),
          ),
        ),
      ],
    );
  }

  /// Countdown / Schedule Highlight Banner
  Widget _buildCountdownBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF28006D),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2628006D),
            blurRadius: 10,
            offset: Offset(0, 4),
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
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.calendar_today_rounded, size: 22, color: Colors.white),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 14, color: Color(0xFF5AF8FB)),
                    const SizedBox(width: 4),
                    Text(
                      'In 3 Days',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5AF8FB),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Thursday, Nov ${_appointment.appointmentDate.day}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_appointment.timeSlot} (EST) • Early Check-In 09:35 AM',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFCFBDFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Doctor & Location Card
  Widget _buildDoctorLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info
          Row(
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
                    _appointment.doctor.avatarAsset,
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
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appointment.doctor.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _appointment.doctor.specialty,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _appointment.doctor.clinic,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Facility Location Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF28006D)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mount Sinai Heart Center',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                          Text(
                            '1190 5th Ave, Suite 400, New York, NY 10029',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD3E4FE),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.directions_outlined,
                                size: 14, color: Color(0xFF28006D)),
                            const SizedBox(width: 4),
                            Text(
                              'Get Directions',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF28006D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD3E4FE),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.call_outlined,
                                size: 14, color: Color(0xFF28006D)),
                            const SizedBox(width: 4),
                            Text(
                              'Call Clinic',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
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
          ),
        ],
      ),
    );
  }

  /// Digital Arrival Pass / QR Card
  Widget _buildDigitalArrivalPassCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
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
                  const Icon(Icons.qr_code_2, size: 20, color: Color(0xFF28006D)),
                  const SizedBox(width: 8),
                  Text(
                    'Digital Arrival Pass',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Kiosk Ready',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF494552),
                  ),
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
                // QR Box with Tap to Enlarge
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.appointmentDetailsActions,
                      arguments: _appointment,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
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
                        const Icon(Icons.qr_code_2, size: 70, color: Color(0xFF28006D)),
                        const SizedBox(height: 2),
                        Text(
                          'Tap to Enlarge',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto-Expiring Kiosk Code',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Scan at Mount Sinai Suite 400 terminal upon arrival for instantaneous queue clearance.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: const Color(0xFF494552),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.flash_on, size: 14, color: Color(0xFF00696B)),
                          const SizedBox(width: 4),
                          Text(
                            'Fast-track check-in ready',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF00696B),
                            ),
                          ),
                        ],
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

  /// Clinical Records & Vault Synced Card
  Widget _buildClinicalVaultCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
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
              Text(
                'CLINICAL CONTEXT SYNCED',
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
          _buildVaultDocItem(
            title: 'Lipid Panel Lab Report',
            subtitle: 'Synced from Care ID Vault',
            icon: Icons.biotech_outlined,
          ),
          const SizedBox(height: 8),
          _buildVaultDocItem(
            title: 'Annual Comprehensive Exam',
            subtitle: 'Synced from Care ID Vault',
            icon: Icons.assignment_outlined,
          ),
          const SizedBox(height: 12),
          Text(
            'Patient Checklist',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 6),
          _buildChecklistItem('Bring current physical prescription list'),
          const SizedBox(height: 4),
          _buildChecklistItem('Arrive 10 minutes prior for digital kiosk check-in'),
        ],
      ),
    );
  }

  Widget _buildVaultDocItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF56F5F8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(icon, size: 18, color: const Color(0xFF004F51)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, size: 16, color: Color(0xFF00696B)),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF00696B)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: const Color(0xFF0B1C30),
            ),
          ),
        ),
      ],
    );
  }

  /// Consultation Parameters Card
  Widget _buildParametersCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VISIT PARAMETERS',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF494552),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 12),
          _buildParamRow('Visit Type', _appointment.consultationType.title),
          const SizedBox(height: 8),
          _buildParamRow('Reason', _appointment.reasonForVisit),
          const SizedBox(height: 8),
          _buildParamRow('Insurance', _appointment.insuranceName),
          const SizedBox(height: 8),
          _buildParamRow('Copay Status', '${_appointment.copay} (Pre-authorized)'),
        ],
      ),
    );
  }

  Widget _buildParamRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF7A7583),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0B1C30),
            ),
          ),
        ),
      ],
    );
  }

  /// Primary Action Buttons Area
  Widget _buildActionButtonsArea() {
    return Column(
      children: [
        // Primary CTA: Chat with The Facility
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.liveChat);
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
                const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Chat with The Facility',
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

        // Secondary: Manage Appointment & Actions
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.appointmentDetailsActions,
              arguments: _appointment,
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Manage Appointment & Actions',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF28006D),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF28006D)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
