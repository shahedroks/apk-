import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../providers/home_ui_provider.dart';
class HomeBottomNav extends ConsumerWidget {
  const HomeBottomNav({super.key});

  void _goToTab(BuildContext context, WidgetRef ref, int tab) {
    ref.read(homeTabIndexProvider.notifier).state = tab;
    final path = GoRouterState.of(context).uri.path;
    if (path != AppRouter.home) {
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeTabIndexProvider);
    final onProfileRoute = GoRouterState.of(context).uri.path == AppRouter.profile;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: HomeStrings.navDiscover,
                selected: !onProfileRoute && index == 0,
                onTap: () => _goToTab(context, ref, 0),
              ),
              _NavItem(
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: HomeStrings.navSaved,
                selected: !onProfileRoute && index == 1,
                onTap: () => _goToTab(context, ref, 1),
              ),
              _FabNavItem(
                onTap: () => context.push(AppRouter.addItem),
              ),
              _NavItem(
                icon: Icons.swap_horiz_outlined,
                activeIcon: Icons.swap_horiz,
                label: HomeStrings.navSwaps,
                selected: !onProfileRoute && index == 3,
                onTap: () => _goToTab(context, ref, 3),
              ),
              _NavItem(
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: HomeStrings.navChats,
                selected: !onProfileRoute && index == 4,
                onTap: () => _goToTab(context, ref, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? activeIcon : icon, size: 22.sp, color: color),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FabNavItem extends StatelessWidget {
  const _FabNavItem({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentLime,
              border: Border.all(color: AppColors.surface, width: 4.w),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: const Color(0xFF84CC16).withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: _BoldPlusIcon(size: 20.w, strokeWidth: 3.2.w),
          ),
        ),
      ),
    );
  }
}

/// Thick-stroke plus matching the docked FAB in `doc/home.md`.
class _BoldPlusIcon extends StatelessWidget {
  const _BoldPlusIcon({required this.size, required this.strokeWidth});

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _BoldPlusPainter(
        color: AppColors.primaryDark,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _BoldPlusPainter extends CustomPainter {
  _BoldPlusPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final arm = size.shortestSide * 0.34;

    canvas.drawLine(
      Offset(center.dx - arm, center.dy),
      Offset(center.dx + arm, center.dy),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - arm),
      Offset(center.dx, center.dy + arm),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _BoldPlusPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
