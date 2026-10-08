import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.showSettings = false,
    this.onSettings,
    this.onProfileTap,
    this.onNotificationTap,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final bool showSettings;
  final VoidCallback? onSettings;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          _CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack ?? () => Navigator.maybePop(context),
          )
        else
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.swap_horiz_rounded,
              size: 22.sp,
              color: AppColors.primaryDark,
            ),
          ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.screenTitle(fontSize: 20.sp),
          ),
        ),
        if (showSettings)
          _CircleIconButton(
            icon: Icons.settings_outlined,
            onTap: onSettings,
          ),
        if (showSettings) SizedBox(width: 8.w),
        _CircleIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationTap,
        ),
        SizedBox(width: 8.w),
        Material(
          color: AppColors.infoBackground,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onProfileTap,
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person, size: 20.sp, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 36.w,
          height: 36.w,
          child: Icon(icon, size: 18.sp, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
