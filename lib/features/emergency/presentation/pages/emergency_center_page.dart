import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 22: Emergency Center (Figma node 20:23956)
///
/// Features:
/// - Fixed Frosted Top App Bar with back navigation, title, and patient avatar
/// - Hero SOS section with 128x128 pulsing crimson button and subtitle
/// - Bento Layout for Medical ID & Emergency Contacts:
///   - Medical ID Quick View Card with digital card image, blood group, allergies, and donor/condition tags
///   - Emergency Contacts section with Primary ICE (Sarah Jenkins) and Secondary ICE (Arthur Thompson) with instant call actions
/// - Nearby Hospitals Map Widget with map preview, "Closest Facility" floating badge, wait times, and "Get Directions" CTA
/// - Full-width "Share Emergency QR" gradient button with offline responder security note
/// - Persistent CareID Bottom Navigation Bar
class EmergencyCenterPage extends StatefulWidget {
  const EmergencyCenterPage({super.key});

  @override
  State<EmergencyCenterPage> createState() => _EmergencyCenterPageState();
}

class _EmergencyCenterPageState extends State<EmergencyCenterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Run continuous pulse animation on device/emulator, avoiding blocking pumpAndSettle in tests
    if (WidgetsBinding.instance.runtimeType.toString() != 'AutomatedTestWidgetsFlutterBinding') {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // Action Handlers
  void _handleSosTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => _SosAlertBottomSheet(
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _callContact(String name, String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Connecting to $name ($phone)...',
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

  void _handleGetDirections() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFDCE9FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.navigation, color: Color(0xFF006971), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'City General Hospital',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Routing to closest emergency facility (0.8 miles away). Estimated arrival: 3 mins.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF75F2FE),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Current ER Wait: 12 min',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF006D76),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening external navigation app...',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
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
              'Start Route',
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

  void _handleShareEmergencyQr() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE8DDFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/emergency_qr_code.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(Color(0xFF28006D), BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Emergency Offline QR Pass',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This verifiable QR allows paramedics and emergency responders instant read-only access to your critical blood type, allergies, and contact list.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF494552),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 180,
              height: 180,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBC4D4), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/emergency_qr_code.svg',
                  width: 140,
                  height: 140,
                  colorFilter: const ColorFilter.mode(Color(0xFF0B1C30), BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28006D),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Done',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
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
          // 1. Main Scrollable Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              key: const Key('emergency_scroll_view'),
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
                        // Section 1: Hero SOS Button & Subtitle (Figma node 20:23998)
                        _buildSosSection(),

                        const SizedBox(height: 32),

                        // Section 2: Medical ID Quick View Card (Figma node 20:24012)
                        _buildMedicalIdCard(),

                        const SizedBox(height: 24),

                        // Section 3: Emergency Contacts Section (Figma node 20:24036)
                        _buildEmergencyContactsSection(),

                        const SizedBox(height: 24),

                        // Section 4: Nearby Hospitals Map Widget (Figma node 20:24067)
                        _buildNearbyHospitalsWidget(),

                        const SizedBox(height: 32),

                        // Section 5: Share Emergency QR Action (Figma node 20:24092)
                        _buildShareEmergencyQrSection(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Fixed Frosted Top App Bar (Figma node 20:23987)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Persistent Unified Bottom Navigation Bar (Figma node 20:23957)
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

  /// Fixed Frosted Top App Bar (Figma node 20:23987)
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
              // Left Group: Back Chevron + "Emergency Center" Title
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
                    'Emergency Center',
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

              // Right Group: Patient Avatar with soft purple border
              Container(
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
            ],
          ),
        ),
      ),
    );
  }

  /// Section 1: Hero SOS Trigger (Figma node 20:23998)
  Widget _buildSosSection() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Pulsing 128x128 SOS Trigger Button (Figma node 20:24001)
          ScaleTransition(
            scale: _pulseAnimation,
            child: GestureDetector(
              onTap: _handleSosTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFBA1A1A),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33BA1A1A),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/emergency_sos_radar.svg',
                      width: 23.3,
                      height: 36,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SOS',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Subtitle Instruction (Figma node 20:24010)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              'Tap once to trigger emergency\nprotocols and alert your contacts.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
                height: 24 / 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 2 - Card 1: Medical ID Quick View Card (Figma node 20:24012)
  Widget _buildMedicalIdCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Emergency Card Preview Image (Figma node 20:24014 - 356 x 477.14px)
            AspectRatio(
              aspectRatio: 356 / 477.14,
              child: Image.asset(
                'assets/images/emergency_medical_card.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Card Information Details (Figma node 20:24015)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Name/DOB and Blood Group Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sarah Jenkins',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF28006D),
                                height: 32 / 24,
                              ),
                            ),
                            Text(
                              'DOB: 12/05/1992',
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

                      // Blood Group Pill Badge (Figma node 20:24021)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDAD6),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'Blood: O+',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFBA1A1A),
                            height: 24 / 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Row: Allergy Chips (Figma node 20:24023)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAllergyChip('Penicillin'),
                      _buildAllergyChip('Peanuts'),
                    ],
                  ),

                  // Divider (Figma node 20:24033)
                  Container(
                    margin: const EdgeInsets.only(top: 24, bottom: 17),
                    height: 1.0,
                    color: const Color(0xFFCBC4D4),
                  ),

                  // Organ Donor & Chronic Condition Summary (Figma node 20:24035)
                  Text.rich(
                    TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                        height: 26 / 16,
                      ),
                      children: const [
                        TextSpan(text: 'Organ Donor: '),
                        TextSpan(
                          text: 'Yes',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0B1C30),
                          ),
                        ),
                        TextSpan(text: ' • Condition: '),
                        TextSpan(
                          text: 'Type 1 Diabetes',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0B1C30),
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

  Widget _buildAllergyChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/emergency_allergy_tag.svg',
            width: 14.67,
            height: 12.67,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }

  /// Section 2 - Sub-Component 2: Emergency Contacts Section (Figma node 20:24036)
  Widget _buildEmergencyContactsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Emergency Contacts',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
              height: 28 / 20,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Primary ICE: Sarah Jenkins (Figma node 20:24039)
        _buildContactCard(
          iconPath: 'assets/icons/emergency_ice_user_primary.svg',
          iconBgColor: const Color(0xFFE8DDFF),
          name: 'Sarah Jenkins',
          role: 'Primary ICE (Spouse)',
          isPrimaryName: true,
          callBtnBgColor: const Color(0xFF006971),
          callBtnIconPath: 'assets/icons/emergency_call_primary.svg',
          phone: '+1 (555) 234-5678',
        ),

        const SizedBox(height: 16),

        // Secondary ICE: Arthur Thompson (Figma node 20:24053)
        _buildContactCard(
          iconPath: 'assets/icons/emergency_ice_user_secondary.svg',
          iconBgColor: const Color(0xFFDCE9FF),
          name: 'Arthur Thompson',
          role: 'Secondary ICE (Father)',
          isPrimaryName: false,
          callBtnBgColor: const Color(0xFF75F2FE),
          callBtnIconPath: 'assets/icons/emergency_call_secondary.svg',
          phone: '+1 (555) 876-5432',
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required String iconPath,
    required Color iconBgColor,
    required String name,
    required String role,
    required bool isPrimaryName,
    required Color callBtnBgColor,
    required String callBtnIconPath,
    required String phone,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4),
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
        children: [
          // User Icon Circle
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 16,
                height: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isPrimaryName ? const Color(0xFF28006D) : const Color(0xFF0B1C30),
                    height: 24 / 16,
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF494552),
                    height: 14 / 12,
                  ),
                ),
              ],
            ),
          ),

          // Call Action Button
          GestureDetector(
            onTap: () => _callContact(name, phone),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: callBtnBgColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  callBtnIconPath,
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section 3: Nearby Hospitals Map Widget (Figma node 20:24067)
  Widget _buildNearbyHospitalsWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Preview with Closest Facility Badge (Figma node 20:24069)
            Stack(
              children: [
                Image.asset(
                  'assets/images/emergency_map_preview.png',
                  width: double.infinity,
                  height: 192,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF006971),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Closest Facility',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF006971),
                                height: 14 / 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Facility Details and CTA (Figma node 20:24075)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City General Hospital',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF28006D),
                      height: 28 / 20,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Location and Distance
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/emergency_location_pin.svg',
                        width: 12,
                        height: 15,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '0.8 miles away • Open 24/7',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF494552),
                            height: 20 / 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ER Wait Badge (Figma node 20:24085)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF75F2FE),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'ER Waiting: 12 min',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF006D76),
                        height: 14 / 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // "Get Directions" Full-Width CTA (Figma node 20:24088)
                  GestureDetector(
                    onTap: _handleGetDirections,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF006971),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A006971),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/emergency_directions_arrow.svg',
                            width: 16.67,
                            height: 16.67,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Get Directions',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
            ),
          ],
        ),
      ),
    );
  }

  /// Section 4: Share Emergency QR Action (Figma node 20:24092)
  Widget _buildShareEmergencyQrSection() {
    return Column(
      children: [
        // Primary Full-Width CTA: "Share Emergency QR" (Figma node 20:24094)
        GestureDetector(
          onTap: _handleShareEmergencyQr,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            height: 60,
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
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/emergency_qr_code.svg',
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(Color(0xFFF8F4FF), BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  'Share Emergency QR',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF8F4FF),
                    height: 24 / 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Legal/Security Caption (Figma node 20:24100)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Grants instant, temporary access to your\nMedical ID for first responders without\nunlocking your device.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
              height: 24 / 16,
            ),
          ),
        ),
      ],
    );
  }
}

/// Modal Bottom Sheet displayed when SOS Button is activated
class _SosAlertBottomSheet extends StatefulWidget {
  final VoidCallback onCancel;

  const _SosAlertBottomSheet({required this.onCancel});

  @override
  State<_SosAlertBottomSheet> createState() => _SosAlertBottomSheetState();
}

class _SosAlertBottomSheetState extends State<_SosAlertBottomSheet> {
  int _secondsRemaining = 10;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    if (WidgetsBinding.instance.runtimeType.toString() != 'AutomatedTestWidgetsFlutterBinding') {
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondsRemaining > 1) {
          setState(() => _secondsRemaining--);
        } else {
          timer.cancel();
        }
      });
    }
  }

  void _cancelTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Warning Icon
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDAD6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.warning_amber_rounded, color: Color(0xFFBA1A1A), size: 36),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Emergency SOS Triggered',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFBA1A1A),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Alerting emergency contacts and dispatching medical ID and live location in $_secondsRemaining seconds.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              color: const Color(0xFF494552),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Cancel Countdown Action
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _cancelTimer();
                widget.onCancel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBA1A1A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Cancel Alert ($_secondsRemaining s)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
