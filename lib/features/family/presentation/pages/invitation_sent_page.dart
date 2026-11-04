import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 43: Invitation Sent (Figma node 20:19138)
/// Exact implementation matching Figma node 20:19138
class InvitationSentPage extends StatelessWidget {
  const InvitationSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final data = args is Map<String, dynamic> ? args : <String, dynamic>{};

    final String fullName = data['name'] ?? 'Maya Thompson';
    final String firstName = fullName.split(' ').first;
    final String relationship = data['relationship'] ?? 'Sister';
    final String email = data['email'] ?? 'maya.t@example.com';

    // Generate initials
    final parts = fullName.trim().split(' ');
    final initials = parts.length >= 2
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : (fullName.isNotEmpty ? fullName.substring(0, fullName.length.clamp(1, 2)).toUpperCase() : 'MT');

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: _buildTopAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success Hero
            _buildSuccessHero(firstName),

            const SizedBox(height: 24),

            // Pending Member Summary Card
            _buildMemberSummaryCard(fullName, relationship, email, initials),

            const SizedBox(height: 24),

            // What happens next card
            _buildWhatHappensNextCard(firstName),

            const SizedBox(height: 24),

            // Confirmation Actions
            _buildConfirmationActions(context),

            const SizedBox(height: 16),

            // Reminder Banner
            _buildReminderBanner(),

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
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.familyDashboard,
                      (route) => route.isFirst,
                    );
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
                Flexible(
                  child: Text(
                    'Family Management',
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

  Widget _buildSuccessHero(String firstName) {
    return Column(
      children: [
        Container(
          width: 104,
          height: 104,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF75F2FE).withValues(alpha: 0.25),
          ),
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF006971), Color(0xFF56F5F8)],
                ),
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 44),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Invitation sent',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'We sent $firstName a secure invitation to join your family health network.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF494552),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF28006D)),
              const SizedBox(width: 6),
              Text(
                'Pending acceptance',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMemberSummaryCard(String fullName, String relationship, String email, String initials) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF75F2FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF006971),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$relationship • $email',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Pending',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF28006D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0x4DCBC4D4)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sent today at 10:24 AM',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: const Color(0xFF7A7583),
                ),
              ),
              Text(
                'Expires in 7 days',
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
    );
  }

  Widget _buildWhatHappensNextCard(String firstName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WHAT HAPPENS NEXT',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
            color: const Color(0xFF7A7583),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
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
            children: [
              _buildNextStepItem(
                icon: Icons.mark_email_read_outlined,
                title: '$firstName receives a secure link',
                subtitle: 'The invitation is sent by email and text message.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Color(0x4DCBC4D4)),
              ),
              _buildNextStepItem(
                icon: Icons.verified_user_outlined,
                title: 'She verifies her identity',
                subtitle: 'A quick identity check keeps family records protected.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Color(0x4DCBC4D4)),
              ),
              _buildNextStepItem(
                icon: Icons.volunteer_activism_outlined,
                title: 'Sharing begins after acceptance',
                subtitle: 'Only the permissions you selected will become active.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNextStepItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFE8DDFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF28006D)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: const Color(0xFF494552),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationActions(BuildContext context) {
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
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.familyMemberList);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_outline_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'View Pending Member',
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
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF28006D), width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.familyDashboard,
                (route) => route.isFirst,
              );
            },
            child: Text(
              'Return to Family Management',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF28006D),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD9FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFF006971)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'You can resend or cancel this invitation from the pending member profile.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF006971),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
