import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_insurance_repository.dart';
import '../../domain/models/insurance_models.dart';
import '../widgets/insurance_assets.dart';

/// Screen 7: Insurance Card Details (`20:20890`)
class InsuranceCardDetailsPage extends StatelessWidget {
  const InsuranceCardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final policy = MockInsuranceRepository.instance.primaryPolicy;

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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardPreview(policy),
                    const SizedBox(height: 28),
                    _buildMainInfoCard(policy),
                    const SizedBox(height: 18),
                    _buildStatusHealthGauge(),
                    const SizedBox(height: 28),
                    _buildQuickActionsGrid(context),
                    const SizedBox(height: 24),
                    _buildRemoveRecordAction(context),
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
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.insuranceDashboard);
                  }
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
                'Insurance Details',
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
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_vert,
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

  Widget _buildCardPreview(InsurancePolicy policy) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFCBC4D4).withOpacity(0.5),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    InsuranceAssets.cardDigitalPreview,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF28006D), Color(0xFF006971)],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 24,
                  bottom: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PREMIUM HEALTH ACCESS',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.6,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '•••• •••• •••• 8842',
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: -14,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF006971),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  InsuranceAssets.verifiedBadgeCheck,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Verified Provider',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfoCard(InsurancePolicy policy) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insurance Provider',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: const Color(0xFF494552),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Global Shield Healthcare',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF75F2FE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'PREMIUM',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: const Color(0xFF006D76),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE5EEFF)),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.1,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildDetailItem('Coverage Type', 'Full Medical & Dental'),
              _buildDetailItem('Policy Number', 'GSH-992-8842-X'),
              _buildDetailItem('Expiry Date', 'September 24, 2026'),
              _buildDetailItem('Deductible', policy.deductibleAnnual),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusHealthGauge() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const CircularProgressIndicator(
                  value: 0.90,
                  strokeWidth: 8,
                  backgroundColor: Color(0xFFE5EEFF),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF006971)),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '90%',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF006971),
                        ),
                      ),
                      Text(
                        'Active',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF494552),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Coverage is currently active and fully verified.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View Benefits Schedule',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF28006D),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF28006D),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK ACTIONS',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
            color: const Color(0xFF494552),
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 1.65,
          children: [
            // 1. Share Policy
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sharing encrypted digital insurance credentials...',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3328006D),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      InsuranceAssets.sharePolicyIcon,
                      width: 22,
                      height: 20,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Share Policy',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Digital QR
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.qrDashboard);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD3E4FE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      InsuranceAssets.qrPolicyIcon,
                      width: 22,
                      height: 20,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.qr_code,
                        color: Color(0xFF0B1C30),
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Digital QR',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Download PDF
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Generating verified PDF proof of coverage...',
                      style: GoogleFonts.plusJakartaSans(fontSize: 13),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD3E4FE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      InsuranceAssets.downloadPdfIcon,
                      width: 20,
                      height: 18,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.picture_as_pdf_outlined,
                        color: Color(0xFF0B1C30),
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Download PDF',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Edit Details
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.insuranceManualReview);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD3E4FE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF0B1C30),
                      size: 22,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Edit Details',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0B1C30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRemoveRecordAction(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                'Remove Insurance Record',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFBA1A1A),
                ),
              ),
              content: Text(
                'Are you sure you want to remove this insurance policy from your CareID Vault? You may have to scan it again.',
                style: GoogleFonts.plusJakartaSans(fontSize: 14),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.insuranceDashboard,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBA1A1A),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                InsuranceAssets.deleteTrashIcon,
                width: 18,
                height: 18,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFBA1A1A),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Remove Insurance Record',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFBA1A1A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

