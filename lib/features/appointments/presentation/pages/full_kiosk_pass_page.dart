import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../domain/models/appointment_models.dart';

/// Care ID - Full Kiosk Pass (Figma Node 20:32906).
class FullKioskPassPage extends StatefulWidget {
  final PatientAppointment? appointment;

  const FullKioskPassPage({super.key, this.appointment});

  @override
  State<FullKioskPassPage> createState() => _FullKioskPassPageState();
}

class _FullKioskPassPageState extends State<FullKioskPassPage> {
  late PatientAppointment _appointment;

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment ??
        PatientAppointment(
          id: 'CR-89421',
          doctor: const Doctor(
            id: 'doc-1',
            name: 'Dr. Sarah Jenkins, MD',
            specialty: 'Cardiology & Internal Medicine',
            category: 'Medical',
            clinic: 'Mount Sinai Heart Center',
            avatarAsset: 'assets/images/doctor_sarah_jenkins.png',
            rating: 4.9,
            reviewsCount: 128,
            yearsExperience: 14,
            isVerified: true,
            address: '1190 5th Ave, Suite 400, New York, NY 10029',
            bio: 'Cardiology specialist at Mount Sinai Heart Center.',
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
          appointmentDate: DateTime(2023, 11, 16, 9, 30),
          timeSlot: '09:30 AM',
          status: AppointmentStatus.upcoming,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit: 'Annual preventative heart checkup',
          qrPassRef: 'KP-99214-MSH',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header Bar
            _buildHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Express Kiosk Pass Card
                    _buildHeroPassCard(),
                    const SizedBox(height: 20),

                    // Appointment & Patient Details Card
                    _buildAppointmentDetailsCard(),
                    const SizedBox(height: 20),

                    // Digital Wallet Actions (Apple Wallet & Google Pay)
                    _buildWalletActions(),
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

  /// Top Header Bar
  Widget _buildHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                    'assets/icons/1bfe57ee723235378a0f55572351939e59d586e7.svg',
                    width: 10,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF0B1C30),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Kiosk Pass',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
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
              'assets/icons/06fd47eda1fc00983910602db167e32fd76dea1a.svg',
              width: 4,
              height: 16,
              colorFilter: const ColorFilter.mode(
                Color(0xFF0B1C30),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hero Express Kiosk Pass Card
  Widget _buildHeroPassCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3F1D8B), Color(0xFF28006D)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(24),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative Background Watermark
            Positioned(
              right: -20,
              top: -20,
              child: Opacity(
                opacity: 0.08,
                child: SvgPicture.asset(
                  'assets/icons/1da8441be1ba00f12d9ca6a9d4d90ad0bc0c7285.svg',
                  width: 200,
                  height: 250,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pill Badge: Express Kiosk Pass
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/9f7275cdd1ff89859344f0af95b6d2ccbe07e754.svg',
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Express Kiosk Pass',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // High-Contrast QR Pass Container
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Sharp High-Contrast QR Pattern (for terminal laser / optical reading)
                        _buildHighContrastQrPattern(),
                        // Center Brand Emblem
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF28006D), width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.qr_code_2_rounded,
                            size: 28,
                            color: Color(0xFF28006D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Instruction Subtext
                  Text(
                    'Scan this code at the clinic kiosk for\nexpress check-in.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.4,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Pre-authorized Vault Records Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/d3634e2913712003a2da2200c5edec230e2510ee.svg',
                          width: 11,
                          height: 15,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pre-authorized with ${_appointment.vaultRecordsSynced} Care ID Vault records',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: -0.2,
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

  /// High Contrast QR Visual Pattern matching design node 20:32931
  Widget _buildHighContrastQrPattern() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQrCorner(),
            _buildQrDataBlock(),
            _buildQrCorner(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQrDataBlock(),
            const SizedBox(width: 44), // Center emblem space
            _buildQrDataBlock(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQrCorner(),
            _buildQrDataBlock(),
            _buildQrCorner(),
          ],
        ),
      ],
    );
  }

  Widget _buildQrCorner() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0B1C30), width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: const Color(0xFF0B1C30),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildQrDataBlock() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, color: const Color(0xFF0B1C30)),
            const SizedBox(width: 4),
            Container(width: 8, height: 8, color: Colors.transparent),
            const SizedBox(width: 4),
            Container(width: 8, height: 8, color: const Color(0xFF0B1C30)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, color: Colors.transparent),
            const SizedBox(width: 4),
            Container(width: 8, height: 8, color: const Color(0xFF0B1C30)),
            const SizedBox(width: 4),
            Container(width: 8, height: 8, color: Colors.transparent),
          ],
        ),
      ],
    );
  }

  /// Appointment & Patient Details Card
  Widget _buildAppointmentDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Doctor Row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: Image.asset(
                  'assets/images/doctor_sarah_jenkins.png',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: const Color(0xFF28006D),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _appointment.doctor.name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'assets/icons/4bbc43776708d25ad6b9d012620fee8094799684.svg',
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _appointment.doctor.specialty,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF1F4F9), thickness: 1, height: 1),
          const SizedBox(height: 16),

          // Detail Row 1: Appointment Time
          _buildDetailRow(
            iconAsset: 'assets/icons/5df430729f16be381d73258f2546d5351fefc201.svg',
            label: 'APPOINTMENT TIME',
            value: 'Thursday, Nov 16 • 09:30 AM',
          ),
          const SizedBox(height: 16),

          // Detail Row 2: Location
          _buildDetailRow(
            iconAsset: 'assets/icons/4c282d66aeba000af51dab6bacf90591801088dc.svg',
            label: 'LOCATION',
            value: '1190 5th Ave, Suite 400, New York, NY 10029',
          ),
          const SizedBox(height: 16),

          // Detail Row 3: Patient Info
          _buildDetailRow(
            iconAsset: 'assets/icons/4eb37b87e08e9a45a2f31da626493886126de722.svg',
            label: 'PATIENT INFO',
            customValueWidget: Row(
              children: [
                Text(
                  _appointment.patientName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _appointment.careIdNumber,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF00696B),
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

  Widget _buildDetailRow({
    required String iconAsset,
    required String label,
    String? value,
    Widget? customValueWidget,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF4FF),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconAsset,
            width: 16,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF28006D),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: const Color(0xFF494552),
                ),
              ),
              const SizedBox(height: 2),
              if (customValueWidget != null)
                customValueWidget
              else
                Text(
                  value ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                    height: 1.3,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Digital Wallet Actions (Apple Wallet & Google Pay)
  Widget _buildWalletActions() {
    return Column(
      children: [
        // Add to Apple Wallet Button
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Kiosk Pass added to Apple Wallet.'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/f1231a2829acd157845ee69559d4b4645dee0746.svg',
                  width: 18,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Add to Apple Wallet',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Add to Google Pay Button
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Kiosk Pass added to Google Pay.'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/gpay_logo_vector.png',
                  height: 22,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/gpay_g_logo.png',
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add to Google Pay',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3C4043),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

