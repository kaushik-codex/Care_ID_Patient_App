import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/care_id_bottom_nav_bar.dart';

/// Page 39: Family Member List (Figma node 20:21825)
/// Exact implementation matching Figma node 20:21825
class FamilyMemberListPage extends StatefulWidget {
  const FamilyMemberListPage({super.key});

  @override
  State<FamilyMemberListPage> createState() => _FamilyMemberListPageState();
}

class _FamilyMemberListPageState extends State<FamilyMemberListPage> {
  int _selectedFilter = 0; // 0: All, 1: Parents, 2: Children, 3: Spouse, 4: Siblings
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _filters = ['All', 'Parents', 'Children', 'Spouse', 'Siblings'];

  final List<Map<String, dynamic>> _members = [
    {
      'name': 'Arthur Thompson',
      'relation': 'Father • 68 Years',
      'category': 'Parents',
      'verified': true,
      'healthCardStatus': 'Active',
      'healthCardColor': Color(0xFF006971),
      'insurance': 'Global Care Plus',
      'consentStatus': 'Full Access',
      'consentColor': Color(0xFF006971),
      'avatar': 'assets/images/doctor_male_avatar.png',
      'isPending': false,
    },
    {
      'name': 'Oliver Thompson',
      'relation': 'Son • 8 Years',
      'category': 'Children',
      'verified': true,
      'healthCardStatus': 'Active',
      'healthCardColor': Color(0xFF006971),
      'insurance': 'Dependant Coverage',
      'consentStatus': 'Parental Proxy',
      'consentColor': Color(0xFF006971),
      'avatar': 'assets/images/patient_avatar.png',
      'isPending': false,
    },
    {
      'name': 'Sarah Jenkins',
      'relation': 'Spouse • 39 Years',
      'category': 'Spouse',
      'verified': false,
      'healthCardStatus': 'Inactive',
      'healthCardColor': Color(0xFF7A7583),
      'insurance': 'Awaiting Update',
      'consentStatus': 'Invite Sent',
      'consentColor': Color(0xFFBA1A1A),
      'avatar': 'assets/images/user_avatar_sarah.png',
      'isPending': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMembers {
    return _members.where((m) {
      if (_selectedFilter != 0 && m['category'] != _filters[_selectedFilter]) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final name = (m['name'] as String).toLowerCase();
        final rel = (m['relation'] as String).toLowerCase();
        return name.contains(q) || rel.contains(q);
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredMembers;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: _buildTopAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),

            const SizedBox(height: 16),

            // Horizontal Filter Chips
            _buildHorizontalFilterChips(),

            const SizedBox(height: 24),

            // Member Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildMemberCard(context, list[index]);
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const CareIDBottomNavBar(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF006971),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addFamilyMemberForm);
        },
        child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 24),
      ),
    );
  }

  PreferredSizeWidget _buildTopAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FF).withValues(alpha: 0.8),
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(9999),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Color(0xFF28006D),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Family Management',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF28006D),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/care_id_logo_wordmark.png',
                  height: 20,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
                const SizedBox(width: 12),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded,
                          size: 24, color: Color(0xFF28006D)),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBA1A1A),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.smartHealthCard),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF3F1D8B), width: 2),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/patient_avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val.trim()),
        style: GoogleFonts.plusJakartaSans(fontSize: 15, color: const Color(0xFF0B1C30)),
        decoration: InputDecoration(
          hintText: 'Search family members...',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: const Color(0xFF6B7280),
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildHorizontalFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = _selectedFilter == index;
          if (isSelected) {
            return Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                ),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Center(
                child: Text(
                  _filters[index],
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              borderRadius: BorderRadius.circular(9999),
              onTap: () => setState(() => _selectedFilter = index),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Center(
                  child: Text(
                    _filters[index],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF494552),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, Map<String, dynamic> member) {
    final bool isPending = member['isPending'] == true;
    final String name = member['name'] as String;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCBC4D4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28006D).withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name & Verified Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  member['avatar'] as String,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 64,
                    height: 64,
                    color: const Color(0xFFDCE9FF),
                    child: const Icon(Icons.person, color: Color(0xFF28006D), size: 32),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0B1C30),
                            ),
                          ),
                        ),
                        if (member['verified'] == true)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF75F2FE).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.verified, size: 12, color: Color(0xFF006971)),
                                const SizedBox(width: 4),
                                Text(
                                  'Verified',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF006971),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFCBC4D4).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              'Pending',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF7A7583),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member['relation'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF494552),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Status Bento Items
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Card Status',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF494552),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: member['healthCardColor'] as Color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      member['healthCardStatus'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: member['healthCardColor'] as Color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Insurance',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF494552),
                  ),
                ),
                Text(
                  member['insurance'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0B1C30),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Consent Status',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF494552),
                  ),
                ),
                Text(
                  member['consentStatus'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: member['consentColor'] as Color,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Actions Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFA44CFF), Color(0xFF5B14B8)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (isPending) {
                        Navigator.of(context).pushNamed(
                          AppRoutes.invitationSent,
                          arguments: member,
                        );
                      } else {
                        Navigator.of(context).pushNamed(
                          AppRoutes.sharedHealthCardDependent,
                          arguments: {
                            'name': member['name'],
                            'relation': member['relation'],
                            'avatar': member['avatar'],
                            'insurance': member['insurance'],
                          },
                        );
                      }
                    },
                    child: Text(
                      isPending ? 'Resend Invite' : 'View Details',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBC4D4)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.share_outlined, size: 18, color: Color(0xFF0B1C30)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.memberPermissionsSharing);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFDAD6)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFBA1A1A)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Revoke/Remove $name options opened',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
