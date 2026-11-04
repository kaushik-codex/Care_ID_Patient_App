import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Screen 80: Personal Details & Identity
/// Node ID: 20:24653
class PersonalDetailsIdentityPage extends StatefulWidget {
  const PersonalDetailsIdentityPage({super.key});

  @override
  State<PersonalDetailsIdentityPage> createState() => _PersonalDetailsIdentityPageState();
}

class _PersonalDetailsIdentityPageState extends State<PersonalDetailsIdentityPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  late final TextEditingController _genderController;
  late final TextEditingController _bloodGroupController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Sarah Jenkins');
    _dobController = TextEditingController(text: '12/05/1992');
    _genderController = TextEditingController(text: 'Female');
    _bloodGroupController = TextEditingController(text: 'O+');
    _phoneController = TextEditingController(text: '+1 234 567 890');
    _emailController = TextEditingController(text: 'sarah.j@email.com');
    _addressController = TextEditingController(text: '425 Clinical Way, Suite 200');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _bloodGroupController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _discardChanges() {
    setState(() {
      _nameController.text = 'Sarah Jenkins';
      _dobController.text = '12/05/1992';
      _genderController.text = 'Female';
      _bloodGroupController.text = 'O+';
      _phoneController.text = '+1 234 567 890';
      _emailController.text = 'sarah.j@email.com';
      _addressController.text = '425 Clinical Way, Suite 200';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Changes discarded.',
          style: GoogleFonts.plusJakartaSans(),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _saveDetails() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Personal details updated successfully!',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006D76),
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
                // Profile Avatar & Patient ID
                _buildProfileAvatarSection(),
                const SizedBox(height: 24),

                // Form Fields Section
                _buildFormSection(),
                const SizedBox(height: 24),

                // Secure Health Vault Info Card
                _buildSecurityVaultCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Top App Bar
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
                    Navigator.of(context).pushReplacementNamed(AppRoutes.profileSettingsHub);
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

              // Title + Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Personal Details',
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
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ],
              ),

              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatarSection() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 96,
              height: 96,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/bfd7567e81ca7834f0c16f9b7bd9f27a17ef5ae1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Image.asset(
                    'assets/images/patient_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: const Color(0xFFEFF4FF),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: Color(0xFF28006D),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Opening camera/photo picker...',
                        style: GoogleFonts.plusJakartaSans(),
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF28006D),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Sarah Jenkins',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Patient ID: #HV-920512',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
            letterSpacing: 0.28,
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: [
        // Full Name
        _buildInputField(
          label: 'Full Name',
          icon: Icons.person_outline_rounded,
          controller: _nameController,
          showEditIcon: true,
        ),
        const SizedBox(height: 16),

        // Date of Birth & Gender
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: 'Date of Birth',
                icon: Icons.calendar_today_outlined,
                controller: _dobController,
                showEditIcon: false,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildInputField(
                label: 'Gender',
                icon: Icons.transgender_rounded,
                controller: _genderController,
                showDropdownIcon: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Blood Group & Mobile
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                label: 'Blood Group',
                icon: Icons.bloodtype_outlined,
                controller: _bloodGroupController,
                showDropdownIcon: true,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildInputField(
                label: 'Mobile',
                icon: Icons.phone_outlined,
                controller: _phoneController,
                showEditIcon: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Email
        _buildInputField(
          label: 'Email',
          icon: Icons.mail_outline_rounded,
          controller: _emailController,
          showEditIcon: true,
        ),
        const SizedBox(height: 16),

        // Address
        _buildInputField(
          label: 'Address',
          icon: Icons.location_on_outlined,
          controller: _addressController,
          showEditIcon: true,
          isMultiline: true,
        ),
        const SizedBox(height: 24),

        // Action Buttons Row
        Row(
          children: [
            // Discard Changes Button
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFF28006D)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                onPressed: _discardChanges,
                child: Text(
                  'Discard Changes',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF28006D),
                    letterSpacing: 0.28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Save Details Button
            Expanded(
              child: InkWell(
                onTap: _saveDetails,
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFA44CFF),
                        Color(0xFF5B14B8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5B14B8).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Save Details',
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool showEditIcon = false,
    bool showDropdownIcon = false,
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF28006D),
              letterSpacing: 0.28,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFCBC4D4),
            ),
          ),
          child: Row(
            crossAxisAlignment:
                isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: isMultiline ? 10 : 0),
                child: Icon(
                  icon,
                  size: 20,
                  color: const Color(0xFF494552),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: isMultiline ? 2 : 1,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: const Color(0xFF0B1C30),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              if (showEditIcon)
                const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Color(0xFF494552),
                ),
              if (showDropdownIcon)
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: Color(0xFF494552),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityVaultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF75F2FE).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF006971).withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 20,
            color: Color(0xFF006971),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Health Vault',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF006971),
                    letterSpacing: 0.28,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personal details are encrypted and stored securely. Only authorized healthcare providers can access this information with your consent.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    height: 1.4,
                    color: const Color(0xFF494552),
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

