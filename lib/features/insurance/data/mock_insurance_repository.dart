import '../domain/models/insurance_models.dart';

class MockInsuranceRepository {
  MockInsuranceRepository._();
  static final MockInsuranceRepository instance = MockInsuranceRepository._();

  InsurancePolicy _primaryPolicy = const InsurancePolicy(
    id: 'pol-001',
    providerName: 'BlueCross BlueShield PPO',
    memberName: 'Alexander J. Thompson',
    policyNumber: 'HVT-9923-X8',
    groupNumber: '12903-X',
    payerId: 'BCBS-GLOBAL-88',
    rxBin: '004336',
    rxPcn: 'ADV',
    rxGroup: 'RX992-P',
    planType: 'Individual PPO Premium',
    effectiveDate: 'January 01, 2024',
    expiryDate: '12 / 2026',
    deductibleAnnual: r'$250.00 / Year',
    totalBenefitsUsed: 1240.0,
    totalBenefitsMax: 5000.0,
    inpatientCoveragePercent: 95,
    prescriptionCoveragePercent: 80,
    isVerified: true,
    status: 'Active',
    emergencyPhone: '1-800-HEALTH-360',
  );

  InsurancePolicy get primaryPolicy => _primaryPolicy;

  void updatePrimaryPolicy(InsurancePolicy updated) {
    _primaryPolicy = updated;
  }

  final List<InsuranceActivityItem> _activities = [
    const InsuranceActivityItem(
      id: 'act-01',
      title: 'Policy Verified',
      description: 'Your BlueCross PPO was successfully re-verified.',
      timestamp: '2d ago',
      type: 'verified',
    ),
    const InsuranceActivityItem(
      id: 'act-02',
      title: 'New Claim Submitted',
      description: 'Annual physical exam claim #920-X.',
      timestamp: '5d ago',
      type: 'claim',
    ),
    const InsuranceActivityItem(
      id: 'act-03',
      title: 'Details Updated',
      description: 'You updated the emergency contact info.',
      timestamp: '1w ago',
      type: 'updated',
    ),
  ];

  List<InsuranceActivityItem> get activities => List.unmodifiable(_activities);

  final List<TreatmentOfferItem> _treatmentOffers = [
    const TreatmentOfferItem(
      id: 'offer-01',
      providerName: 'St. Jude Specialty Dental',
      title: 'St. Jude Specialty Dental',
      subtitle: 'Crown & Implant Package • Valid for 14d',
      amount: 1240.0,
      discountBadge: '-15% bundled',
      isPending: true,
    ),
    const TreatmentOfferItem(
      id: 'offer-02',
      providerName: 'Apex Diagnostics Lab',
      title: 'Apex Diagnostics Lab',
      subtitle: 'Full Biometric Panel • Valid for 6d',
      amount: 180.0,
      discountBadge: '-30% partner',
      isPending: true,
    ),
  ];

  List<TreatmentOfferItem> get treatmentOffers => List.unmodifiable(_treatmentOffers);

  final List<PartnerHospital> _partnerHospitals = [
    const PartnerHospital(
      id: 'hosp-01',
      name: 'Metro Health Academic Center',
      subtitle: 'Accepts 0% Financing & Direct Discounts',
      distance: '2.4 miles away • In-Network',
      imageAsset: 'assets/images/e99affd91b9cf73e272a31f7fb4c07a40f4cb10e.png',
    ),
  ];

  List<PartnerHospital> get partnerHospitals => List.unmodifiable(_partnerHospitals);
}

