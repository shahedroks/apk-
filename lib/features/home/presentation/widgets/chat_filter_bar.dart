import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';

class ChatFilterBar extends StatelessWidget {
  const ChatFilterBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.activeSwapsCount = 2,
    this.onTestEmptyTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final int activeSwapsCount;
  final VoidCallback? onTestEmptyTap;

  static const _activeGreen = Color(0xFF0A2E22);
  static const _trackGray = Color(0xFFF8F9F8);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: _trackGray,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FilterChip(
                  label: HomeStrings.allMessages,
                  isActive: selectedIndex == 0,
                  onTap: () => onSelected(0),
                ),
                SizedBox(width: 4.w),
                _FilterChip(
                  label: HomeStrings.activeSwaps,
                  isActive: selectedIndex == 1,
                  badge: '$activeSwapsCount',
                  onTap: () => onSelected(1),
                ),
                SizedBox(width: 4.w),
                _FilterChip(
                  label: HomeStrings.testEmpty,
                  isActive: selectedIndex == 2,
                  leadingIcon: Icons.swap_horiz_rounded,
                  onTap: () => onSelected(2),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onTestEmptyTap,
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  size: 12.sp,
                  color: AppColors.accentGreen,
                ),
                SizedBox(width: 4.w),
                Text(
                  HomeStrings.testEmpty,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: _activeGreen,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badge,
    this.leadingIcon,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final String? badge;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isActive ? ChatFilterBar._activeGreen : AppColors.surface,
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              Icon(
                leadingIcon,
                size: 14.sp,
                color: isActive ? Colors.white : AppColors.accentGreen,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
            ),
            if (badge != null) ...[
              SizedBox(width: 6.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                height: 12.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white.withValues(alpha: 0.2)
                      : const Color(0xFFDEE9FC),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  badge!,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : ChatFilterBar._activeGreen,
                    height: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
