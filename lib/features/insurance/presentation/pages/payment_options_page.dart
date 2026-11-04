import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../widgets/insurance_assets.dart';

/// Screen 74: Payment Options (Figma Node 20:33152)
class PaymentOptionsPage extends StatelessWidget {
  const PaymentOptionsPage({super.key});

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
                    _buildScreenContextRow(context),
                    const SizedBox(height: 14),
                    _buildIntroductionSection(context),
                    const SizedBox(height: 16),
                    _buildChoicesList(context),
                    const SizedBox(height: 16),
                    _buildSecurityNote(context),
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
            width: 1,
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
              height: 24,
              errorBuilder: (_, __, ___) => Text(
                'CareID',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5EEFF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            InsuranceAssets.notificationBadge,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF28006D),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
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
                          border: Border.all(color: const Color(0xFF5B14B8), width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            InsuranceAssets.avatarUserHub,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person,
                              color: Color(0xFF5B14B8),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 11,
                          height: 11,
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

  Widget _buildScreenContextRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment & Finance',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF28006D),
              ),
            ),
            Text(
              'Payment options',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFDCE9FF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                InsuranceAssets.shieldCheck,
                width: 13,
                height: 13,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00696B),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'SECURE',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00696B),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntroductionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHOOSE WHAT WORKS FOR YOU',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00696B),
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'How would you like to manage your care costs?',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0B1C30),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Compare personalized offers, flexible financing, or direct-pay savings.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }

  Widget _buildChoicesList(BuildContext context) {
    return Column(
      children: [
        _buildChoiceCard(
          context: context,
          iconBgColor: const Color(0xFFFFDAD6),
          iconAsset: InsuranceAssets.tagOffer,
          iconColor: const Color(0xFFBA1A1A),
          title: 'Explore Treatment Offers',
          description:
              'Review personalized quotes from your care team and compare available savings.',
          badgeText: '2 offers ready',
          badgeTextColor: const Color(0xFF28006D),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.treatmentOffers);
          },
        ),
        const SizedBox(height: 12),
        _buildChoiceCard(
          context: context,
          iconBgColor: const Color(0xFF56F5F8),
          iconAsset: InsuranceAssets.creditCard,
          iconColor: const Color(0xFF00696B),
          title: 'Explore Financing Options',
          description:
              'Split care costs into manageable monthly payments and check eligibility.',
          badgeText: '0% APR eligible',
          badgeTextColor: const Color(0xFF00696B),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.financingOptionDetails);
          },
        ),
        const SizedBox(height: 12),
        _buildChoiceCard(
          context: context,
          iconBgColor: const Color(0xFFDCE9FF),
          iconAsset: InsuranceAssets.badgeDollarSign,
          iconColor: const Color(0xFF28006D),
          title: 'Explore Cash Discount Options',
          description:
              'See prompt-pay discounts when you pay directly without insurance.',
          badgeText: 'Up to 20% off',
          badgeTextColor: const Color(0xFF00696B),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.cashDiscountOptions);
          },
        ),
      ],
    );
  }

  Widget _buildChoiceCard({
    required BuildContext context,
    required Color iconBgColor,
    required String iconAsset,
    required Color iconColor,
    required String title,
    required String description,
    required String badgeText,
    required Color badgeTextColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconAsset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    iconColor,
                    BlendMode.srcIn,
                  ),
                ),
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      height: 1.4,
                      color: const Color(0xFF494552),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF4FF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          badgeText,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: badgeTextColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFF4FF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            InsuranceAssets.arrowRight,
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF28006D),
                              BlendMode.srcIn,
                            ),
                          ),
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
    );
  }

  Widget _buildSecurityNote(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          InsuranceAssets.lockKeyhole,
          width: 12,
          height: 12,
          colorFilter: const ColorFilter.mode(
            Color(0xFF494552),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          'No commitment until you review and confirm an option.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }
}

