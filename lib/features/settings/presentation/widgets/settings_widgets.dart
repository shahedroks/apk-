import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';

class SettingsProfileMiniCard extends StatelessWidget {
  const SettingsProfileMiniCard({super.key});

  static const _specLime = Color(0xFFA3E635);
  static const _darkGreen = Color(0xFF0A2E22);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const ProfileAvatar(
                radius: 28,
                imageUrl: ProfileStrings.profileAvatarUrl,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: _specLime,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 8.sp,
                    color: _darkGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        ProfileStrings.marcusChen,
                        style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: _specLime.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        ProfileStrings.proSwapper,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.25,
                          color: _darkGreen,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  ProfileStrings.email,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.65,
              color: AppColors.textSecondary,
              height: 18 / 13,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: const Color(0xFFDEE9FC).withValues(alpha: 0.6),
      ),
    );
  }
}

class SettingsNavRow extends StatelessWidget {
  const SettingsNavRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  static const _darkGreen = Color(0xFF0A2E22);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, size: 18.sp, color: _darkGreen),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle!,
                        style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 10.sp,
                color: const Color(0xFFC0C8C3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  static const _specLime = Color(0xFFA3E635);
  static const _darkGreen = Color(0xFF0A2E22);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 18.sp, color: _darkGreen),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeTrackColor: _specLime,
            inactiveTrackColor: AppColors.toggleTrack,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            thumbColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }
}

class SettingsLogOutBlock extends StatelessWidget {
  const SettingsLogOutBlock({
    super.key,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  final VoidCallback onLogOut;
  final VoidCallback onDeleteAccount;

  static const _logOutRed = Color(0xFFBA1A1A);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: onLogOut,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, size: 15.sp, color: _logOutRed),
                  SizedBox(width: 8.w),
                  Text(
                    ProfileStrings.logOut,
                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: _logOutRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: onDeleteAccount,
          style: TextButton.styleFrom(
            foregroundColor: _logOutRed.withValues(alpha: 0.8),
            padding: EdgeInsets.symmetric(vertical: 8.h),
          ),
          child: Text(
            ProfileStrings.deleteAccount,
            style: AppTextStyles.caption(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: _logOutRed.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
