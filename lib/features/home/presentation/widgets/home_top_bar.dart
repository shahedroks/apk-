import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'swap_brand_mark.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    required this.title,
    this.showTitle = true,
    this.darkBrandMark = false,
    this.darkProfileAvatar = false,
    this.titledTabHeader = false,
    this.showBack = false,
    this.onBack,
    this.showSettings = false,
    this.onSettings,
    this.onProfileTap,
    this.onNotificationTap,
  });

  final String title;
  final bool showTitle;
  final bool darkBrandMark;
  final bool darkProfileAvatar;
  /// Back chevron + left title (Saved / Swaps / Chats tabs).
  final bool titledTabHeader;
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
        else if (titledTabHeader) ...[
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.screenTitle(fontSize: 20.sp),
            ),
          ),
        ] else ...[
          SwapBrandMark(dark: darkBrandMark),
          if (showTitle) ...[
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.screenTitle(fontSize: 20.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ] else
            const Spacer(),
        ],
        _CircleIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationTap,
        ),
        if (showSettings) SizedBox(width: 8.w),
        if (showSettings)
          _CircleIconButton(
            icon: Icons.settings_outlined,
            onTap: onSettings,
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
              backgroundColor: darkProfileAvatar
                  ? const Color(0xFF0A2E22)
                  : const Color(0xFF90A4AE),
              child: Icon(Icons.person, size: 20.sp, color: Colors.white),
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
