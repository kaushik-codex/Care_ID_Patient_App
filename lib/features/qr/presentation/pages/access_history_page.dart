import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Status of the access granted in the timeline log
enum AccessStatus { active, expired, revoked }

/// Data model representing a single access log entry in Access History
class AccessLogItem {
  final String id;
  final String name;
  final String department;
  final AccessStatus status;
  final String timestamp;
  final String tag;
  final String iconAsset;
  final Color nodeBgColor;
  final bool isDoctor;

  const AccessLogItem({
    required this.id,
    required this.name,
    required this.department,
    required this.status,
    required this.timestamp,
    required this.tag,
    required this.iconAsset,
    required this.nodeBgColor,
    this.isDoctor = true,
  });
}

/// Page 18: Access History (Figma node 20:23450)
///
/// Comprehensive security audit log and shared access timeline:
/// - Frosted Top App Bar with back navigation, "Access History" title, patient avatar
/// - Search Input Box with real-time log querying
/// - Category Filter Pills: "All", "Doctors", "Facilities", and filter settings
/// - Access History Timeline:
///   * Dr. Marcus Thorne (Active, Clinical Review, stethoscope node)
///   * City General Hospital (Expired, Insurance Verification, hospital node)
///   * Dr. Sarah Chen (Revoked, Clinical Review, security key node)
/// - Stats Bento Section:
///   * Total Shared Records (12, cyan card)
///   * Privacy Score (98%, deep violet card)
/// - Unified Frosted Bottom Navigation Bar
class AccessHistoryPage extends StatefulWidget {
  const AccessHistoryPage({super.key});

  @override
  State<AccessHistoryPage> createState() => _AccessHistoryPageState();
}

class _AccessHistoryPageState extends State<AccessHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  // Sample access log records from Figma node 20:23450
  final List<AccessLogItem> _logs = const [
    AccessLogItem(
      id: 'log-1',
      name: 'Dr. Marcus Thorne',
      department: 'Cardiology Dept',
      status: AccessStatus.active,
      timestamp: 'Today, 10:45 AM',
      tag: 'CLINICAL REVIEW',
      iconAsset: 'assets/icons/access_stethoscope.svg',
      nodeBgColor: Color(0xFF75F2FE),
      isDoctor: true,
    ),
    AccessLogItem(
      id: 'log-2',
      name: 'City General Hospital',
      department: 'Admissions',
      status: AccessStatus.expired,
      timestamp: 'Yesterday, 02:30 PM',
      tag: 'INSURANCE VERIFICATION',
      iconAsset: 'assets/icons/access_hospital.svg',
      nodeBgColor: Color(0xFFDCE9FF),
      isDoctor: false,
    ),
    AccessLogItem(
      id: 'log-3',
      name: 'Dr. Sarah Chen',
      department: 'General Clinic',
      status: AccessStatus.revoked,
      timestamp: '3 days ago',
      tag: 'CLINICAL REVIEW',
      iconAsset: 'assets/icons/access_revoked.svg',
      nodeBgColor: Color(0xFF3F1D8B),
      isDoctor: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AccessLogItem> get _filteredLogs {
    return _logs.where((log) {
      // Filter category
      if (_selectedFilter == 'Doctors' && !log.isDoctor) return false;
      if (_selectedFilter == 'Facilities' && log.isDoctor) return false;

      // Search query
      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final matchesName = log.name.toLowerCase().contains(query);
        final matchesDept = log.department.toLowerCase().contains(query);
        final matchesTag = log.tag.toLowerCase().contains(query);
        return matchesName || matchesDept || matchesTag;
      }
      return true;
    }).toList();
  }

  void _onFilterOptionsTapped() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Advanced timeline filters: All dates, Active & Historical',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF28006D),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onLogTapped(AccessLogItem item) {
    Navigator.of(context).pushNamed(AppRoutes.manageSharedAccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // 1. Scrollable Main Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 72, bottom: 120),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 448),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // Section 1: Search and Filters
                        _buildSearchAndFilters(),

                        const SizedBox(height: 24),

                        // Section 2: Access History Timeline
                        _buildTimelineSection(),

                        const SizedBox(height: 16),

                        // Section 3: Stats Bento Section
                        _buildStatsBentoSection(),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Fixed Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopAppBar(),
          ),

          // 3. Persistent Unified Bottom Navigation Bar
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CareIDBottomNavBar(currentIndex: 1),
          ),
        ],
      ),
    );
  }

  /// Fixed Glassmorphic Top App Bar (Figma node 20:23558)
  Widget _buildTopAppBar() {
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
            color: const Color(0xFFF8F9FF).withValues(alpha: 0.90),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.8),
                width: 1.0,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Group: Back Arrow Button + Title
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
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
                    'Access History',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0B1C30),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),

              // Right Group: Patient Avatar with circular border
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF28006D).withValues(alpha: 0.10),
                    width: 2.0,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/patient_avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section 1: Search Input & Category Filter Pills (Figma node 20:23453)
  Widget _buildSearchAndFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Search Box
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFCBC4D4),
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 18),
              SvgPicture.asset(
                'assets/icons/access_search.svg',
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF6B7280),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF0B1C30),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search access logs...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
              if (_searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(Icons.close, size: 18, color: Color(0xFF6B7280)),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 2. Horizontal Filter Pills Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildFilterChip('All'),
              const SizedBox(width: 8),
              _buildFilterChip('Doctors'),
              const SizedBox(width: 8),
              _buildFilterChip('Facilities'),
              const SizedBox(width: 8),
              _buildFilterIconButton(),
            ],
          ),
        ),
      ],
    );
  }

  /// Filter Chip Widget
  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = label);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFA44CFF),
                    Color(0xFF5B14B8),
                  ],
                )
              : null,
          color: isSelected ? null : const Color(0xFFE5EEFF),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : const Color(0xFF494552),
          ),
        ),
      ),
    );
  }

  /// Filter Options Icon Button (Figma node 20:23467)
  Widget _buildFilterIconButton() {
    return GestureDetector(
      onTap: _onFilterOptionsTapped,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFE5EEFF),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/access_filter.svg',
            width: 14,
            height: 14,
          ),
        ),
      ),
    );
  }

  /// Section 2: Access History Timeline (Figma node 20:23470)
  Widget _buildTimelineSection() {
    final logs = _filteredLogs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header: Icon + "Recent Activity"
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/access_clock.svg',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'Recent Activity',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0B1C30),
                height: 28 / 20,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        if (logs.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 36),
            alignment: Alignment.center,
            child: Text(
              'No access records match your filter.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              final isLast = index == logs.length - 1;
              return _buildTimelineItem(log, isLast);
            },
          ),
      ],
    );
  }

  /// Single Timeline Item with connected vertical track and frosted card
  Widget _buildTimelineItem(AccessLogItem log, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column: Node Avatar + Vertical Connector Line
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Circular Node Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: log.nodeBgColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      log.iconAsset,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),

                // Vertical Connector Line to next node
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFCBC4D4),
                            Color(0x00CBC4D4),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 16),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right Column: Frosted Glass Log Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: GestureDetector(
                onTap: () => _onLogTapped(log),
                behavior: HitTestBehavior.opaque,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: const EdgeInsets.all(21),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.80),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFCBC4D4),
                          width: 1.0,
                        ),
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
                          // Card Header: Name + Department & Status Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      log.name,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0B1C30),
                                        height: 25 / 20,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      log.department,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF494552),
                                        height: 20 / 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildStatusBadge(log.status),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Horizontal Divider Line
                          Container(
                            height: 1,
                            color: const Color(0xFFCBC4D4).withValues(alpha: 0.30),
                          ),

                          const SizedBox(height: 16),

                          // Card Footer: Timestamp + Tag Badge
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              // Timestamp with Clock Icon
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/access_timestamp_clock.svg',
                                    width: 13,
                                    height: 13,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    log.timestamp,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF7A7583),
                                      height: 24 / 14,
                                    ),
                                  ),
                                ],
                              ),

                              // Tag Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCE9FF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  log.tag,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF494552),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Status Badge pill based on AccessStatus
  Widget _buildStatusBadge(AccessStatus status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case AccessStatus.active:
        bgColor = const Color(0xFF75F2FE);
        textColor = const Color(0xFF006D76);
        label = 'ACTIVE';
        break;
      case AccessStatus.expired:
        bgColor = const Color(0xFFCBC4D4);
        textColor = const Color(0xFF494552);
        label = 'EXPIRED';
        break;
      case AccessStatus.revoked:
        bgColor = const Color(0xFF3F1D8B);
        textColor = const Color(0xFFAB8EFD);
        label = 'REVOKED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.6,
          height: 16 / 12,
        ),
      ),
    );
  }

  /// Section 3: Stats Bento Section (Figma node 20:23541)
  Widget _buildStatsBentoSection() {
    return Column(
      children: [
        // Bento Card 1: Total Shared Records (Cyan #75F2FE)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF75F2FE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Shared Records',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF006D76).withValues(alpha: 0.80),
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '12',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF006D76),
                      letterSpacing: -0.32,
                      height: 40 / 32,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/access_total_shared.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Bento Card 2: Privacy Score (Deep Violet #3F1D8B)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF3F1D8B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Score',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFAB8EFD).withValues(alpha: 0.80),
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '98%',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFAB8EFD),
                      letterSpacing: -0.32,
                      height: 40 / 32,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/access_privacy_score.svg',
                width: 16,
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
