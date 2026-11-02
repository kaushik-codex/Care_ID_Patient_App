import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 40: Add Family Member - Form (Figma node 20:22023)
/// Exact implementation matching Figma node 20:22023
class AddFamilyMemberFormPage extends StatefulWidget {
  const AddFamilyMemberFormPage({super.key});

  @override
  State<AddFamilyMemberFormPage> createState() => _AddFamilyMemberFormPageState();
}

class _AddFamilyMemberFormPageState extends State<AddFamilyMemberFormPage> {
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _ssnController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedRelationship = 'Child / Minor';
  String? _uploadedFileName;

  final List<String> _relationshipOptions = [
    'Child / Minor',
    'Parent / Elder',
    'Spouse / Partner',
    'Sibling',
    'Other Dependent',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _ssnController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final data = {
      'name': _fullNameController.text.trim().isEmpty ? 'Leo Jenkins' : _fullNameController.text.trim(),
      'dob': _dobController.text.trim().isEmpty ? '05/14/2018' : _dobController.text.trim(),
      'ssn': _ssnController.text.trim().isEmpty ? '7749' : _ssnController.text.trim(),
      'relationship': _selectedRelationship,
      'phone': _phoneController.text.trim().isEmpty ? '+1 (555) 234-8901' : _phoneController.text.trim(),
      'notes': _notesController.text.trim(),
      'document': _uploadedFileName,
    };

    Navigator.of(context).pushNamed(
      AppRoutes.addFamilyMemberAccess,
      arguments: data,
    );
  }

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
            // Progress Indicator (Step 1 of 3)
            _buildProgressIndicator(),

            const SizedBox(height: 24),

            // Section: Personal Information (Identity)
            _buildIdentityCard(context),

            const SizedBox(height: 16),

            // Section: Contact & Notes
            _buildContactNotesCard(context),

            const SizedBox(height: 16),

            // Section: Document Upload
            _buildDocumentUploadCard(),

            const SizedBox(height: 24),

            // Action Button (Continue) & Legal Notice
            _buildActionButton(),

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
          color: const Color(0xFFF8F9FF),
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
                  onTap: () => Navigator.of(context).pop(),
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
                    'Add Family Member',
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
                      border: Border.all(color: const Color(0xFFE8DDFF), width: 2),
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

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Personal Details',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
            Text(
              'Step 1 of 3',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF7A7583),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD3E4FE),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.333,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF006971),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.badge_outlined, size: 20, color: Color(0xFF0B1C30)),
              const SizedBox(width: 8),
              Text(
                'Identity',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Full Name
          Text(
            'Full Name',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _fullNameController,
            hint: 'Legal full name',
          ),

          const SizedBox(height: 16),

          // Row: DOB + SSN
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of Birth',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _dobController,
                      hint: 'mm / dd / yyyy',
                      suffixIcon: const Icon(Icons.calendar_today_outlined,
                          size: 18, color: Color(0xFF494552)),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2018, 5, 14),
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _dobController.text =
                              '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SSN (Last 4)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _ssnController,
                      hint: '••••',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Relationship Dropdown
          Text(
            'Relationship',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedRelationship,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF494552)),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0B1C30),
                ),
                items: _relationshipOptions.map((rel) {
                  return DropdownMenuItem<String>(
                    value: rel,
                    child: Text(rel),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRelationship = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactNotesCard(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Contact',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _phoneController,
            hint: 'Phone number',
            prefixIcon: const Icon(Icons.phone_outlined, size: 20, color: Color(0xFF494552)),
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 16),

          Text(
            'Medical Notes',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4)),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 3,
              style: GoogleFonts.plusJakartaSans(fontSize: 14, color: const Color(0xFF0B1C30)),
              decoration: InputDecoration(
                hintText: 'Known allergies, conditions, or surgical history...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
                contentPadding: const EdgeInsets.all(14),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic_none_rounded, color: Color(0xFF006971)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Voice input listening...',
                            style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUploadCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withValues(alpha: 0.5),
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE5EEFF),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.upload_file_rounded, color: Color(0xFF28006D), size: 24),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Supporting Documents',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Upload birth certificate or legal\nguardianship papers (Max 5MB)',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: const Color(0xFF494552),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD3E4FE),
              foregroundColor: const Color(0xFF006971),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            onPressed: () {
              setState(() {
                _uploadedFileName = 'birth_certificate_leo.pdf';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Attached birth_certificate_leo.pdf',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              _uploadedFileName ?? 'Browse Files',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
            ),
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5B14B8).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
            onPressed: _onContinue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'By continuing, you confirm that you have the legal right to manage this individual\'s health data.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF494552),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBC4D4)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: onTap != null,
        onTap: onTap,
        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: const Color(0xFF0B1C30)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(fontSize: 15, color: const Color(0xFF6B7280)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
