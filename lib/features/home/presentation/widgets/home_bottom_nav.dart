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
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
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
      offset: Offset(0, -10.h),
      child: Material(
        color: AppColors.accentLime,
        elevation: 4,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 52.w,
            height: 52.w,
            child: Icon(
              Icons.add,
              size: 28.sp,
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }
}
