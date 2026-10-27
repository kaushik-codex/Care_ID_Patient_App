import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';

/// Page 5: Health_info (Figma node 20:30900)
///
/// Onboarding Step 3 of 6: Personal & Clinical Profile
/// Provides a comprehensive clinical intake screen for blood group, height/weight,
/// medical history, allergies, current medications, surgical procedures,
/// and family history with pixel-level fidelity to the Figma canvas.
class HealthInfoPage extends StatefulWidget {
  const HealthInfoPage({super.key});

  @override
  State<HealthInfoPage> createState() => _HealthInfoPageState();
}

class _HealthInfoPageState extends State<HealthInfoPage> {
  // Top Header State
  String _selectedLanguage = 'EN';

  // Section 1: Basic Health Information
  String _selectedBloodGroup = 'O+';
  String _heightUnit = 'cm'; // 'cm' or 'ft & in'
  String _weightUnit = 'kg'; // 'kg' or 'lb'
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;

  // Section 2: Medical History (multi-select)
  final Set<String> _selectedMedicalHistory = {'High Blood Pressure'};

  // Section 3: Allergies
  String _activeAllergyCategory = 'Medication';
  final List<String> _recordedAllergies = ['Penicillin (Mild rash)'];

  // Section 4: Current Medications
  bool _noMedications = false;
  final List<Map<String, String>> _medications = [
    {
      'name': 'Atorvastatin 20mg',
      'schedule': '1 tablet daily • Evening',
    },
  ];

  // Section 5: Previous Surgeries
  bool _noSurgeries = true; // Checked by default in Figma
  final List<String> _surgeries = [];

  // Section 6: Family Health History (multi-select)
  final Set<String> _selectedFamilyHistory = {'Diabetes'};

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController(text: '175');
    _weightController = TextEditingController(text: '70');
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _onSaveAndContinue() {
    Navigator.of(context).pushNamed(AppRoutes.addInsurance);
  }

  void _onSkipForNow() {
    Navigator.of(context).pushNamed(AppRoutes.addInsurance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top App Bar Header (Figma frame 20:31157)
              _buildTopHeader(),

              const SizedBox(height: 16),

              // 2. Step Progress Indicator ("VERIFICATION STEP" + "Step 3 of 6")
              _buildStepProgressIndicator(),

              const SizedBox(height: 20),

              // 3. Heading & Subtitle
              _buildHeaderSection(),

              const SizedBox(height: 24),

              // 4. Section 1: Basic Health Information
              _buildBasicHealthSection(),

              const SizedBox(height: 24),

              // 5. Section 2: Medical History
              _buildMedicalHistorySection(),

              const SizedBox(height: 24),

              // 6. Section 3: Allergies
              _buildAllergiesSection(),

              const SizedBox(height: 24),

              // 7. Section 4: Current Medications
              _buildCurrentMedicationsSection(),

              const SizedBox(height: 24),

              // 8. Section 5: Previous Surgeries or Major Procedures
              _buildSurgeriesSection(),

              const SizedBox(height: 24),

              // 9. Section 6: Family Health History
              _buildFamilyHistorySection(),

              const SizedBox(height: 24),

              // 10. Section 7: Optional Document Notice Card
              _buildDocumentNoticeCard(),

              const SizedBox(height: 28),

              // 11. Actions & Navigation Buttons
              _buildActionsSection(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HEADER (Dead centered logo & right aligned EN/ESP pill)
  // ===========================================================================
  Widget _buildTopHeader() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dead Center: CareID Logo (CareIDlogo 1, node 20:31158)
          Center(
            child: Image.asset(
              'assets/images/care_id_logo_wordmark.png',
              width: 79,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),

          // Right Aligned: Language Selector Pill (node 20:31159)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 32,
              width: 92,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FE),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: const Color(0xFFC0C6D6), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedLanguage = 'EN'),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: _selectedLanguage == 'EN'
                              ? const Color(0xFF5B14B8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'EN',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: _selectedLanguage == 'EN'
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: _selectedLanguage == 'EN'
                                ? Colors.white
                                : const Color(0xFF414754),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedLanguage = 'ESP'),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: _selectedLanguage == 'ESP'
                              ? const Color(0xFF5B14B8)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'ESP',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: _selectedLanguage == 'ESP'
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: _selectedLanguage == 'ESP'
                                ? Colors.white
                                : const Color(0xFF414754),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. STEP PROGRESS INDICATOR (Figma frame 20:30904)
  // ===========================================================================
  Widget _buildStepProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VERIFICATION STEP',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00696B),
                letterSpacing: 0.6,
              ),
            ),
            Text(
              'Step 3 of 6',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF494552),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFDCE9FF),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.50, // Step 3 of 6 = 50%
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF28006D),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 3. HEADER SECTION (Figma frame 20:30913)
  // ===========================================================================
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell us about your health',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1C30),
            letterSpacing: -0.7,
            height: 1.28,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Your health history helps Care ID organize your information and provide a more complete health profile.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF494552),
            height: 1.625,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. SECTION 1: BASIC HEALTH INFORMATION (Figma frame 20:30919)
  // ===========================================================================
  Widget _buildBasicHealthSection() {
    final bloodGroups = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
      'Unknown / Not sure',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/pulse_health.svg',
                width: 20,
                height: 15,
              ),
              const SizedBox(width: 8),
              Text(
                'Basic Health Information',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Blood Group Label
          Text(
            'Blood Group',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0B1C30),
            ),
          ),

          const SizedBox(height: 10),

          // Blood Group Chips Wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: bloodGroups.map((group) {
              final isSelected = _selectedBloodGroup == group;
              return GestureDetector(
                onTap: () => setState(() => _selectedBloodGroup = group),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? null : const Color(0xFFEFF4FF),
                    gradient: isSelected
                        ? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    group,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.white : const Color(0xFF494552),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Height Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Height',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    _buildUnitToggle(
                      options: const ['cm', 'ft & in'],
                      selected: _heightUnit,
                      onSelect: (val) => setState(() => _heightUnit = val),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0B1C30),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _heightUnit == 'cm' ? 'cm' : 'ft',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Weight Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weight',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                    _buildUnitToggle(
                      options: const ['kg', 'lb'],
                      selected: _weightUnit,
                      onSelect: (val) => setState(() => _weightUnit = val),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF0B1C30),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _weightUnit,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF494552),
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

  Widget _buildUnitToggle({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9FF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((opt) {
          final isSelected = selected == opt;
          return GestureDetector(
            onTap: () => onSelect(opt),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                opt,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? const Color(0xFF0B1C30) : const Color(0xFF494552),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================================================================
  // 5. SECTION 2: MEDICAL HISTORY (Figma frame 20:30988)
  // ===========================================================================
  Widget _buildMedicalHistorySection() {
    final conditions = [
      'Diabetes',
      'High Blood Pressure',
      'Heart Condition',
      'Asthma',
      'Kidney Condition',
      'Liver Condition',
      'Thyroid Condition',
      'Cancer',
      'High Cholesterol',
      'None of these',
      'Other',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/medical_history.svg',
                width: 18,
                height: 15,
              ),
              const SizedBox(width: 8),
              Text(
                'Medical History',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Select anything that applies to you.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: conditions.map((item) {
              final isSelected = _selectedMedicalHistory.contains(item);
              final isOther = item == 'Other';

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (item == 'None of these') {
                      _selectedMedicalHistory.clear();
                      _selectedMedicalHistory.add('None of these');
                    } else {
                      _selectedMedicalHistory.remove('None of these');
                      if (isSelected) {
                        _selectedMedicalHistory.remove(item);
                      } else {
                        _selectedMedicalHistory.add(item);
                      }
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF00696B) : const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.white : const Color(0xFF494552),
                        ),
                      ),
                      if (isOther) ...[
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/plus_small.svg',
                          width: 9,
                          height: 9,
                          colorFilter: ColorFilter.mode(
                            isSelected ? Colors.white : const Color(0xFF494552),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. SECTION 3: ALLERGIES (Figma frame 20:31022)
  // ===========================================================================
  Widget _buildAllergiesSection() {
    final categories = [
      'No known allergies',
      'Medication',
      'Food',
      'Environmental',
      'Other',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
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
                  SvgPicture.asset(
                    'assets/icons/allergies_alert.svg',
                    width: 20,
                    height: 17,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Allergies',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFD3E4FE),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '${_recordedAllergies.length} Recorded',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00696B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Include food, medication, or environmental triggers.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((cat) {
              final isActive = _activeAllergyCategory == cat;
              return GestureDetector(
                onTap: () => setState(() => _activeAllergyCategory = cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFE8DDFF) : const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive ? const Color(0xFF21005D) : const Color(0xFF494552),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          // Added Allergy Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _recordedAllergies.map((allergy) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDAD6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/allergy_pill.svg',
                      width: 9,
                      height: 12,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      allergy,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF93000A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(() => _recordedAllergies.remove(allergy)),
                      behavior: HitTestBehavior.opaque,
                      child: SvgPicture.asset(
                        'assets/icons/remove_tag_x.svg',
                        width: 9,
                        height: 9,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          // Add another allergy button
          GestureDetector(
            onTap: () {
              setState(() {
                if (!_recordedAllergies.contains('Latex (Skin redness)')) {
                  _recordedAllergies.add('Latex (Skin redness)');
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFDCE9FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/plus_teal.svg',
                    width: 9,
                    height: 9,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Add another allergy',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00696B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. SECTION 4: CURRENT MEDICATIONS (Figma frame 20:31057)
  // ===========================================================================
  Widget _buildCurrentMedicationsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/medication_section.svg',
                width: 17,
                height: 17,
              ),
              const SizedBox(width: 8),
              Text(
                'Current Medications',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Add medicines you currently take, if any.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          if (!_noMedications) ...[
            ..._medications.map((med) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF4FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5AF8FB),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/capsule_cyan.svg',
                        width: 17,
                        height: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med['name'] ?? '',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            med['schedule'] ?? '',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/edit_medication.svg',
                          width: 14,
                          height: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _medications.remove(med)),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/delete_medication.svg',
                          width: 12,
                          height: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            GestureDetector(
              onTap: () {
                setState(() {
                  _medications.add({
                    'name': 'Metformin 500mg',
                    'schedule': '1 tablet twice daily • Morning & Night',
                  });
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/add_medication_plus.svg',
                      width: 15,
                      height: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Add Medication',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3F1D8B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Checkbox: "I don't currently take any medication"
          GestureDetector(
            onTap: () => setState(() {
              _noMedications = !_noMedications;
              if (_noMedications) _medications.clear();
            }),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _noMedications ? const Color(0xFF28006D) : Colors.white,
                    borderRadius: BorderRadius.circular(2.5),
                    border: Border.all(
                      color: _noMedications ? const Color(0xFF28006D) : const Color(0xFF767676),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _noMedications
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 10),
                Text(
                  "I don't currently take any medication",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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

  // ===========================================================================
  // 8. SECTION 5: PREVIOUS SURGERIES (Figma frame 20:31091)
  // ===========================================================================
  Widget _buildSurgeriesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/surgeries_procedures.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Previous Surgeries or Major Procedures',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Document previous operations to keep surgical history intact.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          if (!_noSurgeries) ...[
            ..._surgeries.map((surg) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(surg, style: GoogleFonts.plusJakartaSans(fontSize: 14)),
                      GestureDetector(
                        onTap: () => setState(() => _surgeries.remove(surg)),
                        child: const Icon(Icons.close, size: 16),
                      ),
                    ],
                  ),
                )),
          ],
          GestureDetector(
            onTap: () {
              setState(() {
                _noSurgeries = false;
                _surgeries.add('Appendectomy (2018)');
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/plus_procedure.svg',
                    width: 11,
                    height: 11,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Add Procedure',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() {
              _noSurgeries = !_noSurgeries;
              if (_noSurgeries) _surgeries.clear();
            }),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _noSurgeries ? const Color(0xFF28006D) : Colors.white,
                    borderRadius: BorderRadius.circular(2.5),
                    border: Border.all(
                      color: _noSurgeries ? const Color(0xFF28006D) : const Color(0xFF767676),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _noSurgeries
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'I have no previous surgeries or major procedures',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 9. SECTION 6: FAMILY HEALTH HISTORY (Figma frame 20:31108)
  // ===========================================================================
  Widget _buildFamilyHistorySection() {
    final familyConditions = [
      'Heart Disease',
      'Diabetes',
      'High Blood Pressure',
      'Cancer',
      'Stroke',
      'Other',
      'None known',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/family_health.svg',
                width: 22,
                height: 17,
              ),
              const SizedBox(width: 8),
              Text(
                'Family Health History',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B1C30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Select conditions present in your direct family lines.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: familyConditions.map((item) {
              final isSelected = _selectedFamilyHistory.contains(item);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (item == 'None known') {
                      _selectedFamilyHistory.clear();
                      _selectedFamilyHistory.add('None known');
                    } else {
                      _selectedFamilyHistory.remove('None known');
                      if (isSelected) {
                        _selectedFamilyHistory.remove(item);
                      } else {
                        _selectedFamilyHistory.add(item);
                      }
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF3F1D8B) : const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    item,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.white : const Color(0xFF494552),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 10. SECTION 7: OPTIONAL DOCUMENT NOTICE CARD (Figma frame 20:31131)
  // ===========================================================================
  Widget _buildDocumentNoticeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF56F5F8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/document_folder.svg',
              width: 17,
              height: 13,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Already have health documents?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Add past medical documents later directly from your Care ID Vault. Document upload is not required right now.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.625,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 11. ACTIONS & NAVIGATION SECTION (Figma frame 20:31140)
  // ===========================================================================
  Widget _buildActionsSection() {
    return Column(
      children: [
        // Primary Gradient CTA: "Save & Continue →"
        GestureDetector(
          onTap: _onSaveAndContinue,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA44CFF),
                  Color(0xFF5B14B8),
                ],
              ),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save & Continue',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/arrow_right_white.svg',
                  width: 14,
                  height: 14,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Secondary Text Button: "Skip for now"
        GestureDetector(
          onTap: _onSkipForNow,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            child: Text(
              'Skip for now',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF494552),
              ),
            ),
          ),
        ),

        const SizedBox(height: 4),

        // Helper Copy
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'You can complete or revise your health history later from your Care ID Vault.',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF494552),
              height: 1.33,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Bottom Security Trust Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE5EEFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/lock_vault_blue.svg',
                width: 11,
                height: 14,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Your health information is encrypted and securely stored in your Care ID Vault.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
