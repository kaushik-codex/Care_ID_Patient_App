import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:care_id_patient_app/core/routing/app_routes.dart';

/// Add Health Record (Figma node 20:33245)
class AddHealthRecordPage extends StatefulWidget {
  const AddHealthRecordPage({super.key});

  @override
  State<AddHealthRecordPage> createState() => _AddHealthRecordPageState();
}

class _AddHealthRecordPageState extends State<AddHealthRecordPage> {
  final TextEditingController _bpController = TextEditingController(text: '120/80');
  final TextEditingController _hrController = TextEditingController(text: '72');
  final TextEditingController _tempController = TextEditingController(text: '36.6');
  final TextEditingController _notesController = TextEditingController(
    text: 'Feeling a bit sluggish this morning. The headache started around 8 AM but eased off after breakfast. Fever seems stable for now.',
  );

  final Set<String> _selectedSymptoms = {'Headache', 'Fever'};

  final List<String> _availableSymptoms = [
    'Headache',
    'Fatigue',
    'Fever',
    'Cough',
    'Nausea',
    'Dizziness',
  ];

  @override
  void dispose() {
    _bpController.dispose();
    _hrController.dispose();
    _tempController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSaveRecord() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.recordSavedSuccess);
  }

  void _showAddCustomSymptomDialog() {
    final customController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(
          'Add Other Symptom',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        content: TextField(
          controller: customController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter symptom name...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = customController.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _availableSymptoms.add(text);
                  _selectedSymptoms.add(text);
                });
              }
              Navigator.of(dialogCtx).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Scrollable Form Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 72,
                bottom: 110,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header: Add to Records + Unit: Metric (Figma node 20:33258)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add to Records',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'UNIT: METRIC',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Blood Pressure Field (Figma node 20:33264)
                  _buildVitalInputCard(
                    icon: Icons.favorite_rounded,
                    iconBg: const Color(0xFFFEF2F2),
                    iconColor: const Color(0xFFEF4444),
                    title: 'Blood Pressure',
                    controller: _bpController,
                    unit: 'mmHg',
                  ),

                  const SizedBox(height: 12),

                  // Heart Rate Field (Figma node 20:33276)
                  _buildVitalInputCard(
                    icon: Icons.speed_rounded,
                    iconBg: const Color(0xFFF0F9FF),
                    iconColor: const Color(0xFF0284C7),
                    title: 'Heart Rate',
                    controller: _hrController,
                    unit: 'BPM',
                  ),

                  const SizedBox(height: 12),

                  // Temperature Field (Figma node 20:33292)
                  _buildVitalInputCard(
                    icon: Icons.thermostat_rounded,
                    iconBg: const Color(0xFFFFF7ED),
                    iconColor: const Color(0xFFF97316),
                    title: 'Temperature',
                    controller: _tempController,
                    unit: '°C',
                  ),

                  const SizedBox(height: 24),

                  // Symptoms Selection Section (Figma node 20:33308)
                  Text(
                    'Symptoms',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      ..._availableSymptoms.map((symptom) {
                        final isSelected = _selectedSymptoms.contains(symptom);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedSymptoms.remove(symptom);
                              } else {
                                _selectedSymptoms.add(symptom);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                      colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                                    )
                                  : null,
                              color: isSelected ? null : Colors.white,
                              borderRadius: BorderRadius.circular(9999),
                              border: Border.all(
                                color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
                              ),
                              boxShadow: isSelected
                                  ? const [
                                      BoxShadow(
                                        color: Color(0x265B14B8),
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  symptom,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF475569),
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),

                      // Add Other Button (Figma node 20:33330)
                      GestureDetector(
                        onTap: _showAddCustomSymptomDialog,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(9999),
                            border: Border.all(
                              color: const Color(0xFFCBD5E1),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add_rounded,
                                size: 16,
                                color: Color(0xFF0284C7),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Add Other',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0284C7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Notes Textarea Section (Figma node 20:33335)
                  Text(
                    'Notes',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _notesController,
                      maxLines: 4,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: const Color(0xFF334155),
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'How are you feeling today? Add any additional details...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Attachments Section (Figma node 20:33342)
                  Row(
                    children: [
                      Text(
                        'Attachments',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(Optional)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildAttachmentPickerButton(
                        icon: Icons.camera_alt_outlined,
                        label: 'Capture',
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.scanReports);
                        },
                      ),
                      const SizedBox(width: 14),
                      _buildAttachmentPickerButton(
                        icon: Icons.file_upload_outlined,
                        label: 'Upload',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'File picker simulated: Document attached.',
                                style: GoogleFonts.plusJakartaSans(fontSize: 13),
                              ),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Floating Save Button (Figma node 20:33360)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 14,
                bottom: 16 + MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withValues(alpha: 0.95),
                    Colors.white.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: GestureDetector(
                key: const Key('add_health_record_save_button'),
                onTap: _onSaveRecord,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: double.infinity,
                  height: 56,
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
                        color: Color(0x335B14B8),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.35,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Fixed Top App Bar (Figma node 20:33247)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(context),
          ),
        ],
      ),
    );
  }

  /// Top App Bar (Figma node 20:33247)
  Widget _buildTopAppBar(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64 + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.90),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFFF1F5F9),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Back button + Title + Badge
              Row(
                children: [
                  GestureDetector(
                    key: const Key('add_health_record_back_button'),
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/qr_preview_back.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add Record',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/card_id_badge.png',
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              // Right: Notification Bell
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/home_bell.svg',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Vital Input Card (Figma node 20:33264)
  Widget _buildVitalInputCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required TextEditingController controller,
    required String unit,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, color: iconColor, size: 22),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      unit,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF94A3B8),
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

  /// Attachment Box Button (Figma node 20:33348)
  Widget _buildAttachmentPickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: const Color(0xFF64748B)),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

