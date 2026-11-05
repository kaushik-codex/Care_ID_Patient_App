import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../../../core/widgets/care_id_notification_button.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 7: Care ID - My Appointments (Upcoming, Completed, Cancelled) (`20:29664`)
class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  int _selectedTabIndex = 0; // 0: Upcoming, 1: Completed, 2: Cancelled
  final repo = MockAppointmentsRepository.instance;

  @override
  Widget build(BuildContext context) {
    AppointmentStatus? filterStatus;
    if (_selectedTabIndex == 0) filterStatus = AppointmentStatus.upcoming;
    if (_selectedTabIndex == 1) filterStatus = AppointmentStatus.completed;
    if (_selectedTabIndex == 2) filterStatus = AppointmentStatus.cancelled;

    final appointments = repo.getAppointments(status: filterStatus);
    final upcomingCount = repo.getAppointments(status: AppointmentStatus.upcoming).length;
    final completedCount = repo.getAppointments(status: AppointmentStatus.completed).length;
    final cancelledCount = repo.getAppointments(status: AppointmentStatus.cancelled).length;

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
                    // Top Utility & Actions (Patient Portal header)
                    _buildPortalHeader(),
                    const SizedBox(height: 14),

                    // Status Tabs / Filter Chips
                    _buildFilterTabs(upcomingCount, completedCount, cancelledCount),
                    const SizedBox(height: 16),

                    // Quick Summary Reminder Banner (if on upcoming tab)
                    if (_selectedTabIndex == 0 && appointments.isNotEmpty) ...[
                      _buildReminderBanner(appointments.first),
                      const SizedBox(height: 20),
                    ],

                    // Section Heading: Scheduled Visits
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _selectedTabIndex == 0
                                ? 'Scheduled Visits'
                                : (_selectedTabIndex == 1
                                    ? 'Past Completed Visits'
                                    : 'Cancelled Appointments'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${appointments.length} Active',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Appointments List
                    if (appointments.isEmpty)
                      _buildEmptyState()
                    else
                      Column(
                        children: appointments
                            .map((apt) => _buildFigmaAppointmentCard(apt))
                            .toList(),
                      ),
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
          // Docked CTA Booking Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFCBC4D4).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.doctors);
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
                    const Icon(Icons.add, size: 16, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'Book New Appointment',
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
          ),

          // Persistent Locked 5-Tab Bottom Navigation Bar with Doctor Tab Activated
          const CareIDBottomNavBar(currentIndex: 2),
        ],
      ),
    );
  }

  /// Top App Bar (Back Arrow, Title + Badge, Notification Bell)
  Widget _buildTopAppBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
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
                Flexible(
                  child: Text(
                    'My Appointments',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                    ),
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
          ),
          const SizedBox(width: 8),
          const CareIDNotificationButton(),
        ],
      ),
    );
  }

  /// Top Utility & Actions (Patient Portal header with calendar & filter buttons)
  Widget _buildPortalHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PATIENT PORTAL',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00696B),
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Manage scheduled healthcare visits',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE5EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.calendar_month_outlined, size: 18, color: Color(0xFF28006D)),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE5EEFF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.tune_rounded, size: 18, color: Color(0xFF28006D)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Status Tabs / Filter Chips
  Widget _buildFilterTabs(int upcoming, int completed, int cancelled) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildChip(0, 'Upcoming ($upcoming)', showDot: true),
          const SizedBox(width: 8),
          _buildChip(1, 'Completed ($completed)'),
          const SizedBox(width: 8),
          _buildChip(2, 'Cancelled ($cancelled)'),
        ],
      ),
    );
  }

  Widget _buildChip(int index, String label, {bool showDot = false}) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF28006D) : const Color(0xFFE5EEFF),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF494552),
              ),
            ),
            if (isSelected && showDot) ...[
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF56F5F8),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Quick Summary Reminder Banner
  Widget _buildReminderBanner(PatientAppointment apt) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF00696B).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.notifications_active_outlined,
                  size: 20, color: Color(0xFF00696B)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Upcoming Consultation',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00696B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF56F5F8),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        'in 3 Days',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF006E70),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  apt.doctor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF494552)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${apt.doctor.clinic} • Suite 400',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF494552),
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

  /// Figma Appointment Card Component
  Widget _buildFigmaAppointmentCard(PatientAppointment apt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Status Pill & Date Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE9FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                      Flexible(
                        child: Text(
                          'Confirmed • Upcoming',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF00696B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFF494552)),
                    const SizedBox(width: 4),
                    Text(
                      'Thu, Nov ${apt.appointmentDate.day}',
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
          const SizedBox(height: 14),

          // Doctor Info
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    apt.doctor.avatarAsset,
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
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apt.doctor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      apt.doctor.specialty,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF494552)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${apt.doctor.clinic} • Suite 400',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF494552),
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
          const SizedBox(height: 14),

          // Detail Chips Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF28006D)),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              apt.timeSlot,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0B1C30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCE9FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'In-Person Consultation',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5B14B8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.verified_outlined, size: 13, color: Color(0xFF00696B)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Care ID Coverage verified & checked-in',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Quick Actions Row: Reschedule + View Details
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.bookAppointmentDateTime,
                      arguments: {'doctor': apt.doctor},
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 15, color: Color(0xFF0B1C30)),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Reschedule',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.appointmentDetails,
                      arguments: apt,
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF28006D),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x2628006D),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'View Details',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
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
            const Icon(Icons.event_busy, size: 48, color: Color(0xFF7A7583)),
            const SizedBox(height: 12),
            Text(
              'No Appointments',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'No appointments in this category.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.doctors);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF28006D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Text(
                'Find a Doctor',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
