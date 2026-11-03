/// Domain models for Phase 6: Insurance, Financing & Treatment Offers

class InsurancePolicy {
  final String id;
  final String providerName;
  final String memberName;
  final String policyNumber;
  final String groupNumber;
  final String payerId;
  final String rxBin;
  final String rxPcn;
  final String rxGroup;
  final String planType;
  final String effectiveDate;
  final String expiryDate;
  final String deductibleAnnual;
  final double totalBenefitsUsed;
  final double totalBenefitsMax;
  final int inpatientCoveragePercent;
  final int prescriptionCoveragePercent;
  final bool isVerified;
  final String status;
  final String emergencyPhone;

  const InsurancePolicy({
    required this.id,
    required this.providerName,
    required this.memberName,
    required this.policyNumber,
    required this.groupNumber,
    required this.payerId,
    required this.rxBin,
    required this.rxPcn,
    required this.rxGroup,
    required this.planType,
    required this.effectiveDate,
    required this.expiryDate,
    this.deductibleAnnual = r'$250.00 / Year',
    this.totalBenefitsUsed = 1240.0,
    this.totalBenefitsMax = 5000.0,
    this.inpatientCoveragePercent = 95,
    this.prescriptionCoveragePercent = 80,
    this.isVerified = true,
    this.status = 'Active',
    this.emergencyPhone = '1-800-HEALTH-360',
  });

  InsurancePolicy copyWith({
    String? id,
    String? providerName,
    String? memberName,
    String? policyNumber,
    String? groupNumber,
    String? payerId,
    String? rxBin,
    String? rxPcn,
    String? rxGroup,
    String? planType,
    String? effectiveDate,
    String? expiryDate,
    String? deductibleAnnual,
    double? totalBenefitsUsed,
    double? totalBenefitsMax,
    int? inpatientCoveragePercent,
    int? prescriptionCoveragePercent,
    bool? isVerified,
    String? status,
    String? emergencyPhone,
  }) {
    return InsurancePolicy(
      id: id ?? this.id,
      providerName: providerName ?? this.providerName,
      memberName: memberName ?? this.memberName,
      policyNumber: policyNumber ?? this.policyNumber,
      groupNumber: groupNumber ?? this.groupNumber,
      payerId: payerId ?? this.payerId,
      rxBin: rxBin ?? this.rxBin,
      rxPcn: rxPcn ?? this.rxPcn,
      rxGroup: rxGroup ?? this.rxGroup,
      planType: planType ?? this.planType,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      expiryDate: expiryDate ?? this.expiryDate,
      deductibleAnnual: deductibleAnnual ?? this.deductibleAnnual,
      totalBenefitsUsed: totalBenefitsUsed ?? this.totalBenefitsUsed,
      totalBenefitsMax: totalBenefitsMax ?? this.totalBenefitsMax,
      inpatientCoveragePercent: inpatientCoveragePercent ?? this.inpatientCoveragePercent,
      prescriptionCoveragePercent: prescriptionCoveragePercent ?? this.prescriptionCoveragePercent,
      isVerified: isVerified ?? this.isVerified,
      status: status ?? this.status,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
    );
  }
}

class InsuranceActivityItem {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  final String type; // 'verified', 'claim', 'updated'

  const InsuranceActivityItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });
}

class TreatmentOfferItem {
  final String id;
  final String providerName;
  final String title;
  final String subtitle;
  final double amount;
  final String discountBadge;
  final bool isPending;

  const TreatmentOfferItem({
    required this.id,
    required this.providerName,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.discountBadge,
    this.isPending = true,
  });
}

class PartnerHospital {
  final String id;
  final String name;
  final String subtitle;
  final String distance;
  final String imageAsset;

  const PartnerHospital({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.distance,
    required this.imageAsset,
  });
}

