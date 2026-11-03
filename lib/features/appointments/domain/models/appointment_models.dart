class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String category; // 'All', 'Medical', 'Dental', 'Vision', 'General Medicine'
  final String clinic;
  final String address;
  final double? rating;
  final int reviewsCount;
  final int yearsExperience;
  final String patientsCount;
  final String successRate;
  final bool isVerified;
  final bool isPrimary;
  final String avatarAsset;
  final String bio;
  final List<String> education;
  final List<String> languages;
  final List<String> acceptedInsurances;
  final String copayAmount;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.category,
    required this.clinic,
    required this.address,
    this.rating,
    this.reviewsCount = 0,
    this.yearsExperience = 10,
    this.patientsCount = '2.5k+',
    this.successRate = '98%',
    this.isVerified = true,
    this.isPrimary = false,
    required this.avatarAsset,
    required this.bio,
    this.education = const [],
    this.languages = const ['English'],
    this.acceptedInsurances = const [],
    this.copayAmount = r'$35 Copay',
  });
}

class ConsultationOption {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String price;
  final String iconSvg;

  const ConsultationOption({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.price,
    required this.iconSvg,
  });
}

enum AppointmentStatus { upcoming, completed, cancelled }

class PatientAppointment {
  final String id;
  final Doctor doctor;
  final ConsultationOption consultationType;
  final DateTime appointmentDate;
  final String timeSlot;
  final String duration;
  final AppointmentStatus status;
  final String patientName;
  final String careIdNumber;
  final String reasonForVisit;
  final String copay;
  final String insuranceName;
  final int vaultRecordsSynced;
  final String qrPassRef;

  const PatientAppointment({
    required this.id,
    required this.doctor,
    required this.consultationType,
    required this.appointmentDate,
    required this.timeSlot,
    this.duration = '45 min',
    required this.status,
    this.patientName = 'Sarah Jenkins',
    this.careIdNumber = 'CID #8472-9901',
    required this.reasonForVisit,
    this.copay = r'$35.00',
    this.insuranceName = 'Blue Cross Blue Shield • PPO Gold',
    this.vaultRecordsSynced = 5,
    required this.qrPassRef,
  });
}

