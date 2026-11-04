import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 21: Notification Center (Figma node 20:23812)
///
/// Complete notifications interface featuring:
/// - Fixed frosted glassmorphic Top App Bar with back button, "Notifications" title,
///   CareID logo mark, notification bell with unread badge (5), and user avatar
/// - Horizontal scrollable Category Filters (All, Unread, Medication, Appointments, Insurance, Family, Emergency)
/// - Section: "Today" with "2 NEW" priority alerts:
///   - Medication Reminder card (6px teal left accent stripe, Lisinopril 10mg, Mark as Taken / Snooze 15m)
///   - Emergency Alert card (6px crimson left accent stripe, NYC login security alert, Review Activity Details)
/// - Section: "Recent" chronological alerts:
///   - Medical Record Added card (Blood Panel results available)
///   - Family Consent Approved card (Sarah Jenkins approved request)
///   - Insurance Policy Notice card (Global Shield expires in 30 days)
/// - Unified persistent floating Bottom Navigation Bar
class NotificationCenterPage extends StatefulWidget {
  const NotificationCenterPage({super.key});

  @override
  State<NotificationCenterPage> createState() => _NotificationCenterPageState();
}

class _NotificationCenterPageState extends State<NotificationCenterPage> {
  String _selectedFilter = 'All';
  bool _isMedicationTaken = false;

  final List<String> _filters = [
    'All',
    'Unread',
    'Medication',
    'Appointments',
    'Insurance',
    'Family',
    'Emergency',
  ];

  void _handleMarkAsTaken() {
    setState(() => _isMedicationTaken = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Lisinopril 10mg recorded as taken.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006971),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleSnooze() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reminder snoozed for 15 minutes.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF28006D),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleReviewActivity() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFDAD6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/notif_alert_shield.svg',
                      width: 20,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unrecognized Login Attempt',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      Text(
                        'New York, NY • Today at 11:15 AM',
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
            Text(
              'A new session from Safari on macOS was detected. If you did not initiate this, revoke all sessions and change your biometric passkey immediately.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFCBC4D4)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'It Was Me',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Session revoked. Account credentials secured.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: const Color(0xFFBA1A1A),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBA1A1A),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Secure Account',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Filter visibility checks
  bool get _showMedication =>
      _selectedFilter == 'All' || _selectedFilter == 'Unread' || _selectedFilter == 'Medication';

  bool get _showEmergency =>
      _selectedFilter == 'All' || _selectedFilter == 'Unread' || _selectedFilter == 'Emergency';

  bool get _showMedicalRecord =>
      _selectedFilter == 'All' || _selectedFilter == 'Appointments';

  bool get _showFamily =>
      _selectedFilter == 'All' || _selectedFilter == 'Family';

  bool get _showInsurance =>
      _selectedFilter == 'All' || _selectedFilter == 'Insurance';

  bool get _hasTodayItems => _showMedication || _showEmergency;
  bool get _hasRecentItems => _showMedicalRecord || _showFamily || _showInsurance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Main Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              key: const Key('notification_scroll_view'),
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 72, bottom: 120),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Section 1: Horizontal Category Filters (Figma node 20:23814)
                        _buildCategoryFilters(),

                        const SizedBox(height: 24),

                        // Section 2: "Today" Priority Alerts (Figma node 20:23830)
                        if (_hasTodayItems) ...[
                          _buildTodaySectionHeader(),
                          const SizedBox(height: 16),
                          if (_showMedication) ...[
                            _buildMedicationReminderCard(),
                            const SizedBox(height: 16),
                          ],
                          if (_showEmergency) ...[
                            _buildEmergencyAlertCard(),
                            const SizedBox(height: 24),
                          ],
                        ],

                        // Section 3: "Recent" Chronological Alerts (Figma node 20:23869)
                        if (_hasRecentItems) ...[
                          _buildRecentSectionHeader(),
                          const SizedBox(height: 16),
                          if (_showMedicalRecord) ...[
                            _buildMedicalRecordAddedCard(),
                            const SizedBox(height: 16),
                          ],
                          if (_showFamily) ...[
                            _buildFamilyConsentApprovedCard(),
                            const SizedBox(height: 16),
                          ],
                          if (_showInsurance) ...[
                            _buildInsuranceNoticeCard(),
                            const SizedBox(height: 16),
                          ],
                        ],

                        if (!_hasTodayItems && !_hasRecentItems)
                          _buildEmptyFilterState(),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Fixed Top App Bar (Figma node 20:23909)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Persistent Unified Bottom Navigation Bar (Figma node 20:23926)
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  /// Fixed Frosted Top App Bar (Figma node 20:23909)
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
                color: Colors.white.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Group: Back Chevron + "Notifications" Title + CareID Emblem
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40,
                      height: 40,
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
                    'Notifications',
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

              // Right Group: Notification Bell with Badge + Patient Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bell Icon with Red Pill Counter (Figma node 20:23918)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/notif_bell.svg',
                            width: 18,
                            height: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFBA1A1A),
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(color: const Color(0xFFF8F9FF), width: 1.5),
                          ),
                          child: Text(
                            '5',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  // Patient Avatar (Figma node 20:23923)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE8DDFF),
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/patient_avatar.png',
                        fit: BoxFit.cover,
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

  /// Section 1: Category Filter Chips (Figma node 20:23814)
  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFA44CFF),
                            Color(0xFF5B14B8),
                          ],
                        )
                      : null,
                  color: isSelected ? null : const Color(0xFFE5EEFF),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x265B14B8),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF494552),
                    height: 24 / 16,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Header Row for "Today" (Figma node 20:23831)
  Widget _buildTodaySectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Today',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF28006D),
            height: 24 / 16,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDAD6),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '2 NEW',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF93000A),
              height: 16 / 12,
            ),
          ),
        ),
      ],
    );
  }

  /// Card 1: Medication Reminder Card (Figma node 20:23836)
  Widget _buildMedicationReminderCard() {
    return GestureDetector(
      key: const Key('medication_reminder_card'),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.medicationReminderDetail),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Left 6px Teal Accent Stripe (Figma node 20:23854)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 6,
              child: Container(color: const Color(0xFF006971)),
            ),

            // Main Card Content
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cyan Pill Bottle Icon Box (Figma node 20:23838)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF75F2FE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/notif_pill_bottle.svg',
                        width: 18,
                        height: 23,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Information and Actions
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header: Title and Time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Medication Reminder',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0B1C30),
                                  height: 24 / 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '8:30 AM',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF494552),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Description
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                              height: 22 / 15,
                            ),
                            children: const [
                              TextSpan(text: 'Time for '),
                              TextSpan(
                                text: 'Lisinopril 10mg',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF28006D),
                                ),
                              ),
                              TextSpan(
                                text:
                                    '. It is important to maintain your dosage schedule for hypertension management.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Action Buttons: "Mark as Taken" and "Snooze 15m"
                        if (_isMedicationTaken)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5F7F8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle, size: 16, color: Color(0xFF006971)),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    'Taken today at 8:30 AM',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF006971),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              // Primary "Mark as Taken"
                              GestureDetector(
                                onTap: _handleMarkAsTaken,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF006971),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/notif_check.svg',
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Mark as Taken',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Secondary "Snooze 15m"
                              GestureDetector(
                                onTap: _handleSnooze,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFF006971),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Snooze 15m',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF006971),
                                    ),
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
            ),
          ],
        ),
      ),
    ),
    );
  }

  /// Card 2: Emergency Alert Card (Figma node 20:23855)
  Widget _buildEmergencyAlertCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Left 6px Crimson Accent Stripe (Figma node 20:23868)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 6,
              child: Container(color: const Color(0xFFBA1A1A)),
            ),

            // Main Card Content
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Red Alert Shield Icon Container (Figma node 20:23857)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/notif_alert_shield.svg',
                        width: 20,
                        height: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content and CTA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Emergency Alert',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0B1C30),
                                  height: 24 / 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '11:15 AM',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF494552),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Alert Body
                        Text.rich(
                          TextSpan(
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                              height: 22 / 15,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Security Update: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFBA1A1A),
                                ),
                              ),
                              TextSpan(
                                text:
                                    'New Login detected from NYC. If this wasn\'t you, please secure your account immediately.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Full-Width CTA: "Review Activity Details" (Figma node 20:23866)
                        GestureDetector(
                          onTap: _handleReviewActivity,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFA44CFF),
                                  Color(0xFF5B14B8),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x265B14B8),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Review Activity Details',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 2: "Recent" Header (Figma node 20:23870)
  Widget _buildRecentSectionHeader() {
    return Text(
      'Recent',
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF28006D),
        height: 24 / 16,
      ),
    );
  }

  /// Card 3: Medical Record Added Card (Figma node 20:23872)
  Widget _buildMedicalRecordAddedCard() {
    return _buildRecentCard(
      iconBackground: const Color(0xFFE8DDFF),
      iconPath: 'assets/icons/notif_medical_record.svg',
      iconWidth: 20,
      iconHeight: 25,
      title: 'Medical Record Added',
      timestamp: 'Yesterday',
      content: Text(
        'Annual Blood Panel results are now available for your review in the vault.',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF494552),
          height: 22 / 15,
        ),
      ),
    );
  }

  /// Card 4: Family Consent Approved Card (Figma node 20:23883)
  Widget _buildFamilyConsentApprovedCard() {
    return _buildRecentCard(
      iconBackground: const Color(0xFFE5EEFF),
      iconPath: 'assets/icons/notif_family_consent.svg',
      iconWidth: 26,
      iconHeight: 20,
      title: 'Family Consent Approved',
      timestamp: '2 days ago',
      content: Text.rich(
        TextSpan(
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 22 / 15,
          ),
          children: const [
            TextSpan(
              text: 'Sarah Jenkins',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: ' has approved your access request to her medical records.',
            ),
          ],
        ),
      ),
    );
  }

  /// Card 5: Insurance Policy Notice Card (Figma node 20:23896)
  Widget _buildInsuranceNoticeCard() {
    return _buildRecentCard(
      iconBackground: const Color(0xFFFFDAD8),
      iconPath: 'assets/icons/notif_insurance_notice.svg',
      iconWidth: 20,
      iconHeight: 25,
      title: 'Insurance Policy Notice',
      timestamp: '3 days ago',
      content: Text.rich(
        TextSpan(
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 22 / 15,
          ),
          children: const [
            TextSpan(text: 'Your '),
            TextSpan(
              text: 'Global Shield',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: ' policy expires in 30 days. Renew now to avoid coverage gaps.',
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Card Layout for Recent Section Cards
  Widget _buildRecentCard({
    required Color iconBackground,
    required String iconPath,
    required double iconWidth,
    required double iconHeight,
    required String title,
    required String timestamp,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
          width: 1.0,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: iconWidth,
                height: iconHeight,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1C30),
                          height: 24 / 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timestamp,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF494552),
                        height: 20 / 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                content,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Empty State when a filter has no items
  Widget _buildEmptyFilterState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFE5EEFF),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.notifications_none, size: 28, color: Color(0xFF28006D)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications in "$_selectedFilter"',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'You are all caught up for this category.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
        ],
      ),
    );
  }
}
