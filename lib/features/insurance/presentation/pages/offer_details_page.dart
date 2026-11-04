import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../widgets/insurance_assets.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNavStatusLine(context),
                    const SizedBox(height: 16),
                    _buildCountdownBanner(context),
                    const SizedBox(height: 16),
                    _buildProviderHeroCard(context),
                    const SizedBox(height: 16),
                    _buildCostBreakdownCard(context),
                    const SizedBox(height: 16),
                    _buildClinicalScopeCard(context),
                    const SizedBox(height: 16),
                    _buildTermsCard(context),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF).withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF28006D).withOpacity(0.06),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left: Back Nav Button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.treatmentOffers);
                }
              },
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF4FF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF28006D)),
                ),
              ),
            ),
          ),

          // Center: Logo Wordmark
          Center(
            child: Image.asset(
              InsuranceAssets.careIdLogo4,
              height: 22,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Text(
                'CareID',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: const Color(0xFF28006D),
                ),
              ),
            ),
          ),

          // Right: Notification Bell + Profile Avatar
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5EEFF),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            InsuranceAssets.notificationBadge,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(Color(0xFF28006D), BlendMode.srcIn),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBA1A1A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.profileSettingsHub);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF3F1D8B), width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            InsuranceAssets.avatarUserHub,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Color(0xFF3F1D8B)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
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
    );
  }

  Widget _buildNavStatusLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Offer Details',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: const Color(0xFF28006D),
              ),
            ),
            Text(
              'Estimate Ref: #TX-88410',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFDBC9),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF71360D),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Pending Review',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xFF71360D),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF28006D), Color(0xFF3F1D8B), Color(0xFF00696B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF56F5F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(Icons.timer_outlined, color: Color(0xFF00696B), size: 22),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Special Estimate Reserved',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: const Color(0xFF5AF8FB),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Expires in 16 days • Nov 30, 2023',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '18%',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: const Color(0xFF5AF8FB),
                  height: 1.0,
                ),
              ),
              Text(
                'OFF TOTAL',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: const Color(0xFFAB8EFD),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    InsuranceAssets.doctorDentist,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF56F5F8).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            'DENTISTRY',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: const Color(0xFF00696B),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Lic. #DDS-9402',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: const Color(0xFF494552),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Comprehensive Dental Restoration & Scaling',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: const Color(0xFF28006D),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'City Dental Care • Dr. Julian Vance, DDS',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Mini snapshot row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Issued',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    Text(
                      'Oct 15, 2023',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                Container(width: 1, height: 28, color: const Color(0xFFD3E4FE)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valid Through',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    Text(
                      'Nov 30, 2023',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                Container(width: 1, height: 28, color: const Color(0xFFD3E4FE)),
                Row(
                  children: [
                    const Icon(Icons.verified, size: 16, color: Color(0xFF00696B)),
                    const SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdownCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE9FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.calculate_outlined, size: 18, color: Color(0xFF28006D)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Cost & Savings Breakdown',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF00696B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'Care ID Rate',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: const Color(0xFF00696B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildBreakdownRow('Standard Procedure Cost', r'$1,850.00', const Color(0xFF0B1C30)),
          const SizedBox(height: 8),
          _buildBreakdownRow('Provider Promo (15% Off)', r'- $277.50', const Color(0xFF00696B)),
          const SizedBox(height: 8),
          _buildBreakdownRow('Care ID Platform Credit', r'- $50.00', const Color(0xFF28006D)),
          const SizedBox(height: 14),
          // Savings graphic bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'YOUR TOTAL SAVINGS',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: const Color(0xFF00696B),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      r'$327.50 (18% Savings)',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: const Color(0xFF00696B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 82,
                        child: Container(height: 8, color: const Color(0xFF00696B)),
                      ),
                      Expanded(
                        flex: 18,
                        child: Container(height: 8, color: const Color(0xFF56F5F8)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FINAL APPLICABLE AMOUNT',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: const Color(0xFF494552),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'All applicable taxes included',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xFF7A7583),
                    ),
                  ),
                ],
              ),
              Text(
                r'$1,522.50',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  color: const Color(0xFF28006D),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: const Color(0xFF494552),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalScopeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF28006D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check_box_outlined, size: 18, color: Color(0xFF28006D)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Clinical Scope Included',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Text(
                '3 Care Steps',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildScopeStep(
            'Quadrant Deep Scaling & Root Planing',
            'Full 4-quadrant subgingival ultrasonic removal of calculus and bacterial deposits.',
          ),
          const SizedBox(height: 10),
          _buildScopeStep(
            'Composite Resin Restoration (#14 & #19)',
            'Multi-surface aesthetic shade-matched dental composite with enamel curing.',
          ),
          const SizedBox(height: 10),
          _buildScopeStep(
            'Fluoride Varnish & Clinical Follow-Up',
            'Protective remineralizing topical application plus 30-day oral health inspection.',
          ),
        ],
      ),
    );
  }

  Widget _buildScopeStep(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF00696B).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check, size: 14, color: Color(0xFF00696B)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: const Color(0xFF494552),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: Color(0xFF0B1C30)),
              const SizedBox(width: 8),
              Text(
                'Terms & Treatment Conditions',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildBulletPoint('Redeemable exclusively at City Dental Care with Dr. Julian Vance, DDS.'),
          const SizedBox(height: 6),
          _buildBulletPoint('Offer valid with confirmed appointment pre-booking before Nov 30, 2023.'),
          const SizedBox(height: 6),
          _buildBulletPoint('Can be combined with flexible 0% APR 6-month Care ID financing or direct payment.'),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFF00696B),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: const Color(0xFF494552),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.offerAcceptedConfirmation);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              elevation: 4,
              shadowColor: const Color(0xFF28006D).withOpacity(0.3),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      r'Accept Offer ($1,522.50)',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.offerRejectedConfirmation);
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFFDAD6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.close, size: 16, color: Color(0xFF93000A)),
                const SizedBox(width: 8),
                Text(
                  'Reject Offer',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF93000A),
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

