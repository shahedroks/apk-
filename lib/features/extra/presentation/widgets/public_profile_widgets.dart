import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../data/extra_mock_data.dart';

class PublicProfileTopBar extends StatelessWidget {
  const PublicProfileTopBar({
    super.key,
    required this.onBack,
    required this.onMenu,
    required this.onProfile,
  });

  final VoidCallback onBack;
  final VoidCallback onMenu;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: Row(
        children: [
          _CircleAction(
            onTap: onBack,
            child: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp, color: AppColors.textPrimary),
          ),
          Expanded(
            child: Text(
              ExtraStrings.publicProfileTitle,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.45,
              ),
            ),
          ),
          _CircleAction(
            onTap: onMenu,
            child: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textPrimary),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onProfile,
            child: ProfileAvatar(radius: 18, imageUrl: ProfileStrings.profileAvatarUrl),
          ),
        ],
      ),
    );
  }
}

class PublicProfileHandleBar extends StatelessWidget {
  const PublicProfileHandleBar({
    super.key,
    required this.onShare,
    required this.onMore,
  });

  final VoidCallback onShare;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ExtraStrings.publicHandle,
          style: AppTextStyles.label(fontSize: 18.sp).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 4.w),
        Container(
          width: 20.w,
          height: 20.w,
          decoration: const BoxDecoration(
            color: AppColors.accentLime,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 12.sp, color: const Color(0xFF457000)),
        ),
        const Spacer(),
        _CircleAction(
          onTap: onShare,
          shadow: true,
          child: Icon(Icons.ios_share, size: 16.sp, color: AppColors.textPrimary),
        ),
        SizedBox(width: 4.w),
        _CircleAction(
          onTap: onMore,
          shadow: true,
          child: Icon(Icons.more_vert, size: 18.sp, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class PublicProfileHeroCard extends StatelessWidget {
  const PublicProfileHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AvatarWithStatus(),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ExtraStrings.marcusChen,
                            style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                              height: 1.27,
                            ),
                          ),
                        ),
                        _ActiveNowPill(),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined, size: 11.sp, color: AppColors.textMuted),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            ExtraStrings.publicLocation,
                            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(height: 1.43),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 10.sp, color: AppColors.textMuted),
                        SizedBox(width: 4.w),
                        Text(
                          ExtraStrings.swappingSince,
                          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _ReputationStatsGrid(),
        ],
      ),
    );
  }
}

class _AvatarWithStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: ProfileStrings.profileAvatarUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -4.w,
          bottom: -4.h,
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActiveNowPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: const BoxDecoration(
              color: AppColors.accentGreen,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            ExtraStrings.activeNow,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF457000),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReputationStatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground.withValues(alpha: 0.6),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
      ),
      margin: EdgeInsets.symmetric(horizontal: -24.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.verified_user_outlined,
                  iconBg: AppColors.accentLime,
                  iconColor: const Color(0xFF457000),
                  value: ExtraStrings.reliable,
                  label: ExtraStrings.trustIndex,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _StatTile(
                  icon: Icons.star,
                  iconBg: AppColors.borderLight,
                  iconColor: AppColors.primaryDark,
                  value: ExtraStrings.ratingPublic,
                  label: ExtraStrings.reviewsCount,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.swap_horiz,
                  iconBg: const Color(0xFFBEEDD9),
                  iconColor: AppColors.primaryDark,
                  value: ExtraStrings.swapsCount,
                  label: ExtraStrings.swapsCompleted,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _StatTile(
                  icon: Icons.bolt_outlined,
                  iconBg: const Color(0xFFDEE9FC),
                  iconColor: AppColors.primaryDark,
                  value: ExtraStrings.replyTime,
                  label: ExtraStrings.avgReplyTime,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
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
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, size: 16.sp, color: iconColor),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
                Text(
                  label,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
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

class PublicProfileImpactCard extends StatelessWidget {
  const PublicProfileImpactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -24.w,
            bottom: -32.h,
            child: Icon(
              Icons.eco_outlined,
              size: 128.sp,
              color: AppColors.accentLime.withValues(alpha: 0.15),
            ),
          ),
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(Icons.eco, size: 18.sp, color: AppColors.primaryDark),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          ExtraStrings.co2SavedValue,
                          style: AppTextStyles.screenTitle(fontSize: 28.sp).copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentLime,
                            height: 1.29,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          ExtraStrings.co2SavedLabel,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA3D0BE),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      ExtraStrings.planetTierShort,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.275,
                        color: const Color(0xFFA3D0BE),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ExtraStrings.circularityBadge,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentLime,
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 10.sp, color: AppColors.accentLime),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PublicProfileDesiredTradesCard extends StatelessWidget {
  const PublicProfileDesiredTradesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, size: 15.sp, color: AppColors.accentGreen),
              SizedBox(width: 6.w),
              Text(
                ExtraStrings.desiredTrades,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
              const Spacer(),
              Text(
                ExtraStrings.desiredTradesCount,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            ExtraStrings.desiredTradesHint,
            style: AppTextStyles.subtitle(fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ExtraMockData.desiredTradeChips.map((chip) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(chip.$2, size: 12.sp, color: AppColors.accentGreen),
                    SizedBox(width: 4.w),
                    Text(
                      chip.$1,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class PublicProfileSegmentTabs extends StatelessWidget {
  const PublicProfileSegmentTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(labels.length, (i) {
        final active = i == selectedIndex;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < labels.length - 1 ? 8.w : 0),
            child: Material(
              color: active ? AppColors.primaryDark : AppColors.surface,
              borderRadius: BorderRadius.circular(8.r),
              child: InkWell(
                onTap: () => onSelected(i),
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  height: 34.h,
                  child: Center(
                    child: Text(
                      labels[i],
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: active ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class PublicProfileListingCard extends StatelessWidget {
  const PublicProfileListingCard({
    super.key,
    required this.listing,
    required this.onPropose,
  });

  final PublicProfileListing listing;
  final VoidCallback onPropose;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 176.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: listing.imageUrl, fit: BoxFit.cover),
                  Positioned(
                    left: 8.w,
                    top: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        listing.condition,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    top: 8.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(999.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        listing.valueLabel,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            listing.title,
            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Icon(Icons.tune, size: 10.sp, color: AppColors.textMuted),
              SizedBox(width: 4.w),
              Text(
                listing.detailLine,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.swap_horiz, size: 12.sp, color: AppColors.accentGreen),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        listing.seekingLine,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(8.r),
                child: InkWell(
                  onTap: onPropose,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ExtraStrings.proposeCta,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_forward, size: 11.sp, color: AppColors.primaryDark),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.child,
    this.onTap,
    this.shadow = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: shadow ? AppColors.surface : Colors.transparent,
      shape: const CircleBorder(),
      elevation: shadow ? 0 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(width: 40.w, height: 40.w, child: Center(child: child)),
      ),
    );
  }
}
