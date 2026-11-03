import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/appointment_models.dart';

/// Pixel-perfect modal bottom sheet & standalone page for
/// Care ID - Cancel Confirmation Dialog (Figma Node 20:30384).
class CancelAppointmentDialog extends StatelessWidget {
  final PatientAppointment appointment;
  final VoidCallback? onConfirmCancel;
  final VoidCallback? onDismiss;

  const CancelAppointmentDialog({
    super.key,
    required this.appointment,
    this.onConfirmCancel,
    this.onDismiss,
  });

  static Future<bool?> show(
    BuildContext context, {
    required PatientAppointment appointment,
    VoidCallback? onConfirmCancel,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x99213145), // rgba(33,49,69,0.6)
      builder: (ctx) => CancelAppointmentDialog(
        appointment: appointment,
        onConfirmCancel: () {
          Navigator.of(ctx).pop(true);
          onConfirmCancel?.call();
        },
        onDismiss: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 50,
            offset: Offset(0, -12),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag Handle Indicator
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0x99CBC4D4),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          const SizedBox(height: 20),

          // Warning Cancel Badge Icon
          _buildWarningBadge(),
          const SizedBox(height: 16),

          // Heading 2 - Dialog Title
          Text(
            'Cancel Appointment?',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
              letterSpacing: -0.6,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 8),

          // Explanatory Text
          _buildExplanatoryText(),
          const SizedBox(height: 16),

          // Reassuring Notice Box
          _buildNoticeBox(),
          const SizedBox(height: 24),

          // Action Buttons: Destructive Cancel + Keep Appointment
          _buildActionButtons(context),
          const SizedBox(height: 16),

          // Secure Care ID Micro-trust Indicator
          _buildTrustIndicator(),
        ],
      ),
    );
  }

  Widget _buildWarningBadge() {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Outer Soft Red Circle
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDAD6),
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
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0x1ABA1A1A),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/49722bc5437e3be5f7a780d518fc7f0d64d8c69f.svg',
                width: 23,
                height: 25,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFBA1A1A),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // Top-right Red Alert Badge with Exclamation Mark
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFBA1A1A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/2707f130df1b8eabc77a1c8c92c82b4c3b361bc8.svg',
                width: 3,
                height: 11,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanatoryText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 1.5,
          ),
          children: [
            const TextSpan(text: 'Are you sure you want to cancel your\nconsultation with '),
            TextSpan(
              text: appointment.doctor.name,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const TextSpan(text: '\nscheduled for '),
            TextSpan(
              text: 'Thu, Nov ${appointment.appointmentDate.day}, 2023 at ${appointment.timeSlot}',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
              ),
            ),
            TextSpan(
              text: ' at ${appointment.doctor.clinic}?',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/c3331490fd01470a5225c86be102676db21f9230.svg',
            width: 17,
            height: 19,
            colorFilter: const ColorFilter.mode(
              Color(0xFF28006D),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your reserved slot will be released. You can book a new consultation anytime through the Doctors Directory.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF494552),
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: 'Important: '),
                      TextSpan(
                        text: '3 or more cancellations',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const TextSpan(
                        text: ' will prevent you from booking future appointments online. You will only be seen on a ',
                      ),
                      TextSpan(
                        text: 'walk-in basis',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B1C30),
                        ),
                      ),
                      const TextSpan(text: '.'),
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

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Destructive Action: Cancel Appointment (2) Remaining
        GestureDetector(
          onTap: () {
            if (onConfirmCancel != null) {
              onConfirmCancel!();
            } else {
              Navigator.of(context).pop(true);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFBA1A1A),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/d2d2898472cb640a3b26ffbbf92696349852c9f5.svg',
                  width: 17,
                  height: 17,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Cancel Appointment (2) Remaining',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.35,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Keep Appointment Button
        GestureDetector(
          onTap: () {
            if (onDismiss != null) {
              onDismiss!();
            } else {
              Navigator.of(context).pop(false);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Center(
              child: Text(
                'Keep Appointment',
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

  Widget _buildTrustIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/22f0ac81a63b324515a061618adb6cc91e14af47.svg',
          width: 11,
          height: 13,
          colorFilter: const ColorFilter.mode(
            Color(0xCC494552),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'CareID HIPAA Protected Patient Action',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xCC494552),
          ),
        ),
      ],
    );
  }
}

/// Standalone page wrapper so the dialog can be opened and tested directly via route
class CancelAppointmentPage extends StatelessWidget {
  final PatientAppointment? appointment;

  const CancelAppointmentPage({super.key, this.appointment});

  @override
  Widget build(BuildContext context) {
    final defaultApt = appointment ??
        PatientAppointment(
          id: 'CR-89421',
          doctor: const Doctor(
            id: 'doc-1',
            name: 'Dr. Sarah Jenkins',
            specialty: 'Cardiovascular Specialist',
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
            title: 'In-Person Consultation',
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

    return Scaffold(
      backgroundColor: const Color(0x99213145),
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CancelAppointmentDialog(
            appointment: defaultApt,
            onConfirmCancel: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Appointment ${defaultApt.id} has been cancelled.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13),
                  ),
                  backgroundColor: const Color(0xFFBA1A1A),
                ),
              );
            },
            onDismiss: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }
}
