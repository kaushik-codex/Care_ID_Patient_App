import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routing/app_routes.dart';

/// Unified CareID Frosted Bottom Navigation Bar with interactive center QR FAB
/// and animated Scan OCR / Share QR option bubbles.
class CareIDBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const CareIDBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTabSelected,
  });

  @override
  State<CareIDBottomNavBar> createState() => _CareIDBottomNavBarState();
}

class _CareIDBottomNavBarState extends State<CareIDBottomNavBar>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _animController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    });
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      setState(() {
        _isMenuOpen = false;
        _animController.reverse();
      });
    }
  }

  void _onScanOcrTapped() {
    _closeMenu();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening CareID OCR Medical Scanner...',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF006D76),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onShareQrTapped() {
    _closeMenu();
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != AppRoutes.qrDashboard) {
      Navigator.of(context).pushNamed(AppRoutes.qrDashboard);
    }
  }

  void _handleTabTap(int index) {
    _closeMenu();
    widget.onTabSelected?.call(index);

    // Default route handling
    if (index == 0) {
      if (widget.currentIndex == 0) return;
      final currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute != AppRoutes.home) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.home || route.isFirst);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      }
    } else if (index == 1) {
      if (widget.currentIndex == 1) {
        final currentRoute = ModalRoute.of(context)?.settings.name;
        if (currentRoute == AppRoutes.recordDetailsHub) return;
        Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.recordDetailsHub || route.isFirst);
        return;
      }
      final currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute != AppRoutes.recordDetailsHub) {
        Navigator.of(context).pushNamed(AppRoutes.recordDetailsHub);
      }
    } else if (index == 2) {
      if (widget.currentIndex == 2) {
        final currentRoute = ModalRoute.of(context)?.settings.name;
        if (currentRoute == AppRoutes.doctors) return;
        Navigator.of(context).popUntil((route) => route.settings.name == AppRoutes.doctors || route.isFirst);
        return;
      }
      final currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute != AppRoutes.doctors) {
        Navigator.of(context).pushNamed(AppRoutes.doctors);
      }
    } else if (index == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile & Settings opening...',
            style: GoogleFonts.plusJakartaSans(fontSize: 13),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _isMenuOpen ? 170 : 84,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // 1. Frosted Glass Navigation Bar Container & Base Layer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 84,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      height: 68,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.80),
                            width: 1.0,
                          ),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A3F1D8B),
                            blurRadius: 24,
                            offset: Offset(0, -8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Tab 0: Home
                          Expanded(
                            child: _buildNavItem(
                              label: 'Home',
                              iconPath: 'assets/icons/nav_home_clean.svg',
                              isActive: widget.currentIndex == 0,
                              onTap: () => _handleTabTap(0),
                            ),
                          ),

                          // Tab 1: Records
                          Expanded(
                            child: _buildNavItem(
                              label: 'Records',
                              iconPath: 'assets/icons/nav_records_clean.svg',
                              isActive: widget.currentIndex == 1,
                              onTap: () => _handleTabTap(1),
                            ),
                          ),

                          // Central gap for Elevated FAB
                          const SizedBox(width: 60),

                          // Tab 2: Doctor / Family
                          Expanded(
                            child: _buildNavItem(
                              label: 'Doctor',
                              iconPath: 'assets/icons/nav_doctor_clean.svg',
                              isActive: widget.currentIndex == 2,
                              onTap: () => _handleTabTap(2),
                            ),
                          ),

                          // Tab 3: Profile
                          Expanded(
                            child: _buildNavItem(
                              label: 'Profile',
                              iconPath: 'assets/icons/nav_profile_clean.svg',
                              isActive: widget.currentIndex == 3,
                              onTap: () => _handleTabTap(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Central Elevated Floating Action Button
                Positioned(
                  top: -2,
                  child: GestureDetector(
                    onTap: _toggleMenu,
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _isMenuOpen ? const Color(0xFF3F1D8B) : const Color(0xFF5B14B8),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5B14B8).withValues(alpha: _isMenuOpen ? 0.60 : 0.40),
                            blurRadius: _isMenuOpen ? 20 : 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedRotation(
                          turns: _isMenuOpen ? 0.125 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: SvgPicture.asset(
                            'assets/icons/nav_qr_scan.svg',
                            width: 20,
                            height: 22,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Dismiss Backdrop (only active and interactive when open)
          if (_isMenuOpen)
            Positioned.fill(
              bottom: 84,
              child: GestureDetector(
                onTap: _closeMenu,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

          // 3. Option Bubbles Layer (PAINTED ON TOP OF NAVIGATION BAR)
          Positioned(
            bottom: 96,
            child: ScaleTransition(
              scale: _expandAnimation,
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _expandAnimation,
                child: IgnorePointer(
                  ignoring: !_isMenuOpen,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Option Bubble 1: Scan OCR
                      _buildOptionBubble(
                        title: 'Scan OCR',
                        icon: Icons.document_scanner_rounded,
                        iconColor: const Color(0xFF006D76),
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF0B1C30),
                        onTap: _onScanOcrTapped,
                      ),

                      const SizedBox(width: 14),

                      // Option Bubble 2: Share QR
                      _buildOptionBubble(
                        title: 'Share QR',
                        icon: Icons.qr_code_2_rounded,
                        iconColor: Colors.white,
                        backgroundColor: const Color(0xFF5B14B8),
                        textColor: Colors.white,
                        onTap: _onShareQrTapped,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Option Bubble above FAB
  Widget _buildOptionBubble({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: const Color(0xFFCBC4D4).withValues(alpha: 0.6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x263F1D8B),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Single Tab Navigation Destination
  Widget _buildNavItem({
    required String label,
    required String iconPath,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 29,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xCC75F2FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(14.5),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isActive ? const Color(0xFF002022) : const Color(0xFF494552),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? const Color(0xFF0B1C30) : const Color(0xFF494552),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
