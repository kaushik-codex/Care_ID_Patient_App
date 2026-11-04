import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../domain/models/appointment_models.dart';

/// Care ID - Reschedule Appointment (Date & Time) (Figma Node 20:30086).
class RescheduleAppointmentPage extends StatefulWidget {
  final PatientAppointment? appointment;

  const RescheduleAppointmentPage({super.key, this.appointment});

  @override
  State<RescheduleAppointmentPage> createState() => _RescheduleAppointmentPageState();
}

class _RescheduleAppointmentPageState extends State<RescheduleAppointmentPage> {
  late PatientAppointment _appointment;
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  late String _selectedTimeSlot;

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _weekdayFullNames = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  static const List<String> _weekdayShortNames = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  static const List<String> _monthShortNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Open slots in November 2023 from design
  final Set<int> _availableDaysInNov = {17, 20, 21, 22, 24, 27, 28, 29, 30};
  final int _currentBookingDay = 16;

  final List<String> _morningSlots = ['09:15 AM', '10:30 AM', '11:45 AM'];
  final List<String> _afternoonSlots = ['02:00 PM', '03:15 PM', '04:00 PM'];

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment ??
        PatientAppointment(
          id: 'CR-89421',
          doctor: const Doctor(
            id: 'doc-1',
            name: 'Dr. Sarah Jenkins, MD',
            specialty: 'Cardiology',
            category: 'Medical',
            clinic: 'Mount Sinai Heart Center',
            avatarAsset: 'assets/images/doctor_sarah_jenkins.png',
            rating: 4.9,
            reviewsCount: 128,
            yearsExperience: 14,
            isVerified: true,
            address: '1190 5th Ave, New York, NY',
            bio: 'Specialist in preventative cardiology.',
            education: ['Harvard Medical School'],
          ),
          consultationType: const ConsultationOption(
            id: 'in-person',
            title: 'In-Person Consultation (45 mins)',
            description: 'Mount Sinai Heart Center',
            duration: '45 mins',
            price: r'$75.00',
            iconSvg: 'assets/icons/513884ae2258b985a1c95505f4a361bc054e051d.svg',
          ),
          appointmentDate: DateTime(2023, 11, 16, 9, 45),
          timeSlot: '09:45 AM',
          status: AppointmentStatus.upcoming,
          reasonForVisit: 'Annual preventative heart checkup',
          qrPassRef: 'KP-99214-MSH',
        );

    // Initial selected new slot from Figma: Tuesday, Nov 21, 2023 at 10:30 AM
    _currentMonth = DateTime(2023, 11, 1);
    _selectedDate = DateTime(2023, 11, 21);
    _selectedTimeSlot = '10:30 AM';
  }

  String _formatMonthYear(DateTime dt) {
    return '${_monthNames[dt.month - 1]} ${dt.year}';
  }

  String _formatFullDate(DateTime dt) {
    final weekday = _weekdayFullNames[dt.weekday - 1];
    final month = _monthShortNames[dt.month - 1];
    return '$weekday, $month ${dt.day}, ${dt.year}';
  }

  String _formatShortSlot(DateTime dt) {
    final weekday = _weekdayShortNames[dt.weekday - 1];
    final month = _monthShortNames[dt.month - 1];
    return '$weekday, $month ${dt.day}';
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header - Top AppBar
            _buildTopAppBar(),

            // Main Scrollable Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Indicator & Context Bar
                    _buildStepIndicator(),
                    const SizedBox(height: 8),

                    // Current Appointment Reminder Card (Compact)
                    _buildCurrentBookingCard(),
                    const SizedBox(height: 16),

                    // Calendar Date Selector
                    _buildCalendarSelector(),
                    const SizedBox(height: 16),

                    // Available Time Slots Section
                    _buildTimeSlotsSection(),
                    const SizedBox(height: 16),

                    // Schedule Change Comparison Card
                    _buildComparisonCard(),
                    const SizedBox(height: 24),

                    // Action CTA Area
                    _buildActionCtaArea(),
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

  /// Header - Top AppBar
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
                    color: Color(0xFFEFF4FF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/37500812cdc62f8eaa2f7d69a7b64e1888d2dc0a.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF28006D),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Reschedule Visit',
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
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF4FF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/be2e003f378f7fa9c38741294dcf3f98f4f236fa.svg',
              width: 16,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Color(0xFF28006D),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Step Indicator & Context
  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF28006D),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '1',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Select New Date & Time',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          Text(
            'Step 1 of 2',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF494552),
            ),
          ),
        ],
      ),
    );
  }

  /// Current Appointment Reminder Card (Compact)
  Widget _buildCurrentBookingCard() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/513884ae2258b985a1c95505f4a361bc054e051d.svg',
                    width: 15,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF494552),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Current Booking',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'To be updated',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF494552),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Doctor Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: Image.asset(
                  'assets/images/doctor_sarah_jenkins.png',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 48,
                    height: 48,
                    color: const Color(0xFF28006D),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _appointment.doctor.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_appointment.doctor.specialty} • ${_appointment.doctor.clinic}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494552),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Slot Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/031c3ea8f135ecb0e66829b1222ec9cb1b4671d5.svg',
                  width: 15,
                  height: 15,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF0B1C30),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Thu, Nov 16, 2023 • 09:45 AM',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Calendar Date Selector
  Widget _buildCalendarSelector() {
    final daysInCurrentMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7; // 0 for Sunday
    final prevMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    final daysInPrevMonth = DateUtils.getDaysInMonth(prevMonth.year, prevMonth.month);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    _formatMonthYear(_currentMonth),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0x4D56F5F8),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      '8 Open Dates',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF006E70),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _previousMonth,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FF),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/9829835cf7aaabb1c9b863be93e73227820b5b9c.svg',
                        width: 7,
                        height: 11,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF28006D),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: _nextMonth,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FF),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/ea0e7702b1657323330718fc49360040a9f09ac5.svg',
                        width: 7,
                        height: 11,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF28006D),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekday Headers
          Row(
            children: const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF494552),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),

          // Calendar Days Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 4,
              childAspectRatio: 0.9,
            ),
            itemCount: 35, // 5 weeks displayed
            itemBuilder: (context, index) {
              if (index < firstWeekday) {
                // Lead-in past month days
                final prevDay = daysInPrevMonth - firstWeekday + index + 1;
                return Center(
                  child: Opacity(
                    opacity: 0.4,
                    child: Text(
                      '$prevDay',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFCBC4D4),
                      ),
                    ),
                  ),
                );
              }

              final day = index - firstWeekday + 1;
              if (day > daysInCurrentMonth) {
                // Trailing next month days
                final nextDay = day - daysInCurrentMonth;
                return Center(
                  child: Opacity(
                    opacity: 0.4,
                    child: Text(
                      '$nextDay',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFCBC4D4),
                      ),
                    ),
                  ),
                );
              }

              final isCurrentBooking = (_currentMonth.month == 11 && day == _currentBookingDay);
              final isSelected = (_currentMonth.month == _selectedDate.month && day == _selectedDate.day);
              final isAvailable = (_currentMonth.month == 11 && _availableDaysInNov.contains(day));

              return GestureDetector(
                onTap: isAvailable
                    ? () {
                        setState(() {
                          _selectedDate = DateTime(_currentMonth.year, _currentMonth.month, day);
                        });
                      }
                    : null,
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF28006D)
                            : isCurrentBooking
                                ? const Color(0xFFFFDAD6)
                                : Colors.transparent,
                        shape: BoxShape.circle,
                        boxShadow: isSelected
                            ? const [
                                BoxShadow(
                                  color: Color(0x4028006D),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: (isSelected || isCurrentBooking)
                              ? FontWeight.w700
                              : isAvailable
                                  ? FontWeight.w500
                                  : FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : isCurrentBooking
                                  ? const Color(0xFF93000A)
                                  : isAvailable
                                      ? const Color(0xFF0B1C30)
                                      : const Color(0xFFCBC4D4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Indicator Dot
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isCurrentBooking
                            ? const Color(0xFFBA1A1A)
                            : isAvailable
                                ? const Color(0xFF00696B)
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // Legend
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFE5EEFF)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(const Color(0xFF28006D), 'Selected Date'),
                const SizedBox(width: 20),
                _buildLegendItem(const Color(0xFF00696B), 'Available Slot'),
                const SizedBox(width: 20),
                _buildLegendItem(const Color(0xFFBA1A1A), 'Current Slot'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }

  /// Available Time Slots Section
  Widget _buildTimeSlotsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Slots',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                Text(
                  _formatFullDate(_selectedDate),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00696B),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/e10d2a1484042d04604688f673b1e1dd8c3e4c9c.svg',
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF494552),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'EST (UTC-5)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Morning
        Text(
          'Morning (09:00 AM – 12:00 PM)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _morningSlots.map((slot) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildTimeChip(slot),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),

        // Afternoon
        Text(
          'Afternoon (01:30 PM – 04:30 PM)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: _afternoonSlots.map((slot) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildTimeChip(slot, isBooked: slot == '04:00 PM'),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeChip(String slot, {bool isBooked = false}) {
    final isSelected = (_selectedTimeSlot == slot && !isBooked);

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() {
                _selectedTimeSlot = slot;
              });
            },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF28006D)
              : isBooked
                  ? const Color(0xFFE5EEFF).withValues(alpha: 0.5)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x4028006D),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              SvgPicture.asset(
                'assets/icons/8aa3300f2b9ef5fc6fcbcca6e02151d7b5177510.svg',
                width: 12,
                height: 9,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              slot,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : isBooked
                        ? const Color(0xFFCBC4D4)
                        : const Color(0xFF0B1C30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Change Comparison Card
  Widget _buildComparisonCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5EEFF)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Schedule Change\nSummary',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                    height: 1.3,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5EEFF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'In-Person Consultation (45 mins)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Previous vs New Side-by-Side
          Row(
            children: [
              // PREVIOUS
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PREVIOUS',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.55,
                          color: const Color(0xFF494552),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Thu, Nov 16',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      Text(
                        '09:45 AM',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Arrow Indicator
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF56F5F8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/41abe5c11e86a06288fa2a77de8594570b876eac.svg',
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF00696B),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // NEW SLOT
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0x3356F5F8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NEW SLOT',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.55,
                          color: const Color(0xFF00696B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatShortSlot(_selectedDate),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      Text(
                        _selectedTimeSlot,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00696B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Policy Banner
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bbd79c8cc1d1f1dc0de823d9024df9220ec353f3.svg',
                width: 11,
                height: 13,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF494552),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'No penalty or fee for rescheduling > 24 hrs in advance.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Action CTA Area
  Widget _buildActionCtaArea() {
    return Column(
      children: [
        // Primary: Confirm Reschedule
        GestureDetector(
          onTap: () {
            final updatedAppointment = _appointment.copyWith(
              appointmentDate: _selectedDate,
              timeSlot: _selectedTimeSlot,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Appointment successfully rescheduled to ${_formatFullDate(_selectedDate)} at $_selectedTimeSlot!',
                  style: GoogleFonts.plusJakartaSans(fontSize: 13),
                ),
                backgroundColor: const Color(0xFF28006D),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.appointmentConfirmation,
              arguments: updatedAppointment,
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 56,
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
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/6cfd0460e19404a7551082c5c029d7a0ff13b969.svg',
                  width: 17,
                  height: 17,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Confirm Reschedule',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Secondary: Keep Original Appointment
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Center(
              child: Text(
                'Keep Original Appointment',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
