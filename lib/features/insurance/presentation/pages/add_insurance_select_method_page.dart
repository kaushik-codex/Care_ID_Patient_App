import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../widgets/insurance_assets.dart';

/// Screen 2: Add Insurance - Select Method (`20:20311`)
class AddInsuranceSelectMethodPage extends StatelessWidget {
  const AddInsuranceSelectMethodPage({super.key});

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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                child: Column(
                  children: [
                    _buildInstructionalHeader(),
                    const SizedBox(height: 28),
                    _buildOption1Camera(context),
                    const SizedBox(height: 20),
                    _buildOption2Gallery(context),
                    const SizedBox(height: 28),
                    _buildSmartExtractionCard(),
                    const SizedBox(height: 28),
                    _buildFooterNotes(),
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
                'Add Insurance',
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
                  Icons.info_outline,
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

  Widget _buildInstructionalHeader() {
    return Column(
      children: [
        SvgPicture.asset(
          InsuranceAssets.shieldEmblem,
          width: 56,
          height: 66,
          errorBuilder: (_, __, ___) => Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFE8DDFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.security, color: Color(0xFF28006D), size: 30),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Secure your records',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Digitize your insurance card to keep all your\nmedical data in one encrypted vault.',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            height: 1.45,
            color: const Color(0xFF494552),
          ),
        ),
      ],
    );
  }

  Widget _buildOption1Camera(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCBC4D4).withOpacity(0.6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFE8DDFF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                InsuranceAssets.cameraOptionIcon,
                width: 30,
                height: 27,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.camera_alt,
                  color: Color(0xFF28006D),
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Capture using Camera',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF28006D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Instant scan using your device's camera for\nautomatic data extraction.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              height: 1.4,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.insuranceCameraCapture);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFF28006D),
                  width: 1.5,
                ),
              ),
              child: Text(
                'Start Scan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF28006D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption2Gallery(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCBC4D4).withOpacity(0.6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF83F3FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                InsuranceAssets.galleryOptionIcon,
                width: 32,
                height: 24,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.photo_library,
                  color: Color(0xFF006971),
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Upload from Gallery',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF006971),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select an existing photo or digital document\nfrom your library.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              height: 1.4,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.insuranceOcrProcessing);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFF006971),
                  width: 1.5,
                ),
              ),
              child: Text(
                'Browse Files',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF006971),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartExtractionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 22),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                InsuranceAssets.avatarUserAlt,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF28006D),
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Smart Data Extraction',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0B1C30),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our AI automatically reads your policy\nnumber, provider name, and expiration date\nto save you time. No manual typing required.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              height: 1.45,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFeaturePill('OCR Enabled'),
              _buildFeaturePill('HIPAA Compliant'),
              _buildFeaturePill('Encrypted Vault'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(
          color: const Color(0xFFCBC4D4),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF494552),
        ),
      ),
    );
  }

  Widget _buildFooterNotes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file_outlined, color: Color(0xFF494552), size: 16),
            const SizedBox(width: 6),
            Text(
              'Supported formats: ',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF494552),
              ),
            ),
            Text(
              'PNG, JPG, PDF',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1C30),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Maximum file size: 10MB',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF7A7583),
          ),
        ),
      ],
    );
  }
}

