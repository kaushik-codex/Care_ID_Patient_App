import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 42: Add Family Member – Review (Figma node 20:19238)
/// Exact implementation matching Figma node 20:19238
class AddFamilyMemberReviewPage extends StatefulWidget {
  const AddFamilyMemberReviewPage({super.key});

  @override
  State<AddFamilyMemberReviewPage> createState() => _AddFamilyMemberReviewPageState();
}

class _AddFamilyMemberReviewPageState extends State<AddFamilyMemberReviewPage> {
  bool _consentCertified = true;

  void _onSendInvitation(Map<String, dynamic> data) {
    if (!_consentCertified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please certify HIPAA authorization before proceeding.',
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
          ),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).pushNamed(
      AppRoutes.invitationSent,
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final data = args is Map<String, dynamic> ? args : <String, dynamic>{};

    final String fullName = data['name'] ?? 'Maya Thompson';
    final String firstName = fullName.split(' ').first;
    final String dob = data['dob'] ?? '16 Aug 1989';
    final String ssn = data['ssn'] ?? '4821';
    final String relationship = data['relationship'] ?? 'Sister';
    final String phone = data['phone'] ?? '+1 (415) 555-0184';
    final String email = data['email'] ?? 'maya.t@example.com';

    final bool shareMedical = data['shareMedical'] ?? true;
    final bool shareDental = data['shareDental'] ?? true;
    final bool shareVision = data['shareVision'] ?? false;
    final bool sharePrescriptions = data['sharePrescriptions'] ?? true;
    final bool shareImmunizations = data['shareImmunizations'] ?? true;
    final bool shareEmergency = data['shareEmergency'] ?? true;
    final String duration = data['duration'] ?? '12 months';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: _buildTopAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator (Step 3 of 3)
            _buildProgressIndicator(),

            const SizedBox(height: 24),

            // Review Introduction
            Text(
              'Review $firstName’s invitation',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Confirm the details below before sending secure access to her health records.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF494552),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'MEMBER DETAILS',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
                color: const Color(0xFF7A7583),
              ),
            ),
            const SizedBox(height: 12),

            // Card 1: Personal Details
            _buildReviewCard(
              icon: Icons.person_outline_rounded,
              title: 'Personal Details',
              onEdit: () => Navigator.of(context).pop(),
              content: Column(
                children: [
                  _buildDetailRow('Full name', fullName),
                  const SizedBox(height: 8),
                  _buildDetailRow('Date of birth', dob),
                  const SizedBox(height: 8),
                  _buildDetailRow('Identity check', 'SSN ending $ssn'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card 2: Relationship
            _buildReviewCard(
              icon: Icons.people_outline_rounded,
              title: 'Relationship',
              onEdit: () => Navigator.of(context).pop(),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Family relationship',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
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
                      relationship,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card 3: Contact
            _buildReviewCard(
              icon: Icons.mail_outline_rounded,
              title: 'Contact',
              onEdit: () => Navigator.of(context).pop(),
              content: Column(
                children: [
                  _buildDetailRow('Email', email),
                  const SizedBox(height: 8),
                  _buildDetailRow('Mobile', phone),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card 4: Access Permissions
            _buildReviewCard(
              icon: Icons.shield_outlined,
              title: 'Access Permissions',
              onEdit: () => Navigator.of(context).pop(),
              content: Column(
                children: [
                  _buildAccessSummaryItem(Icons.menu_book_rounded, 'Medical Records', shareMedical),
                  const SizedBox(height: 8),
                  _buildAccessSummaryItem(Icons.description_outlined, 'Dental Records', shareDental),
                  const SizedBox(height: 8),
                  _buildAccessSummaryItem(Icons.remove_red_eye_outlined, 'Vision Records', shareVision),
                  const SizedBox(height: 8),
                  _buildAccessSummaryItem(Icons.medication_outlined, 'Prescriptions', sharePrescriptions),
                  const SizedBox(height: 8),
                  _buildAccessSummaryItem(Icons.vaccines_outlined, 'Immunizations', shareImmunizations),
                  const SizedBox(height: 8),
                  _buildAccessSummaryItem(Icons.emergency_outlined, 'Emergency Contact', shareEmergency),
                  const Divider(height: 20, color: Color(0x4DCBC4D4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Temporary access',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: const Color(0xFF7A7583),
                        ),
                      ),
                      Text(
                        'Expires after $duration',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF006971),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card 5: Consent Acknowledgement
            _buildReviewCard(
              icon: Icons.verified_user_outlined,
              title: 'Consent Acknowledgement',
              onEdit: () {},
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _consentCertified,
                    onChanged: (v) => setState(() => _consentCertified = v ?? true),
                    activeColor: const Color(0xFF006971),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  Expanded(
                    child: Text(
                      'I certify that I have legal authorization to share and manage health data for this family member under HIPAA regulations.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF494552),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Send Invitation Button
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
                onPressed: () => _onSendInvitation(data),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Send Invitation',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
              'Review & Confirm',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF28006D),
              ),
            ),
            Text(
              'Step 3 of 3',
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
            color: const Color(0xFF006971),
            borderRadius: BorderRadius.circular(9999),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard({
    required IconData icon,
    required String title,
    required VoidCallback onEdit,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4).withValues(alpha: 0.5)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8DDFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 18, color: const Color(0xFF28006D)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: onEdit,
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF006971)),
                    const SizedBox(width: 4),
                    Text(
                      'Edit',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF006971),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF7A7583),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }

  Widget _buildAccessSummaryItem(IconData icon, String label, bool granted) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: granted ? const Color(0xFFD9FAFC) : const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: granted ? const Color(0xFF006971) : const Color(0xFF7A7583)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF0B1C30),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: granted ? const Color(0xFF006971).withValues(alpha: 0.1) : const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            granted ? 'View & share' : 'No access',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: granted ? const Color(0xFF006971) : const Color(0xFF7A7583),
            ),
          ),
        ),
      ],
    );
  }
}
