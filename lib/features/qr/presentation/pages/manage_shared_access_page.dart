import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 19: Manage Shared Access (Figma node 20:23597)
///
/// Complete security controls for shared health access:
/// - Frosted Top App Bar with back navigation, "Manage Access" title, user avatar
/// - Header Hero Banner: "Secure Sharing Hub" with deep violet gradient
/// - Section: Currently Shared (1 Active, Dr. Marcus Thorne, Full Access, Live status, Revoke Access)
/// - Section: Pending Requests (Metro General Lab, Requested: Lab Results Only, Approve / Decline)
/// - Section: Recent Sessions (St. Jude Radiology, Dr. Sarah Jenkins, PhysioCare Clinic with Extend action)
/// - Unified Frosted Bottom Navigation Bar
class ManageSharedAccessPage extends StatefulWidget {
  const ManageSharedAccessPage({super.key});

  @override
  State<ManageSharedAccessPage> createState() => _ManageSharedAccessPageState();
}

class _ManageSharedAccessPageState extends State<ManageSharedAccessPage> {
  bool _isMarcusActive = true;
  bool _isMetroPending = true;

  void _handleRevokeAccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Revoke Access?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
        content: Text(
          'Dr. Marcus Thorne will immediately lose access to your medical history and clinical records.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _isMarcusActive = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Access for Dr. Marcus Thorne revoked successfully.',
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Revoke',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleApprovePending() {
    setState(() => _isMetroPending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Metro General Lab access approved.',
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

  void _handleDeclinePending() {
    setState(() => _isMetroPending = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Metro General Lab request declined.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF494552),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleExtendSession(String sessionName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Extended temporary access for $sessionName by 24h.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF5B14B8),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Scrollable Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
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
                        const SizedBox(height: 8),

                        // Section 1: Header Hero Banner
                        _buildHeaderHeroBanner(),

                        const SizedBox(height: 24),

                        // Section 2: Currently Shared
                        _buildCurrentlySharedSection(),

                        const SizedBox(height: 24),

                        // Section 3: Pending Requests
                        if (_isMetroPending) ...[
                          _buildPendingRequestsSection(),
                          const SizedBox(height: 24),
                        ],

                        // Section 4: Recent Sessions
                        _buildRecentSessionsSection(),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Fixed Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Persistent Unified Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: 1),
          ),
        ],
      ),
    );
  }

  /// Fixed Glassmorphic Top App Bar (Figma node 20:23628)
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
              // Left Group: Back Arrow Button + Title
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
                    'Manage Access',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Right Group: Patient Avatar with circular border
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3F1D8B),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF28006D).withValues(alpha: 0.10),
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

  /// Section 1: Header Hero Banner (Figma node 20:23638)
  Widget _buildHeaderHeroBanner() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 192),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0828006D),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xCC3F1D8B), // rgba(63, 29, 139, 0.80) 0%
              Color(0x003F1D8B), // rgba(63, 29, 139, 0.00) 100%
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Secure Sharing Hub',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 32 / 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Control who sees your medical history with clinical precision and encryption-backed safety.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.80),
                height: 24 / 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section 2: CURRENTLY SHARED Section (Figma node 20:23645)
  Widget _buildCurrentlySharedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row: "CURRENTLY SHARED" + "1 Active"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CURRENTLY SHARED',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
                letterSpacing: 0.7,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF28006D).withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                _isMarcusActive ? '1 Active' : '0 Active',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                  height: 16 / 12,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        if (!_isMarcusActive)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFCBC4D4)),
            ),
            child: Text(
              'No active sharing sessions.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          )
        else
          // Active Card (Dr. Marcus Thorne)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.70),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Avatar + Details & Live Status Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD3E4FE),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/manage_stethoscope.svg',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dr. Marcus Thorne',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0B1C30),
                                        height: 20 / 20,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Cardiology Specialist',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF494552),
                                        height: 20 / 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Live Status Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF75F2FE).withValues(alpha: 0.30),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF006971),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Live',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF006971),
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Middle Box: Full Access + Active for 18h
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/manage_shield_access.svg',
                                width: 14,
                                height: 8,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Full Access',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0B1C30),
                                  height: 14 / 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/manage_clock_duration.svg',
                                width: 11,
                                height: 13,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Active for 18h',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0B1C30),
                                  height: 14 / 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Revoke Access Action Button
                    GestureDetector(
                      onTap: _handleRevokeAccess,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFBA1A1A).withValues(alpha: 0.20),
                            width: 2.0,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Revoke Access',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFBA1A1A),
                            letterSpacing: 0.28,
                            height: 16 / 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Section 3: PENDING REQUESTS Section (Figma node 20:23678)
  Widget _buildPendingRequestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PENDING REQUESTS',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
            letterSpacing: 0.7,
          ),
        ),

        const SizedBox(height: 16),

        // Request Card (Metro General Lab) with teal left accent border
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.70),
                borderRadius: BorderRadius.circular(20),
                border: const Border(
                  left: BorderSide(color: Color(0xFF006971), width: 4.0),
                  top: BorderSide(color: Color(0xFF006971), width: 1.0),
                  right: BorderSide(color: Color(0xFF006971), width: 1.0),
                  bottom: BorderSide(color: Color(0xFF006971), width: 1.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A006971),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Circular Avatar + Details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFF006971).withValues(alpha: 0.10),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF006971).withValues(alpha: 0.20),
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/manage_lab_flask.svg',
                            width: 33,
                            height: 32,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Metro General Lab',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0B1C30),
                                height: 28 / 20,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Requested: Lab Results Only',
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
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Actions Row: Approve & Decline
                  Row(
                    children: [
                      // Approve Button (Solid Teal)
                      Expanded(
                        child: GestureDetector(
                          onTap: _handleApprovePending,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF006971),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33006971),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Approve',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.28,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Decline Button (Soft Blue)
                      GestureDetector(
                        onTap: _handleDeclinePending,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3E4FE).withValues(alpha: 0.50),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Decline',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF494552),
                              letterSpacing: 0.28,
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
        ),
      ],
    );
  }

  /// Section 4: RECENT SESSIONS Section (Figma node 20:23699)
  Widget _buildRecentSessionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECENT SESSIONS',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
            letterSpacing: 0.7,
          ),
        ),

        const SizedBox(height: 16),

        // Multi-Session Card Container
        Container(
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
          child: Column(
            children: [
              _buildSessionItem(
                title: 'St. Jude Radiology',
                subtitle: 'Expired 2 days ago • Imaging Docs',
                hasBorderTop: false,
              ),
              _buildSessionItem(
                title: 'Dr. Sarah Jenkins',
                subtitle: 'Expired 1 week ago • Prescriptions',
                hasBorderTop: true,
              ),
              _buildSessionItem(
                title: 'PhysioCare Clinic',
                subtitle: 'Expired 2 weeks ago • Full Access',
                hasBorderTop: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Single Session Item inside the Recent Sessions container
  Widget _buildSessionItem({
    required String title,
    required String subtitle,
    required bool hasBorderTop,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: hasBorderTop
            ? Border(
                top: BorderSide(
                  color: const Color(0xFFCBC4D4).withValues(alpha: 0.15),
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Icon + Title & Subtitle
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5EEFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/manage_doc_icon.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF0B1C30),
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right: "Extend" Action Button
          GestureDetector(
            onTap: () => _handleExtendSession(title),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/manage_extend_arrow.svg',
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Extend',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF28006D),
                      letterSpacing: 0.28,
                    ),
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
