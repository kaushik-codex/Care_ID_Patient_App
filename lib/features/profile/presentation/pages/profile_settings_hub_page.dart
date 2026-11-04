import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Screen 78: Profile & Settings Hub
/// Node ID: 20:24204
class ProfileSettingsHubPage extends StatefulWidget {
  const ProfileSettingsHubPage({super.key});

  @override
  State<ProfileSettingsHubPage> createState() => _ProfileSettingsHubPageState();
}

class _ProfileSettingsHubPageState extends State<ProfileSettingsHubPage> {
  bool _biometricLoginEnabled = true;

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Log Out',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0B1C30),
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your CareID account?',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF494552),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            child: Text(
              'Logout',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Account',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFBA1A1A),
          ),
        ),
        content: Text(
          'This will irreversibly erase all your medical records and digital health cards. Are you sure you want to proceed?',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF494552),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF494552),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Account deletion request submitted.',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  backgroundColor: const Color(0xFFBA1A1A),
                ),
              );
            },
            child: Text(
              'Delete Forever',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF8F9FF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.only(
                top: 72,
                left: 16,
                right: 16,
                bottom: 110,
              ),
              children: [
                // Profile Header Card
                _buildProfileHeaderCard(),
                const SizedBox(height: 24),

                // Quick Health Summary Row (Horizontal scroll)
                _buildQuickHealthSummaryRow(),
                const SizedBox(height: 24),

                // Settings Groups
                _buildAccountSettingsGroup(),
                const SizedBox(height: 24),

                _buildMedicalInformationGroup(),
                const SizedBox(height: 24),

                _buildSecurityGroup(),
                const SizedBox(height: 24),

                _buildPrivacyGroup(),
                const SizedBox(height: 24),

                _buildApplicationGroup(),
                const SizedBox(height: 24),

                _buildAccountActionsGroup(),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Header - Top AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(context),
          ),

          // Bottom Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CareIDBottomNavBar(currentIndex: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              InkWell(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                  }
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCBC4D4).withOpacity(0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: Color(0xFF28006D),
                  ),
                ),
              ),

              // Title
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF28006D),
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

              // Bell Notification Button
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCBC4D4).withOpacity(0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 20,
                    color: Color(0xFF28006D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with ring and verified badge
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 128,
                height: 128,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF75F2FE),
                    width: 4,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/14813effe14780fdd6e4d6aee7b426079abfac8f.png',
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Image.asset(
                      'assets/images/patient_avatar.png',
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: const Color(0xFFEFF4FF),
                        child: const Icon(
                          Icons.person,
                          size: 64,
                          color: Color(0xFF28006D),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Verified Badge
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006971),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified,
                        size: 13,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'VERIFIED',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name
          Text(
            'Sarah Jenkins',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0B1C30),
            ),
          ),

          const SizedBox(height: 6),

          // Member Meta Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'HV-360-9928',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF494552),
                    letterSpacing: 0.28,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Member Since Jan 2024',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Edit Profile Button
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.profilePersonalDetails);
            },
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF28006D),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.edit_outlined,
                    size: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Edit Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  Widget _buildQuickHealthSummaryRow() {
    final items = [
      _SummaryCardData(
        icon: Icons.credit_card_outlined,
        label: 'Card',
        value: 'Active',
        bgColor: const Color(0xFF75F2FE).withOpacity(0.2),
        borderColor: const Color(0xFF75F2FE).withOpacity(0.4),
        iconColor: const Color(0xFF006D76),
        labelColor: const Color(0xFF006D76),
        valueColor: const Color(0xFF006D76),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.smartHealthCard),
      ),
      _SummaryCardData(
        icon: Icons.health_and_safety_outlined,
        label: 'Insurance',
        value: 'Verified',
        bgColor: const Color(0xFFD3E4FE).withOpacity(0.5),
        borderColor: const Color(0xFFCBC4D4),
        iconColor: const Color(0xFF28006D),
        labelColor: const Color(0xFF494552),
        valueColor: const Color(0xFF0B1C30),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.insuranceCardDetails),
      ),
      _SummaryCardData(
        icon: Icons.folder_shared_outlined,
        label: 'Records',
        value: '142',
        bgColor: const Color(0xFFD3E4FE).withOpacity(0.5),
        borderColor: const Color(0xFFCBC4D4),
        iconColor: const Color(0xFF28006D),
        labelColor: const Color(0xFF494552),
        valueColor: const Color(0xFF0B1C30),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.healthRecordsLanding),
      ),
      _SummaryCardData(
        icon: Icons.people_outline_rounded,
        label: 'Family',
        value: '4',
        bgColor: const Color(0xFFD3E4FE).withOpacity(0.5),
        borderColor: const Color(0xFFCBC4D4),
        iconColor: const Color(0xFF28006D),
        labelColor: const Color(0xFF494552),
        valueColor: const Color(0xFF0B1C30),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.familyDashboard),
      ),
      _SummaryCardData(
        icon: Icons.qr_code_2_rounded,
        label: 'QR',
        value: 'Secure',
        bgColor: const Color(0xFFD3E4FE).withOpacity(0.5),
        borderColor: const Color(0xFFCBC4D4),
        iconColor: const Color(0xFF28006D),
        labelColor: const Color(0xFF494552),
        valueColor: const Color(0xFF0B1C30),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.qrDashboard),
      ),
    ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: item.onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: item.borderColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 20, color: item.iconColor),
                  const SizedBox(height: 6),
                  Text(
                    item.label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: item.labelColor,
                    ),
                  ),
                  Text(
                    item.value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: item.valueColor,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountSettingsGroup() {
    return _SettingsGroupContainer(
      title: 'Account Settings',
      children: [
        _SettingsRowItem(
          icon: Icons.person_outline_rounded,
          title: 'Personal Information',
          subtitle: 'Name, Address, Date of Birth',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profilePersonalDetails);
          },
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.mail_outline_rounded,
          title: 'Email & Phone',
          subtitle: 'Manage your contact details',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profilePersonalDetails);
          },
        ),
      ],
    );
  }

  Widget _buildMedicalInformationGroup() {
    return _SettingsGroupContainer(
      title: 'Medical Information',
      children: [
        _SettingsRowItem(
          icon: Icons.health_and_safety_outlined,
          title: 'Health Profiles',
          subtitle: 'Conditions, Allergies, Medications',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profileMedicalSummary);
          },
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.credit_card_outlined,
          title: 'Insurance Details',
          subtitle: 'Policy 44829 - Primary Health',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.insuranceCardDetails);
          },
        ),
      ],
    );
  }

  Widget _buildSecurityGroup() {
    return _SettingsGroupContainer(
      title: 'Security',
      children: [
        // Biometric Login Switch Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              const Icon(
                Icons.fingerprint_rounded,
                size: 22,
                color: Color(0xFF28006D),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biometric Login',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    Text(
                      'Use FaceID or Fingerprint',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: _biometricLoginEnabled,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF28006D),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFCBC4D4),
                  onChanged: (val) {
                    setState(() {
                      _biometricLoginEnabled = val;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.pin_outlined,
          title: 'Change PIN',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profileSecurityPrivacy);
          },
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.devices_outlined,
          title: 'Active Sessions',
          subtitle: '2 active on Mobile & Web',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profileSecurityPrivacy);
          },
        ),
      ],
    );
  }

  Widget _buildPrivacyGroup() {
    return _SettingsGroupContainer(
      title: 'Privacy',
      children: [
        _SettingsRowItem(
          icon: Icons.shield_outlined,
          title: 'Consent & Permissions',
          subtitle: 'Who can view your data',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profileSecurityPrivacy);
          },
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.share_outlined,
          title: 'Data Sharing',
          subtitle: 'External app connections',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.profileSecurityPrivacy);
          },
        ),
      ],
    );
  }

  Widget _buildApplicationGroup() {
    return _SettingsGroupContainer(
      title: 'Application',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: Color(0xFF28006D),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Version',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    Text(
                      'v3.4.2 (Production)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.description_outlined,
          title: 'Terms & Privacy Policy',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.privacyConsents);
          },
        ),
        const _DividerLine(),
        _SettingsRowItem(
          icon: Icons.headset_mic_outlined,
          title: 'Support Center',
          subtitle: '24/7 dedicated medical help',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.liveChat);
          },
        ),
      ],
    );
  }

  Widget _buildAccountActionsGroup() {
    return _SettingsGroupContainer(
      title: 'Account Actions',
      children: [
        InkWell(
          onTap: _showLogoutDialog,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: Color(0xFFBA1A1A),
                ),
                const SizedBox(width: 16),
                Text(
                  'Logout',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFBA1A1A),
                  ),
                ),
              ],
            ),
          ),
        ),
        const _DividerLine(),
        InkWell(
          onTap: _showDeleteAccountDialog,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: Color(0xFFBA1A1A),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delete Account',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFBA1A1A),
                        ),
                      ),
                      Text(
                        'Irreversibly erase all medical data',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: const Color(0xFFBA1A1A).withOpacity(0.7),
                        ),
                      ),
                    ],
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

class _SummaryCardData {
  final IconData icon;
  final String label;
  final String value;
  final Color bgColor;
  final Color borderColor;
  final Color iconColor;
  final Color labelColor;
  final Color valueColor;
  final VoidCallback onTap;

  _SummaryCardData({
    required this.icon,
    required this.label,
    required this.value,
    required this.bgColor,
    required this.borderColor,
    required this.iconColor,
    required this.labelColor,
    required this.valueColor,
    required this.onTap,
  });
}

class _SettingsGroupContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroupContainer({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF494552),
              letterSpacing: 0.28,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFCBC4D4).withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsRowItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsRowItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF28006D),
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
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF494552),
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: const Color(0xFFCBC4D4).withOpacity(0.3),
    );
  }
}

