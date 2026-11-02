import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 38: Family Dashboard (Figma node 20:21675)
/// Exact implementation matching Figma node 20:21675
class FamilyDashboardPage extends StatefulWidget {
  const FamilyDashboardPage({super.key});

  @override
  State<FamilyDashboardPage> createState() => _FamilyDashboardPageState();
}

class _FamilyDashboardPageState extends State<FamilyDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: _buildTopAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section - Family Overview Card (Bento Style)
            _buildFamilyOverviewSection(context),

            const SizedBox(height: 24),

            // Section - Quick Actions Grid
            _buildQuickManagementSection(context),

            const SizedBox(height: 24),

            // Section - Recent Activity List
            _buildRecentActivitySection(context),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(currentIndex: 2),
    );
  }

  PreferredSizeWidget _buildTopAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FF).withValues(alpha: 0.8),
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                    }
                  },
                  borderRadius: BorderRadius.circular(9999),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Color(0xFF28006D),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Family Management',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/care_id_logo_wordmark.png',
                  height: 20,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
                const SizedBox(width: 12),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded,
                          size: 24, color: Color(0xFF28006D)),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBA1A1A),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.smartHealthCard),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF3F1D8B), width: 2),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/patient_avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyOverviewSection(BuildContext context) {
    return Column(
      children: [
        // Card 1: Family Ecosystem Bento
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFCBC4D4).withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Ambient Decorative glow in bottom right
              Positioned(
                bottom: -48,
                right: -48,
                width: 192,
                height: 192,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF28006D).withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Family Ecosystem',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Securely manage and monitor the health data of your loved ones in one centralized clinical vault.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.familyMemberList);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '04',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF28006D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'TOTAL\nMEMBERS',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                  color: const Color(0xFF7A7583),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        Container(
                          width: 1,
                          height: 48,
                          color: const Color(0xFFCBC4D4).withValues(alpha: 0.3),
                        ),
                        const SizedBox(width: 32),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.sharedMedicalRecords);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.folder_shared_outlined,
                                size: 20,
                                color: Color(0xFF28006D),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'SHARED\nRECORDS',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                  color: const Color(0xFF7A7583),
                                ),
                              ),
                            ],
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

        const SizedBox(height: 16),

        // Card 2: Pending Consent Requests
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF3F1D8B),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.security_update_warning_rounded,
                    color: Color(0xFFAB8EFD),
                    size: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'Action Required',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '02',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFAB8EFD),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pending Consent Requests',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFAB8EFD),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF28006D),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.familyConsentRequests);
                  },
                  child: Text(
                    'Review Requests',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickManagementSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Management',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildQuickActionButton(
              context: context,
              icon: Icons.person_add_alt_1_rounded,
              iconColor: const Color(0xFF006971),
              iconBgColor: const Color(0xFF006971).withValues(alpha: 0.1),
              title: 'Add Family Member',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addFamilyMemberForm);
              },
            ),
            const SizedBox(height: 12),
            _buildQuickActionButton(
              context: context,
              icon: Icons.admin_panel_settings_outlined,
              iconColor: const Color(0xFF3F1D8B),
              iconBgColor: const Color(0xFF28006D).withValues(alpha: 0.1),
              title: 'Manage Permissions',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.memberPermissionsSharing);
              },
            ),
            const SizedBox(height: 12),
            _buildQuickActionButton(
              context: context,
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF006971),
              iconBgColor: const Color(0xFF75F2FE).withValues(alpha: 0.3),
              title: 'View Shared Records',
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.familyMemberList);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(icon, color: iconColor, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Color(0xFF7A7583),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Updates',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.familyMemberList);
              },
              child: Text(
                'See all',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF006971),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            // Activity Item 1
            _buildActivityItem(
              context: context,
              avatarBg: const Color(0xFFDCE9FF),
              avatarChild: const Icon(Icons.face_rounded, color: Color(0xFF1E88E5), size: 26),
              title: "Leo's Immunization\nRecord",
              timestamp: '2H AGO',
              description: "Pediatrician uploaded 'Annual Wellness Checkup' results.",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.sharedMedicalRecords);
              },
            ),
            const SizedBox(height: 12),

            // Activity Item 2
            _buildActivityItem(
              context: context,
              avatarBg: const Color(0xFFDCE9FF),
              avatarChild: const Icon(Icons.elderly_rounded, color: Color(0xFF3F1D8B), size: 26),
              title: "Grandpa Robert's\nConsent",
              timestamp: '6H AGO',
              description: "Medical access granted to 'Dental X-Ray' for 12 months.",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.familyConsentRequests);
              },
            ),
            const SizedBox(height: 12),

            // Activity Item 3
            _buildActivityItem(
              context: context,
              avatarBg: const Color(0xFFFFDAD8),
              avatarChild: const Icon(Icons.security_rounded, color: Color(0xFFBA1A1A), size: 24),
              title: "Security Audit\nCompleted",
              timestamp: 'YESTERDAY',
              description: "Family data encryption key rotated successfully.",
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.memberPermissionsSharing);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required Color avatarBg,
    required Widget avatarChild,
    required String title,
    required String timestamp,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4).withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: avatarBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: avatarChild),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0B1C30),
                                height: 1.25,
                              ),
                            ),
                          ),
                          Text(
                            timestamp,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF7A7583),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFF7A7583),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
