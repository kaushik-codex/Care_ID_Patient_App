import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_appointments_repository.dart';
import '../../domain/models/appointment_models.dart';

/// Screen 4: Care ID - Book Appointment (Date & Time) (`20:28312`)
class BookAppointmentDateTimePage extends StatefulWidget {
  final Doctor? doctor;
  final ConsultationOption? consultationType;

  const BookAppointmentDateTimePage({
    super.key,
    this.doctor,
    this.consultationType,
  });

  @override
  State<BookAppointmentDateTimePage> createState() =>
      _BookAppointmentDateTimePageState();
}

class _BookAppointmentDateTimePageState
    extends State<BookAppointmentDateTimePage> {
  late Doctor _doctor;
  late ConsultationOption _consultationType;

  DateTime _currentMonth = DateTime(2023, 11, 1);
  DateTime _selectedDate = DateTime(2023, 11, 16);
  String _selectedTime = '09:45 AM';

  final List<String> _morningSlots = [
    '09:00 AM',
    '09:45 AM',
    '10:30 AM',
    '11:15 AM'
  ];
  final List<String> _afternoonSlots = [
    '02:00 PM',
    '02:45 PM',
    '03:30 PM',
    '04:15 PM'
  ];
  final List<String> _eveningSlots = ['05:00 PM', '05:45 PM'];

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _shortMonthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static const List<String> _weekdayNames = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  String _formatMonthYear(DateTime dt) {
    return '${_monthNames[dt.month - 1]} ${dt.year}';
  }

  String _formatShortDate(DateTime dt) {
    final weekday = _weekdayNames[dt.weekday - 1];
    final month = _shortMonthNames[dt.month - 1];
    return '$weekday, $month ${dt.day}';
  }

  @override
  void initState() {
    super.initState();
    _doctor = widget.doctor ?? MockAppointmentsRepository.instance.getDoctors()[1];
    _consultationType = widget.consultationType ??
        MockAppointmentsRepository.instance.getConsultationOptions()[0];
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
    }
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
            // Fixed Top App Bar with CareID Logo Wordmark & Notification Bell
            _buildTopAppBar(),

            // Scrollable Content Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Progress Header (Step 2 of 4)
                    _buildStepIndicator(),
                    const SizedBox(height: 14),

                    // Doctor Context Banner
                    _buildDoctorBanner(),
                    const SizedBox(height: 20),

                    // Interactive Full Month Calendar Section
                    _buildCalendarSection(),
                    const SizedBox(height: 24),

                    // Available Time Slots Header
                    _buildSlotsHeader(),
                    const SizedBox(height: 14),

                    // Morning Time Slots
                    _buildSlotCategory('Morning', _morningSlots, Icons.wb_sunny_outlined),
                    const SizedBox(height: 14),

                    // Afternoon Time Slots
                    _buildSlotCategory('Afternoon', _afternoonSlots, Icons.wb_twilight_outlined),
                    const SizedBox(height: 14),

                    // Evening Time Slots
                    _buildSlotCategory('Evening', _eveningSlots, Icons.nightlight_outlined),
                    const SizedBox(height: 20),

                    // Timezone & Arrival Notice Card
                    _buildNoticeBanner(),
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
          // Persistent Bottom CTA Container (Right above Navbar)
          Container(
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
                  AppRoutes.reviewAppointment,
                  arguments: {
                    'doctor': _doctor,
                    'consultationType': _consultationType,
                    'selectedDate': _selectedDate,
                    'selectedTime': _selectedTime,
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
                      'Continue to Review',
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
          ),

          // Persistent Bottom Navigation Bar with Doctor Tab Activated
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

  /// Progress Header: Step 2 of 4 & Progress Bar
  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step 2 of 4',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
            Text(
              'Select Date & Time',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00696B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF28006D),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  /// Doctor Context Banner
  Widget _buildDoctorBanner() {
    return Container(
      padding: const EdgeInsets.all(10),
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
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE5EEFF),
                ),
                child: ClipOval(
                  child: Image.asset(
                    _doctor.avatarAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      size: 26,
                      color: Color(0xFF28006D),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00696B),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
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
                        _doctor.name,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, size: 14, color: Color(0xFF00696B)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      _consultationType.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('•', style: TextStyle(color: Color(0xFF494552), fontSize: 13)),
                    const SizedBox(width: 6),
                    Text(
                      _consultationType.duration,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF56F5F8),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              _doctor.copayAmount,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF006E70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Full Month Interactive Calendar Section with Working Chevron Controls
  Widget _buildCalendarSection() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final monthYearTitle = _formatMonthYear(_currentMonth);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A28006D),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
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
          // Month Header & Working Chevron Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: Color(0xFF28006D),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    monthYearTitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Previous Month Button (<)
                  GestureDetector(
                    onTap: _previousMonth,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5EEFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 20,
                          color: Color(0xFF28006D),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Next Month Button (>)
                  GestureDetector(
                    onTap: _nextMonth,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5EEFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: Color(0xFF28006D),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekday Header Row (S, M, T, W, T, F, S)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 38,
                child: Center(
                  child: Text(
                    day,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // Full Month Calendar Days Grid
          _buildMonthGrid(),
        ],
      ),
    );
  }

  /// Full Month Days Grid (No clipping, fully visible, interactive date selection)
  Widget _buildMonthGrid() {
    final year = _currentMonth.year;
    final month = _currentMonth.month;

    final firstDayOfMonth = DateTime(year, month, 1);
    final startWeekday = firstDayOfMonth.weekday % 7; // Sunday = 0
    final daysInCurrentMonth = DateUtils.getDaysInMonth(year, month);

    final prevMonthDate = DateTime(year, month - 1, 1);
    final daysInPrevMonth = DateUtils.getDaysInMonth(prevMonthDate.year, prevMonthDate.month);

    final List<Widget> dayWidgets = [];

    // 1. Muted trailing days from previous month
    for (int i = startWeekday - 1; i >= 0; i--) {
      final dayNum = daysInPrevMonth - i;
      dayWidgets.add(
        _buildCalendarDayCell(
          day: dayNum,
          isCurrentMonth: false,
          isSelected: false,
          onTap: null,
        ),
      );
    }

    // 2. Days in current month
    for (int dayNum = 1; dayNum <= daysInCurrentMonth; dayNum++) {
      final cellDate = DateTime(year, month, dayNum);
      final isSelected = _selectedDate.year == year &&
          _selectedDate.month == month &&
          _selectedDate.day == dayNum;

      dayWidgets.add(
        _buildCalendarDayCell(
          day: dayNum,
          isCurrentMonth: true,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedDate = cellDate;
            });
          },
        ),
      );
    }

    // 3. Muted leading days from next month to complete rows of 7
    final remainingCells = (7 - (dayWidgets.length % 7)) % 7;
    for (int dayNum = 1; dayNum <= remainingCells; dayNum++) {
      dayWidgets.add(
        _buildCalendarDayCell(
          day: dayNum,
          isCurrentMonth: false,
          isSelected: false,
          onTap: null,
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 4,
      childAspectRatio: 1.0,
      children: dayWidgets,
    );
  }

  /// Single Calendar Cell
  Widget _buildCalendarDayCell({
    required int day,
    required bool isCurrentMonth,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    if (!isCurrentMonth) {
      return Center(
        child: Text(
          '$day',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFCBC4D4),
          ),
        ),
      );
    }

    if (isSelected) {
      return Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFF28006D),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x3328006D),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$day',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$day',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Available Time Slots Header
  Widget _buildSlotsHeader() {
    final formattedDate = _formatShortDate(_selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slots for $formattedDate',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Choose preferred visit window',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ],
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
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF00696B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '6 Slots Open',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF006E70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Time Slot Category Section (Morning, Afternoon, Evening)
  Widget _buildSlotCategory(String title, List<String> slots, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF494552)),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: slots.map((slot) {
            final isSelected = _selectedTime == slot;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTime = slot;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF28006D) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF28006D) : const Color(0xFFE5EEFF),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? const Color(0x3328006D)
                          : const Color(0x08000000),
                      blurRadius: isSelected ? 8 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF56F5F8)),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      slot,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Arrival & Timezone Notice Banner
  Widget _buildNoticeBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
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
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            child: const Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Color(0xFF28006D),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arrival & Timezone Notice',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      height: 1.45,
                    ),
                    children: const [
                      TextSpan(text: 'All times are in '),
                      TextSpan(
                        text: 'Eastern Standard Time (EST)',
                        style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF0B1C30)),
                      ),
                      TextSpan(
                        text:
                            '. Please arrive 10 minutes prior for seamless digital Care ID contactless check-in.',
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
}
