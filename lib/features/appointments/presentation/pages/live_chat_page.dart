import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Care ID - Live_chat_messeges (Figma Node 20:31689).
class LiveChatPage extends StatefulWidget {
  const LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filters = [
    'All',
    'Unread (2)',
    'Doctors',
    'Care Teams',
    'Archived',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                // Top App Bar
                _buildTopAppBar(),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Navigation & Context Bar
                        _buildNavigationContextBar(),
                        const SizedBox(height: 8),

                        // Security Assurance Banner
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildSecurityBanner(),
                        ),
                        const SizedBox(height: 12),

                        // Interactive Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildSearchBar(),
                        ),
                        const SizedBox(height: 12),

                        // Filter Chips / Category Selector
                        _buildFilterChips(),
                        const SizedBox(height: 16),

                        // Messages Thread List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildThreadsList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating "New Message" Action Bar
            Positioned(
              bottom: 96,
              left: 0,
              right: 0,
              child: Center(
                child: _buildFloatingNewMessageButton(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(currentIndex: 2),
    );
  }

  /// Top App Bar
  Widget _buildTopAppBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF8F9FF).withValues(alpha: 0.95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User Avatar with Online Badge
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF3F1D8B), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Image.asset(
                    'assets/images/user_avatar_sarah.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF28006D),
                      child: const Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
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

          // Notification Bell with Red Badge
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE5EEFF),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/icons/f00c5380ebf6e9513983caeb296f75cfdda612bc.svg',
                  width: 16,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF28006D),
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
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
          ),
        ],
      ),
    );
  }

  /// Top Navigation & Context Bar
  Widget _buildNavigationContextBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/18bb6fe4cb19ef834c67e9b6b85b58a64482773b.svg',
                    width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF28006D),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Messages',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.6,
                          color: const Color(0xFF28006D),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/card_id_badge.png',
                        height: 20,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8DDFF),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          '2 New',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF21005D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Securely communicate with your…',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF4FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/7e5b495bbc887439561a3a9dc4b104bf8d8f1d36.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF28006D),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF4FF),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/e33e512a084d1ac8035b98e6dac77004e829751d.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF28006D),
                        BlendMode.srcIn,
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
                        color: Color(0xFF00696B),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Security Assurance Banner
  Widget _buildSecurityBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF00696B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/53b857d5e26f45fc9a1eee46ab28225a55dc7c07.svg',
                  width: 14,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF00696B),
                    BlendMode.srcIn,
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
                          'Care ID Secure Messaging',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.35,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'assets/icons/d780311a4a0659db29eb4487e1885b31abe466d0.svg',
                          width: 14,
                          height: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Your conversations are end-to-end encrypted and shared only with verified, authorized healthcare participants.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.25,
              child: SvgPicture.asset(
                'assets/icons/0d5cecdf91aa311966b7c5f69cc2125a0341d6ab.svg',
                width: 38,
                height: 54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Interactive Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 44,
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/2d9227c16b08f35935455c5355df8ff9a002ae4e.svg',
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              Color(0xFF7A7583),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim().toLowerCase();
                });
              },
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF0B1C30),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Search messages, doctors, care teams...',
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF7A7583),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Filter Chips / Category Selector
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = (_selectedFilter == filter);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF28006D) : Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (filter == 'Unread (2)') ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00696B),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ] else if (filter == 'Doctors') ...[
                      SvgPicture.asset(
                        'assets/icons/d87369cc5286ff1e37f99fef2eebc13c7fc5f31f.svg',
                        width: 12,
                        height: 12,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : const Color(0xFF494552),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ] else if (filter == 'Care Teams') ...[
                      SvgPicture.asset(
                        'assets/icons/1013e625cdacbc283b62863d7b79f7a10e7cb3d9.svg',
                        width: 12,
                        height: 11,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : const Color(0xFF494552),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ] else if (filter == 'Archived') ...[
                      SvgPicture.asset(
                        'assets/icons/454bfee4a4f7207e258677dd737047c758f9d571.svg',
                        width: 11,
                        height: 11,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : const Color(0xFF494552),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      filter,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF494552),
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

  /// Messages Thread List
  Widget _buildThreadsList() {
    final showMichael = (_selectedFilter == 'All' || _selectedFilter == 'Unread (2)' || _selectedFilter == 'Doctors') &&
        ('dr. michael chang cardiology metro'.contains(_searchQuery) || _searchQuery.isEmpty);

    final showSinai = (_selectedFilter == 'All' || _selectedFilter == 'Care Teams') &&
        ('care team mount sinai hospital'.contains(_searchQuery) || _searchQuery.isEmpty);

    final showWilson = (_selectedFilter == 'All' || _selectedFilter == 'Doctors') &&
        ('dr. sarah wilson primary family'.contains(_searchQuery) || _searchQuery.isEmpty);

    return Column(
      children: [
        if (showMichael) ...[
          _buildThreadCard1(),
          const SizedBox(height: 12),
        ],
        if (showSinai) ...[
          _buildThreadCard2(),
          const SizedBox(height: 12),
        ],
        if (showWilson) ...[
          _buildThreadCard3(),
          const SizedBox(height: 12),
        ],
        if (!showMichael && !showSinai && !showWilson) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No conversations found in "$_selectedFilter"',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: const Color(0xFF7A7583),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Thread 1: Dr. Michael Chang (Active / Unread / Cath Lab instructions)
  Widget _buildThreadCard1() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A28006D),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Teal Unread Indicator Ribbon
              Container(
                width: 6,
                color: const Color(0xFF00696B),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar with Online Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9999),
                            child: Image.asset(
                              'assets/images/doctor_michael_chang.png',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 48,
                                height: 48,
                                color: const Color(0xFFE5EEFF),
                                child: const Icon(Icons.person, color: Color(0xFF28006D)),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2DDBDE),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),

                      // Meta & Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Dr. Michael Chang',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0B1C30),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SvgPicture.asset(
                                      'assets/icons/f15a0f00883c170e7d861495cb637e41fece28cb.svg',
                                      width: 15,
                                      height: 14,
                                    ),
                                  ],
                                ),
                                Text(
                                  '10:42 AM',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF00696B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Cardiology Specialist • Metro Heart Institute',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xCC494552),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Your procedure preparation instructions are ready. Please review the pre-cath…',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0B1C30),
                                height: 1.38,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0x6656F5F8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Cath Lab Prep',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF004F51),
                                      letterSpacing: -0.25,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF4FF),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/f20af5c61769bcbc2a6aea48e900afc3c16ce24d.svg',
                                        width: 11,
                                        height: 11,
                                        colorFilter: const ColorFilter.mode(
                                          Color(0xFF494552),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Attachment: 1 PDF',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF494552),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF28006D),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '2',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Thread 2: Care Team — Mount Sinai Hospital (Read)
  Widget _buildThreadCard2() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0828006D),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hospital Emblem Avatar
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE5EEFF),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/77723b9bf1656dc972069e2fc9947556e0b39e24.svg',
              width: 20,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Color(0xFF28006D),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Care Team — Mount Sinai Hospital',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0B1C30),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Yesterday',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Clinical Coordination • Ward 4B Recovery',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xCC494552),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your follow-up appointment has been confirmed for Nov 14, 2026 at 2:30 PM.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/078f585165070944ef3f1d0463bc1780a738be6c.svg',
                            width: 10,
                            height: 11,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF494552),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Appointment Ref: #MS-8841',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/5717fc9a3a3893dbdd129d14d7231e9418aaf187.svg',
                      width: 15,
                      height: 8,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF00696B),
                        BlendMode.srcIn,
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

  /// Thread 3: Dr. Sarah Wilson (Delivered)
  Widget _buildThreadCard3() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0828006D),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Physician Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: Image.asset(
              'assets/images/doctor_sarah_wilson.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 48,
                height: 48,
                color: const Color(0xFFE5EEFF),
                child: const Icon(Icons.person, color: Color(0xFF28006D)),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Dr. Sarah Wilson',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0B1C30),
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'assets/icons/f15a0f00883c170e7d861495cb637e41fece28cb.svg',
                          width: 15,
                          height: 14,
                        ),
                      ],
                    ),
                    Text(
                      'Mon',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Primary Care Physician • Family Health Clinic',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xCC494552),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Please let us know if your symptoms change or if you notice any side effects…',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF494552),
                    height: 1.38,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/e6f0c8700468bf82fd950bfe407317ad2576bdc2.svg',
                            width: 8,
                            height: 10,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF494552),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Rx Follow-up',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF494552),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/cd7f4efc29bab9f3350d2f69f06b4b0bc275f1ba.svg',
                      width: 11,
                      height: 8,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF494552),
                        BlendMode.srcIn,
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

  /// Floating "New Message" Action Bar
  Widget _buildFloatingNewMessageButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Starting new secure medical message thread...'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF28006D),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5928006D),
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/03e767f87067745aacd7922ca1f155295655bd7c.svg',
              width: 17,
              height: 17,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'New Message',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF5AF8FB),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

