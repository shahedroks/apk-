import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';

class ProfileDesign {
  ProfileDesign._();

  static const darkGreen = Color(0xFF0A2E22);
  static const specLime = Color(0xFFA3E635);
  static const guardianMuted = Color(0xFF79A694);
  static const logOutRed = Color(0xFFBA1A1A);
}

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

class ProfileSubNavRow extends StatelessWidget {
  const ProfileSubNavRow({
    super.key,
    required this.onBack,
    required this.onSettings,
  });

  final VoidCallback onBack;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileCircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        Expanded(
          child: Text(
            ProfileStrings.myProfile,
            textAlign: TextAlign.center,
            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        ProfileCircleButton(
          icon: Icons.settings_outlined,
          onTap: onSettings,
        ),
      ],
    );
  }
}

class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.onEditProfile,
    this.onVerifiedTap,
  });

  final VoidCallback onEditProfile;
  final VoidCallback? onVerifiedTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            const ColoredBox(color: AppColors.surface),
            Positioned(
              right: -48.w,
              top: -48.h,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 144.w,
                    height: 144.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProfileDesign.specLime.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -40.w,
              bottom: -40.h,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    width: 128.w,
                    height: 128.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.12),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
              child: Column(
                children: [
                  const ProfileAvatar(
                    radius: 48,
                    showEdit: true,
                    imageUrl: ProfileStrings.profileAvatarUrl,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    ProfileStrings.marcusChen,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.55,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13.sp,
                        color: ProfileDesign.darkGreen,
                      ),
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          ProfileStrings.location,
                          style: AppTextStyles.subtitle(fontSize: 14.sp)
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    ProfileStrings.memberSince,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        color: AppColors.infoBackground,
                        borderRadius: BorderRadius.circular(999.r),
                        child: InkWell(
                          onTap: onVerifiedTap,
                          borderRadius: BorderRadius.circular(999.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _VerifiedCheckBadge(size: 18.w),
                                SizedBox(width: 6.w),
                                Text(
                                  ProfileStrings.communityVerified,
                                  style: AppTextStyles.label(fontSize: 13.sp)
                                      .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ProfileDesign.darkGreen,
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  size: 12.sp,
                                  color: AppColors.accentGreen,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  ProfileStrings.ratingScore,
                                  style: AppTextStyles.caption(fontSize: 11.sp)
                                      .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  ' ${ProfileStrings.swapCountLabel}',
                                  style: AppTextStyles.caption(fontSize: 11.sp)
                                      .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Material(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(999.r),
                    child: InkWell(
                      onTap: onEditProfile,
                      borderRadius: BorderRadius.circular(999.r),
                      child: SizedBox(
                        width: 200.w,
                        height: 44.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.tune_rounded,
                              size: 14.sp,
                              color: ProfileDesign.darkGreen,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              ProfileStrings.editProfile,
                              style: AppTextStyles.label(fontSize: 13.sp)
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                                color: ProfileDesign.darkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerifiedCheckBadge extends StatelessWidget {
  const _VerifiedCheckBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.accentGreen,
        shape: BoxShape.circle,
      ),
      child: RoundedCheckMark(
        size: size * 0.48,
        color: Colors.white,
        strokeWidth: size * 0.11,
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
    this.showEcoAccent = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool showEcoAccent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, size: 17.sp, color: AppColors.accentGreen),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (showEcoAccent)
            Positioned(
              right: -10.w,
              top: -10.h,
              child: Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ProfileDesign.specLime.withValues(alpha: 0.3),
                ),
                child: Icon(
                  Icons.eco_outlined,
                  size: 16.sp,
                  color: ProfileDesign.darkGreen,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfilePlanetGuardianBanner extends StatelessWidget {
  const ProfilePlanetGuardianBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ProfileDesign.darkGreen,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
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
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: ProfileDesign.specLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.eco_outlined,
                  color: ProfileDesign.darkGreen,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ProfileStrings.planetGuardian,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: ProfileDesign.specLime,
                      ),
                    ),
                    Text(
                      ProfileStrings.planetGuardianBody,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w400,
                        color: ProfileDesign.guardianMuted,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 10.sp,
                color: ProfileDesign.guardianMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuGroup extends StatelessWidget {
  const ProfileMenuGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: children,
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
    this.badgeColor = ProfileDesign.specLime,
    this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final Color badgeColor;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
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
                    child: Icon(
                      icon,
                      size: 18.sp,
                      color: ProfileDesign.darkGreen,
                    ),
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
                          style: AppTextStyles.caption(fontSize: 10.sp)
                              .copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (badge != null) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        badge!,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: ProfileDesign.darkGreen,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                    size: 10.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.borderLight.withValues(alpha: 0.65),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}

class ProfileLogOutSection extends StatelessWidget {
  const ProfileLogOutSection({
    super.key,
    required this.onLogOut,
    required this.onDeleteAccount,
  });

  final VoidCallback onLogOut;
  final VoidCallback onDeleteAccount;

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
                  Icon(
                    Icons.logout_rounded,
                    size: 15.sp,
                    color: ProfileDesign.logOutRed,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    ProfileStrings.logOut,
                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: ProfileDesign.logOutRed,
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
          child: Text(
            ProfileStrings.deleteAccount,
            style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
              color: ProfileDesign.logOutRed,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
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
      child: Text(title, style: AppTextStyles.overline(fontSize: 10.sp)),
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
                          style: AppTextStyles.caption(
                            fontSize: 11.sp,
                          ).copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.textMuted,
                      size: 22.sp,
                    ),
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
    this.imageUrl,
  });

  final double radius;
  final bool showEdit;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: radius * 2.w,
          height: radius * 2.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.toggleTrack,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
                spreadRadius: -1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
          child: ClipOval(
            child: ColoredBox(
              color: const Color(0xFFE6EEFF),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      placeholder: (context, url) => _avatarFallback(),
                      errorWidget: (context, url, error) => _avatarFallback(),
                    )
                  : _avatarFallback(),
            ),
          ),
        ),
        if (showEdit)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: ProfileDesign.darkGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 12.sp,
                color: ProfileDesign.specLime,
              ),
            ),
          ),
      ],
    );
  }

  Widget _avatarFallback() {
    return ColoredBox(
      color: AppColors.toggleTrack,
      child: Icon(
        Icons.person,
        size: (radius * 0.9).sp,
        color: AppColors.primary.withValues(alpha: 0.35),
      ),
    );
  }
}
