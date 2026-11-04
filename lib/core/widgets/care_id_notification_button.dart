import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routing/app_routes.dart';

/// CareID standard notification bell button matching the Dashboard app bar design.
class CareIDNotificationButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool hasUnread;

  const CareIDNotificationButton({
    super.key,
    this.onTap,
    this.hasUnread = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.of(context).pushNamed(AppRoutes.notificationCenter);
          },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFE5EEFF),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/home_notification_bell.svg',
              width: 16,
              height: 20,
            ),
            if (hasUnread)
              Positioned(
                top: 8,
                right: 8,
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
    );
  }
}

