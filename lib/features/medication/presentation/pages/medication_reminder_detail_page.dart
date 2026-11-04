import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../../../core/widgets/care_id_notification_button.dart';

/// Page 23: Medication Reminder Detail (Figma node 20:24101)
/// Canvas: Careid patient app (x: 10664, y: 0, width: 390, height: 862)
///
/// Features:
/// - Fixed Frosted Top App Bar with back navigation, CareID branding, and Patient Avatar
/// - Header title updated to "Medication Reminder" per user specification
/// - Hero Medication Card (#28006D deep purple) with Doctor profile and status badges
/// - Main Action buttons: "Reschedule" and "Skip Dose"
/// - Primary Action CTA: "Mark as Taken" gradient capsule button
/// - Pharmacy Info Card with City Health Apothecary details, direct call & routing
/// - Interactive Modals: Reschedule sheet, Skip Dose prompt, Refill Request sheet
/// - Persistent CareID Bottom Navigation Bar
class MedicationReminderDetailPage extends StatefulWidget {
  const MedicationReminderDetailPage({super.key});

  @override
  State<MedicationReminderDetailPage> createState() => _MedicationReminderDetailPageState();
}

class _MedicationReminderDetailPageState extends State<MedicationReminderDetailPage> {
  bool _isMarkedAsTaken = false;
  final String _collectionDate = '12/06';
  String _status = 'Pending';

  void _handleMarkAsTaken() {
    setState(() {
      _isMarkedAsTaken = true;
      _status = 'Taken';
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Dose marked as taken successfully!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF006971),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleReschedule() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        String selectedOption = 'Tomorrow 8:30 AM';
        return StatefulBuilder(
          builder: (context, setModalState) => SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBC4D4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Reschedule Dose Reminder',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose when you would like to be reminded for this medication.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF494552),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...[
                    'In 2 Hours (10:30 AM)',
                    'Tonight (8:00 PM)',
                    'Tomorrow 8:30 AM',
                    'Custom Time...',
                  ].map(
                        (option) => InkWell(
                      onTap: () {
                        setModalState(() => selectedOption = option);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedOption == option
                                      ? const Color(0xFF006971)
                                      : const Color(0xFF7A7583),
                                  width: 2,
                                ),
                              ),
                              child: selectedOption == option
                                  ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF006971),
                                  ),
                                ),
                              )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              option,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0B1C30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Reminder rescheduled to $selectedOption',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: const Color(0xFF006971),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006971),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Confirm Reschedule',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSkipDose() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Skip This Dose?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF28006D),
          ),
        ),
        content: Text(
          'Are you sure you want to skip this dose? Skipping will be logged in your adherence history.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF494552),
            height: 1.4,
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              setState(() {
                _status = 'Skipped';
              });
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Dose marked as skipped.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: const Color(0xFF7A7583),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Skip Dose',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCallPharmacy() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Dialing City Health Apothecary: (555) 019-2834...',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006D76),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handlePharmacyDirections() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Pharmacy Route Navigation',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF28006D),
          ),
        ),
        content: Text(
          'Destination: City Health Apothecary\n425 Clinical Way, Suite 200\nEstimated arrival: 8 mins (2.1 miles)',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF494552),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening map navigation app...',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: const Color(0xFF006971),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006971),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Start Navigation',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRequestRefill() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBC4D4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Request Prescription Refill',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We will send a refill authorization request directly to Dr. Sarah Jenkins and City Health Apothecary.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF494552),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCBC4D4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lisinopril 10mg Tablets',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Refills remaining: 2 • 30 Day Supply',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Refill request submitted to Dr. Sarah Jenkins.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: const Color(0xFF006971),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28006D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit Refill Request',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              key: const Key('medication_reminder_scroll_view'),
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 76, 16, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 358),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: Hero Medication Card (Figma node 20:24103)
                      _buildHeroCard(),

                      const SizedBox(height: 24),

                      // Section 2: Main Secondary Actions (Figma node 20:24125)
                      _buildMainActions(),

                      const SizedBox(height: 24),

                      // Section 3: Mark as Taken Primary CTA (Figma node 20:24135)
                      _buildMarkAsTakenButton(),

                      const SizedBox(height: 24),

                      // Section 4: Pharmacy Info Card (Figma node 20:24138)
                      _buildPharmacyInfoCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Top Header App Bar (Figma node 20:24163)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),
        ],
      ),

      // Persistent Unified Bottom Navigation Bar (Figma node 20:24174)
      bottomNavigationBar: const CareIDBottomNavBar(
        currentIndex: 0,
      ),
    );
  }

  /// Top App Bar (Figma node 20:24163)
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
                color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Group: Back Chevron + "Medication Reminder" Title + Badge
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      key: const Key('medication_back_button'),
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
                    Flexible(
                      child: Text(
                        'Medication Reminder',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF28006D),
                          letterSpacing: -0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
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
              ),
              const SizedBox(width: 8),

              // Right Group: Notification Bell + Patient Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CareIDNotificationButton(),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.profileSettingsHub);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD3E4FE),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section 1: Hero Medication Card (Figma node 20:24103)
  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF28006D),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Doctor Info + Stethoscope Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Sarah Jenkins',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 32 / 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cardiology & Internal Medicine',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE8DDFF),
                        height: 20 / 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                'assets/icons/medication_stethoscope.svg',
                width: 42,
                height: 48,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Badges Row: "Collect by: 12/06" + "Pending" (Figma node 20:24114)
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Collect by pill badge (Figma node 20:24115)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/medication_calendar_clock.svg',
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Collect by: $_collectionDate',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Status badge (Figma node 20:24120)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _status == 'Taken'
                      ? const Color(0xFF006971)
                      : (_status == 'Skipped' ? const Color(0xFF7A7583) : const Color(0xFFBA1A1A)),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/medication_pending_alert.svg',
                        width: 11.4,
                        height: 11.7,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _status,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          height: 24 / 16,
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

  /// Section 2: Main Actions (Reschedule & Skip Dose) (Figma node 20:24125)
  Widget _buildMainActions() {
    return Row(
      children: [
        // Reschedule Button (Figma node 20:24127)
        Expanded(
          child: GestureDetector(
            key: const Key('medication_reschedule_button'),
            onTap: _handleReschedule,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF006971), width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/medication_reschedule.svg',
                        width: 12.25,
                        height: 12.83,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reschedule',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF006971),
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Skip Dose Button (Figma node 20:24131)
        Expanded(
          child: GestureDetector(
            key: const Key('medication_skip_dose_button'),
            onTap: _handleSkipDose,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF7A7583), width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/medication_skip_dose.svg',
                        width: 7.58,
                        height: 7,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Skip Dose',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Section 3: Mark as Taken Primary CTA (Figma node 20:24135)
  Widget _buildMarkAsTakenButton() {
    return GestureDetector(
      key: const Key('medication_mark_as_taken_button'),
      onTap: _handleMarkAsTaken,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
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
              color: Color(0x3328006D),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/medication_check_taken.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              _isMarkedAsTaken ? 'Taken Today' : 'Mark as Taken',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 4: Pharmacy Info Card (Figma node 20:24138)
  Widget _buildPharmacyInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCFBDFF).withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header: Capsule Icon + "Pharmacy Info"
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8DDFF),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/medication_pharmacy_capsule.svg',
                    width: 18,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Pharmacy Info',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF28006D),
                  height: 24 / 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Inner White Card: Apothecary Details & Action Buttons (Figma node 20:24145)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City Health Apothecary',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF0B1C30),
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '425 Clinical Way, Suite 200',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Right Actions: Call & Directions Buttons (Figma node 20:24151)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Call Button
                    GestureDetector(
                      key: const Key('medication_call_pharmacy_button'),
                      onTap: _handleCallPharmacy,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF75F2FE),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/medication_call_pharmacy.svg',
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Directions Button
                    GestureDetector(
                      key: const Key('medication_pharmacy_directions_button'),
                      onTap: _handlePharmacyDirections,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF75F2FE),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/medication_directions.svg',
                            width: 16.67,
                            height: 16.67,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Request Refill Action Button (Figma node 20:24158)
          GestureDetector(
            key: const Key('medication_request_refill_button'),
            onTap: _handleRequestRefill,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request Refill',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF28006D),
                      height: 24 / 16,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/medication_refill_chevron.svg',
                    width: 7.4,
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}