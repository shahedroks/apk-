import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

class ProfileCircleButton extends StatelessWidget {
  const ProfileCircleButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.infoBackground,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(icon, size: 18.sp, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.sp, color: AppColors.primary),
            SizedBox(height: 6.h),
            Text(
              value,
              style: AppTextStyles.label(fontSize: 16.sp),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    this.badgeColor = AppColors.accentLime,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final Color badgeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 20.sp, color: AppColors.primary),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.label(fontSize: 14.sp)),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (badge != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      badge!,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
                Icon(Icons.chevron_right, color: AppColors.textMuted, size: 22.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
      child: Text(
        title,
        style: AppTextStyles.overline(fontSize: 10.sp),
      ),
    );
  }
}

class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20.sp, color: AppColors.primary),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.label(fontSize: 14.sp)),
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle!,
                          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    Icon(Icons.chevron_right, color: AppColors.textMuted, size: 22.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.radius = 48,
    this.showEdit = false,
  });

  final double radius;
  final bool showEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius.r,
          backgroundColor: AppColors.infoBorder,
          child: Icon(Icons.person, size: (radius * 0.9).sp, color: AppColors.primary),
        ),
        if (showEdit)
          Positioned(
            right: 4.w,
            bottom: 4.h,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: const BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit, size: 14.sp, color: AppColors.primaryDark),
            ),
          ),
      ],
    );
  }
}
