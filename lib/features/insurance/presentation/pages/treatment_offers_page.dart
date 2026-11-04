import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';
import '../../data/mock_insurance_repository.dart';
import '../../domain/models/insurance_models.dart';
import '../widgets/insurance_assets.dart';

class TreatmentOffersPage extends StatefulWidget {
  const TreatmentOffersPage({super.key});

  @override
  State<TreatmentOffersPage> createState() => _TreatmentOffersPageState();
}

class _TreatmentOffersPageState extends State<TreatmentOffersPage> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final offers = MockInsuranceRepository.instance.treatmentOffers;
    final filteredOffers = _selectedFilter == 'All'
        ? offers
        : offers.where((o) => o.status.toLowerCase() == _selectedFilter.toLowerCase()).toList();

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
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    _buildEstimatedSavingsBanner(context),
                    const SizedBox(height: 16),
                    _buildFilterTabs(context),
                    const SizedBox(height: 16),
                    ...filteredOffers.map((offer) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildOfferCard(context, offer),
                        )),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
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
          Image.asset(
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
          Stack(
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
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF28006D)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Treatment Offers',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5AF8FB),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'LIVE',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        color: const Color(0xFF002020),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Personalized clinical savings & financing',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: const Color(0xFF494552),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.offerStatusHistory);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE5EEFF),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.history, size: 16, color: Color(0xFF28006D)),
                const SizedBox(width: 4),
                Text(
                  'History',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: const Color(0xFF28006D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEstimatedSavingsBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3F1D8B), Color(0xFF28006D)],
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ESTIMATED TOTAL SAVINGS',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xFFAB8EFD),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                r'$345.00',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Across active clinic proposals',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color(0xFFD3E4FE),
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.savings_outlined, color: Color(0xFF56F5F8), size: 26),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    final filters = [
      {'name': 'All', 'count': '3'},
      {'name': 'Pending', 'count': '2'},
      {'name': 'Accepted', 'count': '1'},
      {'name': 'Declined', 'count': '1'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((f) {
          final isSelected = _selectedFilter.toLowerCase() == f['name']!.toLowerCase();
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = f['name']!;
                });
              },
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF28006D) : const Color(0xFFE5EEFF),
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF28006D).withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f['name']!,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: isSelected ? Colors.white : const Color(0xFF494552),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.25)
                            : (f['name'] == 'Pending'
                                ? const Color(0xFFFFDBC9)
                                : (f['name'] == 'Accepted' ? const Color(0xFF00696B) : const Color(0xFFD3E4FE))),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          f['count']!,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: isSelected
                                ? Colors.white
                                : (f['name'] == 'Pending'
                                    ? const Color(0xFF71360D)
                                    : (f['name'] == 'Accepted' ? Colors.white : const Color(0xFF494552))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, TreatmentOfferItem offer) {
    final isAccepted = offer.status == 'Accepted';
    final isDeclined = offer.status == 'Declined';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top category & status pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        offer.category.contains('Dental')
                            ? Icons.medical_services_outlined
                            : (offer.category.contains('Ophthalmology')
                                ? Icons.visibility_outlined
                                : (offer.category.contains('Pathology')
                                    ? Icons.biotech_outlined
                                    : Icons.favorite_border)),
                        size: 18,
                        color: const Color(0xFF28006D),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.category,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: const Color(0xFF28006D),
                          ),
                        ),
                        Text(
                          offer.subtitle,
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: const Color(0xFF494552),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _buildStatusPill(offer.status),
              ],
            ),
            const SizedBox(height: 12),
            // Title
            Text(
              offer.title,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: const Color(0xFF0B1C30),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            // Doctor attribution row
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: offer.doctorAvatar.isNotEmpty
                        ? Image.asset(
                            offer.doctorAvatar,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 16),
                          )
                        : const Icon(Icons.person, size: 16, color: Color(0xFF28006D)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    offer.doctorAttribution,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Financial Bento Box
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
                        offer.discountBadge,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: isAccepted ? const Color(0xFF00696B) : const Color(0xFF00696B),
                        ),
                      ),
                      Text(
                        '\$${offer.originalAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: const Color(0xFF7A7583),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        isAccepted
                            ? 'Paid Full Settlement'
                            : (offer.monthlyInstallment != null ? 'Flexible Monthly' : 'Final Patient Responsibility'),
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: const Color(0xFF494552),
                        ),
                      ),
                      Text(
                        offer.monthlyInstallment ?? '\$${offer.amount.toStringAsFixed(2)}',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: isAccepted ? const Color(0xFF00696B) : const Color(0xFF28006D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Validity row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event_outlined, size: 14, color: Color(0xFF5D2700)),
                    const SizedBox(width: 4),
                    Text(
                      isAccepted
                          ? 'Activated & Scheduled'
                          : (isDeclined ? 'Declined on Sep 04' : 'Valid until ${offer.validUntil}'),
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: isAccepted
                            ? const Color(0xFF00696B)
                            : (isDeclined ? const Color(0xFFBA1A1A) : const Color(0xFF5D2700)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isAccepted
                        ? const Color(0xFFE5EEFF)
                        : (isDeclined ? const Color(0xFFEFF4FF) : const Color(0xFFFFDBC9).withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isAccepted ? 'Accepted Oct 18' : (isDeclined ? 'Archived' : '12 days left'),
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: isAccepted
                          ? const Color(0xFF00696B)
                          : (isDeclined ? const Color(0xFF7A7583) : const Color(0xFF71360D)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // CTA Button
            _buildCTAButton(context, offer),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill(String status) {
    if (status == 'Accepted') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF00696B),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check, size: 12, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              'ACCEPTED',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else if (status == 'Declined') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE5EEFF),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Text(
          'DECLINED',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: const Color(0xFF7A7583),
            letterSpacing: 0.5,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFDBC9),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFDD8D5D),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'PENDING',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: const Color(0xFF71360D),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCTAButton(BuildContext context, TreatmentOfferItem offer) {
    if (offer.status == 'Accepted') {
      return SizedBox(
        width: double.infinity,
        height: 44,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.offerAcceptedConfirmation);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFE5EEFF),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.receipt_long_outlined, size: 16, color: Color(0xFF28006D)),
              const SizedBox(width: 8),
              Text(
                'View Receipt',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: const Color(0xFF28006D),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (offer.status == 'Declined') {
      return SizedBox(
        width: double.infinity,
        height: 44,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.offerRejectedConfirmation);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFEFF4FF),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            'Request New Quote',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: const Color(0xFF494552),
            ),
          ),
        ),
      );
    } else {
      // Pending
      return SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: () {
            if (offer.monthlyInstallment != null) {
              Navigator.pushNamed(context, AppRoutes.financingOptionDetails);
            } else {
              Navigator.pushNamed(context, AppRoutes.treatmentOfferDetails);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
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
                  Text(
                    'Review Offer',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

