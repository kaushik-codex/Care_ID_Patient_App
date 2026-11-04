import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 41: Add Family Member – Access (Figma node 20:19424)
/// Exact implementation matching Figma node 20:19424
class AddFamilyMemberAccessPage extends StatefulWidget {
  const AddFamilyMemberAccessPage({super.key});

  @override
  State<AddFamilyMemberAccessPage> createState() => _AddFamilyMemberAccessPageState();
}

class _AddFamilyMemberAccessPageState extends State<AddFamilyMemberAccessPage> {
  bool _medicalRecords = true;
  bool _dentalRecords = true;
  bool _visionRecords = false;
  bool _prescriptions = true;
  bool _immunizations = true;
  bool _emergencyContact = true;
  bool _temporaryAccess = true;
  String _selectedDuration = '12 months';

  void _onContinue(Map<String, dynamic> passedData) {
    final accessData = {
      ...passedData,
      'shareMedical': _medicalRecords,
      'shareDental': _dentalRecords,
      'shareVision': _visionRecords,
      'sharePrescriptions': _prescriptions,
      'shareImmunizations': _immunizations,
      'shareEmergency': _emergencyContact,
      'temporaryAccess': _temporaryAccess,
      'duration': _selectedDuration,
    };

    Navigator.of(context).pushNamed(
      AppRoutes.addFamilyMemberReview,
      arguments: accessData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final passedData = args is Map<String, dynamic> ? args : <String, dynamic>{};
    final String memberName = (passedData['name'] as String?)?.split(' ').first ?? 'Maya';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: _buildTopAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator (Step 2 of 3)
            _buildProgressIndicator(),

            const SizedBox(height: 24),

            // Access introduction
            Text(
              'Choose what $memberName can access',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'You can update these permissions any time from Family Management.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
              ),
            ),

            const SizedBox(height: 24),

            // Section: Access Levels
            Text(
              'ACCESS LEVELS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
                color: const Color(0xFF7A7583),
              ),
            ),
            const SizedBox(height: 12),
            _buildPermissionListCard(),

            const SizedBox(height: 24),

            // Section: Expiry Settings
            Text(
              'EXPIRY SETTINGS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
                color: const Color(0xFF7A7583),
              ),
            ),
            const SizedBox(height: 12),
            _buildExpiryCard(),

            const SizedBox(height: 24),

            // Step Actions (Back / Continue)
            _buildStepActions(context, passedData),

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
          color: const Color(0xFFF8F9FF).withValues(alpha: 0.93),
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
                Flexible(
                  child: Text(
                    'Add Family Member',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/card_id_badge.png',
                  height: 20,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
                const Spacer(),
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
              'Access & Permissions',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
            Text(
              'Step 2 of 3',
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
              widthFactor: 0.666,
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

  Widget _buildPermissionListCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPermissionTile(
            icon: Icons.menu_book_rounded,
            iconBg: const Color(0xFFE8DDFF),
            iconColor: const Color(0xFF3F1D8B),
            title: 'Medical Records',
            subtitle: 'View and share clinical records',
            value: _medicalRecords,
            onChanged: (v) => setState(() => _medicalRecords = v),
          ),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          _buildPermissionTile(
            icon: Icons.description_outlined,
            iconBg: const Color(0xFFE8DDFF),
            iconColor: const Color(0xFF3F1D8B),
            title: 'Dental Records',
            subtitle: 'History, X-rays and procedures',
            value: _dentalRecords,
            onChanged: (v) => setState(() => _dentalRecords = v),
          ),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          _buildPermissionTile(
            icon: Icons.remove_red_eye_outlined,
            iconBg: const Color(0xFFE8DDFF),
            iconColor: const Color(0xFF3F1D8B),
            title: 'Vision Records',
            subtitle: 'Eye exams and prescriptions',
            value: _visionRecords,
            onChanged: (v) => setState(() => _visionRecords = v),
          ),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          _buildPermissionTile(
            icon: Icons.medication_outlined,
            iconBg: const Color(0xFFD9FAFC),
            iconColor: const Color(0xFF006971),
            title: 'Prescriptions',
            subtitle: 'Medication list and refill details',
            value: _prescriptions,
            onChanged: (v) => setState(() => _prescriptions = v),
          ),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          _buildPermissionTile(
            icon: Icons.vaccines_outlined,
            iconBg: const Color(0xFFD9FAFC),
            iconColor: const Color(0xFF006971),
            title: 'Immunizations',
            subtitle: 'Vaccination history and certificates',
            value: _immunizations,
            onChanged: (v) => setState(() => _immunizations = v),
          ),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          _buildPermissionTile(
            icon: Icons.emergency_outlined,
            iconBg: const Color(0xFFD9FAFC),
            iconColor: const Color(0xFF006971),
            title: 'Emergency Contact',
            subtitle: 'Share essentials with first responders',
            value: _emergencyContact,
            onChanged: (v) => setState(() => _emergencyContact = v),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
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
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF494552),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF006971),
            activeTrackColor: const Color(0xFF006971).withValues(alpha: 0.3),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFCBC4D4),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9FAFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.timer_outlined, color: Color(0xFF006971), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temporary Access',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Revoke all permissions automatically',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _temporaryAccess,
                onChanged: (v) => setState(() => _temporaryAccess = v),
                activeColor: const Color(0xFF006971),
                activeTrackColor: const Color(0xFF006971).withValues(alpha: 0.3),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: const Color(0xFFCBC4D4),
              ),
            ],
          ),
          if (_temporaryAccess) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Starts when the invitation is accepted',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5EEFF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      _selectedDuration,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepActions(BuildContext context, Map<String, dynamic> passedData) {
    return Row(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(112, 56),
            side: const BorderSide(color: Color(0xFF28006D), width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Back',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF28006D),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
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
                  color: const Color(0xFF28006D).withValues(alpha: 0.2),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              ),
              onPressed: () => _onContinue(passedData),
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
        ),
      ],
    );
  }
}
