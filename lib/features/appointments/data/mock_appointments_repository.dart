import '../domain/models/appointment_models.dart';

class MockAppointmentsRepository {
  MockAppointmentsRepository._();
  static final MockAppointmentsRepository instance = MockAppointmentsRepository._();

  // Test toggles
  bool simulateLoading = false;
  bool simulateError = false;
  bool simulateEmpty = false;

  final List<Doctor> _doctors = [
    const Doctor(
      id: 'doc_1',
      name: 'Dr. Julian Vance, DDS',
      specialty: 'Restorative Dentistry & Orthodontics',
      category: 'Dental',
      clinic: 'City Dental Care • Metro Pavilion',
      address: '452 Lexington Ave, Floor 8, New York, NY 10017',
      rating: 4.9,
      reviewsCount: 128,
      yearsExperience: 12,
      patientsCount: '3.2k+',
      successRate: '99%',
      isVerified: true,
      isPrimary: false,
      avatarAsset: 'assets/images/doctor_julian_vance.png',
      bio:
          'Specialist in restorative dentistry, smile makeovers, and orthodontic care with over a decade of clinical experience.',
      education: [
        'NYU College of Dentistry — DDS',
        'Columbia University — Orthodontics Fellowship',
      ],
      languages: ['English', 'Spanish'],
      acceptedInsurances: [
        'Delta Dental',
        'MetLife Dental',
        'Cigna Dental',
        'Guardian',
      ],
      copayAmount: r'$25 Copay',
    ),
    const Doctor(
      id: 'doc_2',
      name: 'Dr. Sarah Jenkins, MD',
      specialty: 'Cardiology & Internal Medicine',
      category: 'Medical',
      clinic: 'Mount Sinai Hospital • Building B, Room 402',
      address: '1190 5th Ave, Suite 400, New York, NY 10029',
      rating: 4.9,
      reviewsCount: 128,
      yearsExperience: 14,
      patientsCount: '4.8k+',
      successRate: '99%',
      isVerified: true,
      isPrimary: true,
      avatarAsset: 'assets/images/doctor_sarah_jenkins.png',
      bio:
          'Board-certified cardiologist specializing in preventive cardiology, cardiovascular diagnostics, and heart failure management at Mount Sinai.',
      education: [
        'Harvard Medical School — MD with Honors',
        'Stanford University Medical Center — Cardiology Fellowship',
      ],
      languages: ['English', 'Spanish', 'French'],
      acceptedInsurances: [
        'Blue Cross Blue Shield',
        'Aetna Choice POS II',
        'Cigna Open Access Plus',
        'UnitedHealthcare Choice',
        'Medicare Part B',
      ],
      copayAmount: r'$35 Copay',
    ),
    const Doctor(
      id: 'doc_3',
      name: 'Dr. Laura Zhao, OD',
      specialty: 'Optometry & Retinal Diagnostics',
      category: 'Vision',
      clinic: 'VisionCare Eye Specialists',
      address: '780 3rd Ave, Suite 1200, New York, NY 10017',
      rating: null,
      reviewsCount: 0,
      yearsExperience: 8,
      patientsCount: '1.9k+',
      successRate: '98%',
      isVerified: true,
      isPrimary: false,
      avatarAsset: 'assets/images/doctor_laura_zhao.png',
      bio:
          'Specializes in comprehensive eye examinations, glaucoma management, and advanced retinal OCT tomography imaging.',
      education: [
        'SUNY College of Optometry — OD',
        'Bascom Palmer Eye Institute — Retinal Diagnostics Residency',
      ],
      languages: ['English', 'Mandarin'],
      acceptedInsurances: [
        'VSP Vision Care',
        'EyeMed',
        'Davis Vision',
        'Blue Cross Blue Shield',
      ],
      copayAmount: r'$20 Copay',
    ),
    const Doctor(
      id: 'doc_4',
      name: 'Dr. Marcus Thorne, DVM',
      specialty: 'Veterinary Medicine & Surgery',
      category: 'General Medicine',
      clinic: 'Central Park Veterinary Center',
      address: '210 Central Park South, New York, NY 10019',
      rating: 4.8,
      reviewsCount: 94,
      yearsExperience: 11,
      patientsCount: '3.5k+',
      successRate: '99%',
      isVerified: true,
      isPrimary: false,
      avatarAsset: 'assets/images/doctor_marcus_thorne.png',
      bio:
          'Compassionate companion animal physician providing comprehensive wellness, surgery, and diagnostics for family pets.',
      education: [
        'Cornell University College of Veterinary Medicine — DVM',
      ],
      languages: ['English'],
      acceptedInsurances: [
        'Trupanion',
        'Nationwide Pet',
        'Healthy Paws',
      ],
      copayAmount: r'$45 Visit',
    ),
  ];

  final List<ConsultationOption> _consultationOptions = [
    const ConsultationOption(
      id: 'in_person',
      title: 'In-Person Consultation',
      description:
          'Comprehensive physical examination and review at Mount Sinai Heart Center.',
      duration: '45 min',
      price: '\$150',
      iconSvg: 'assets/icons/hospital_building.svg',
    ),
    const ConsultationOption(
      id: 'telehealth',
      title: 'Telehealth Video Visit',
      description:
          'Virtual consultation via high-definition encrypted CareID portal from home.',
      duration: '30 min',
      price: '\$75',
      iconSvg: 'assets/icons/video_camera.svg',
    ),
    const ConsultationOption(
      id: 'follow_up',
      title: 'Follow-Up Review',
      description:
          'Quick review of lab results, medication adjustments, or test feedback.',
      duration: '20 min',
      price: '\$50',
      iconSvg: 'assets/icons/clock_timer.svg',
    ),
  ];

  List<PatientAppointment> _appointments = [];

  List<Doctor> getDoctors({String category = 'All', String query = ''}) {
    if (simulateEmpty) return [];
    return _doctors.where((doc) {
      final matchesCategory = (category == 'All' || doc.category == category);
      final matchesQuery = query.isEmpty ||
          doc.name.toLowerCase().contains(query.toLowerCase()) ||
          doc.specialty.toLowerCase().contains(query.toLowerCase()) ||
          doc.clinic.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Doctor? getDoctorById(String id) {
    try {
      return _doctors.firstWhere((d) => d.id == id);
    } catch (_) {
      return _doctors[1]; // default to Dr. Sarah Jenkins
    }
  }

  List<ConsultationOption> getConsultationOptions() => _consultationOptions;

  List<PatientAppointment> getAppointments({AppointmentStatus? status}) {
    if (simulateEmpty) return [];
    _ensureInitialAppointments();
    if (status == null) return _appointments;
    return _appointments.where((a) => a.status == status).toList();
  }

  PatientAppointment? getAppointmentById(String id) {
    _ensureInitialAppointments();
    try {
      return _appointments.firstWhere((a) => a.id == id);
    } catch (_) {
      return _appointments.isNotEmpty ? _appointments.first : null;
    }
  }

  void addAppointment(PatientAppointment appointment) {
    _appointments.insert(0, appointment);
  }

  void _ensureInitialAppointments() {
    if (_appointments.isEmpty) {
      _appointments = [
        PatientAppointment(
          id: '#APT-88204-NY',
          doctor: _doctors[1], // Dr. Sarah Jenkins
          consultationType: _consultationOptions[0], // In-Person
          appointmentDate: DateTime.now().add(const Duration(days: 3)),
          timeSlot: '09:45 AM',
          duration: '45 min',
          status: AppointmentStatus.upcoming,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit:
              'Routine cardiovascular checkup and lipid panel analysis.',
          copay: '\$35.00',
          insuranceName: 'Blue Cross Blue Shield • PPO Gold',
          vaultRecordsSynced: 5,
          qrPassRef: 'APT-88204',
        ),
        PatientAppointment(
          id: '#APT-77192-NY',
          doctor: _doctors[0], // Dr. Julian Vance
          consultationType: _consultationOptions[0], // In-Person
          appointmentDate: DateTime.now().add(const Duration(days: 15)),
          timeSlot: '02:30 PM',
          duration: '30 min',
          status: AppointmentStatus.upcoming,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit:
              'Bi-annual dental hygiene cleaning and oral prophylaxis.',
          copay: '\$25.00',
          insuranceName: 'Delta Dental Premier',
          vaultRecordsSynced: 3,
          qrPassRef: 'APT-77192',
        ),
        PatientAppointment(
          id: '#APT-66102-NY',
          doctor: _doctors[2], // Dr. Laura Zhao
          consultationType: _consultationOptions[0],
          appointmentDate: DateTime.now().subtract(const Duration(days: 42)),
          timeSlot: '11:00 AM',
          duration: '45 min',
          status: AppointmentStatus.completed,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit: 'Annual comprehensive vision exam & retinal check.',
          copay: '\$20.00',
          insuranceName: 'VSP Vision Care',
          vaultRecordsSynced: 2,
          qrPassRef: 'APT-66102',
        ),
        PatientAppointment(
          id: '#APT-55019-NY',
          doctor: _doctors[1],
          consultationType: _consultationOptions[1], // Telehealth
          appointmentDate: DateTime.now().subtract(const Duration(days: 90)),
          timeSlot: '04:00 PM',
          duration: '30 min',
          status: AppointmentStatus.completed,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit: 'Medication refill consultation and BP log review.',
          copay: '\$0.00',
          insuranceName: 'Blue Cross Blue Shield • PPO Gold',
          vaultRecordsSynced: 4,
          qrPassRef: 'APT-55019',
        ),
        PatientAppointment(
          id: '#APT-44112-NY',
          doctor: _doctors[3], // Dr. Marcus Thorne
          consultationType: _consultationOptions[0],
          appointmentDate: DateTime.now().subtract(const Duration(days: 120)),
          timeSlot: '10:00 AM',
          duration: '30 min',
          status: AppointmentStatus.cancelled,
          patientName: 'Sarah Jenkins',
          careIdNumber: 'CID #8472-9901',
          reasonForVisit: 'Pet annual vaccine booster appointment.',
          copay: '\$45.00',
          insuranceName: 'Nationwide Pet',
          vaultRecordsSynced: 1,
          qrPassRef: 'APT-44112',
        ),
      ];
    }
  }
}

