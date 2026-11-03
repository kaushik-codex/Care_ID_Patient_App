import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_insurance_repository.dart';
import '../../domain/models/insurance_models.dart';
import '../widgets/insurance_assets.dart';

/// Screen 5: OCR Extraction Results (`20:20517`)
class InsuranceExtractionResultsPage extends StatelessWidget {
  const InsuranceExtractionResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildConfidenceHeader(),
                    const SizedBox(height: 20),
                    _buildMicroCardPreview(),
                    const SizedBox(height: 24),
                    _buildMembershipDetailsSection(),
                    const SizedBox(height: 20),
                    _buildBillingRxSection(),
                    const SizedBox(height: 20),
                    _buildCoverageStatusSection(),
                    const SizedBox(height: 20),
                    _buildHelperActions(context),
                    const SizedBox(height: 28),
                    _buildConfirmButton(context),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      InsuranceAssets.backArrow,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Review Information',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                InsuranceAssets.careIdLogo4,
                width: 25,
                height: 18,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.insuranceManualReview);
                },
                child: const Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF494552),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF006971).withOpacity(0.12),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                InsuranceAssets.checkSuccess,
                width: 16,
                height: 16,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.check_circle,
                  color: Color(0xFF006971),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'High Confidence Match (98.4%)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  color: const Color(0xFF006971),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Verification Results',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Please confirm the extracted insurance details below.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }

  Widget _buildMicroCardPreview() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFCBC4D4).withOpacity(0.5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                InsuranceAssets.cardExtractedPreview,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF28006D),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: const Color(0xFF28006D).withOpacity(0.2),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DIGITAL ARCHIVE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'SCAN_ID_8829-X',
                    style: GoogleFonts.robotoMono(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                InsuranceAssets.detailsMembership,
                width: 20,
                height: 20,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.badge_outlined,
                  color: Color(0xFF28006D),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Membership Details',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildInfoField('Insurance Provider', 'Blue Shield Healthcare Premium'),
          const SizedBox(height: 12),
          _buildInfoField('Member Name', 'Alexander J. Thompson'),
          const SizedBox(height: 12),
          _buildInfoField('Member ID', 'ZYX-882934-P'),
          const SizedBox(height: 12),
          _buildInfoField('Policy Number', '90210-HD-552'),
        ],
      ),
    );
  }

  Widget _buildBillingRxSection() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                InsuranceAssets.detailsBilling,
                width: 20,
                height: 20,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.receipt_long_outlined,
                  color: Color(0xFF28006D),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Billing & Claims (RX)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildInfoField('BIN', '004336'),
          const SizedBox(height: 12),
          _buildInfoField('PCN', 'ADV'),
          const SizedBox(height: 12),
          _buildInfoField('RX Group', 'RX992-P'),
          const SizedBox(height: 12),
          _buildInfoField('Payer ID', 'BCBS-GLOBAL-88'),
          const SizedBox(height: 12),
          _buildInfoField('Group Number', '12903-X'),
        ],
      ),
    );
  }

  Widget _buildCoverageStatusSection() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFF006971), width: 4),
          top: BorderSide(color: Colors.white),
          right: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                InsuranceAssets.detailsCoverage,
                width: 20,
                height: 20,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.shield_outlined,
                  color: Color(0xFF006971),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Coverage Status',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF006971),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Coverage Type',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF006971),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Individual PPO Premium',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE5EEFF)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Effective Date',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'January 01, 2024',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Expiration Date',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'December 31, 2024',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF006971).withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF006971).withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INSIGHT',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: const Color(0xFF006971),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your coverage is active. This insurance card has been successfully cross-referenced with national databases.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
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

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFCBC4D4).withOpacity(0.4),
            ),
          ),
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0B1C30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHelperActions(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.insuranceManualReview);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4).withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFF28006D).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          InsuranceAssets.editManualIcon,
                          width: 18,
                          height: 18,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF28006D),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Edit manually',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF494552),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCBC4D4).withOpacity(0.4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBA1A1A).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          InsuranceAssets.discardScanIcon,
                          width: 18,
                          height: 18,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.delete_outline,
                            color: Color(0xFFBA1A1A),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Discard scan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFF494552),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Save policy and navigate to details
        final repo = MockInsuranceRepository.instance;
        repo.updatePrimaryPolicy(
          repo.primaryPolicy.copyWith(
            providerName: 'Blue Shield Healthcare Premium',
            policyNumber: '90210-HD-552',
            groupNumber: '12903-X',
            rxBin: '004336',
            rxPcn: 'ADV',
            rxGroup: 'RX992-P',
            payerId: 'BCBS-GLOBAL-88',
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Insurance Card Successfully Verified & Saved!',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF006D76),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.of(context).pushReplacementNamed(
          AppRoutes.insuranceCardDetails,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3328006D),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Confirm & Save',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              InsuranceAssets.saveCheckmark,
              width: 19,
              height: 16,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

