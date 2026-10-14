import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../data/match_mock_data.dart';

class MatchDetailTopBar extends StatelessWidget {
  const MatchDetailTopBar({
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
      height: 56.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp),
            onPressed: onBack,
          ),
          Expanded(
            child: Text(
              MatchStrings.matchDetails,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
                letterSpacing: -0.45,
              ),
            ),
          ),
          IconButton(
            onPressed: onMenu,
            icon: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onProfile,
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Center(
                    child: ProfileAvatar(
                      radius: 16,
                      imageUrl: ProfileStrings.profileAvatarUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchCompatibilityHero extends StatelessWidget {
  const MatchCompatibilityHero({super.key, required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -40.w,
            bottom: -40.h,
            child: Container(
              width: 176.w,
              height: 176.w,
              decoration: BoxDecoration(
                color: AppColors.accentLime.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MatchPercentRing(percent: percent),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MatchStrings.highCompatibility,
                          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.55,
                            color: AppColors.accentLime,
                          ),
                        ),
                        Text(
                          MatchStrings.exceptionalMatch,
                          style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.38,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          MatchStrings.exceptionalBody,
                          style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                            height: 1.33,
                            color: const Color(0xFF79A694),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.accentLime),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        MatchStrings.safeHubLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFBEEDD9),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        MatchStrings.verifiedZone,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatchPercentRing extends StatelessWidget {
  const _MatchPercentRing({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    final ringSize = 96.w;
    final stroke = 5.w;

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: ringSize,
            height: ringSize,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: stroke,
              backgroundColor: const Color(0xFF1E392B),
              color: AppColors.accentLime,
            ),
          ),
          SizedBox(
            width: ringSize - stroke * 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percent%',
                    style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.accentLime,
                      letterSpacing: -1.1,
                      height: 1,
                    ),
                  ),
                  Text(
                    'MATCH',
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: const Color(0xFF79A694),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchInspectionSection extends StatelessWidget {
  const MatchInspectionSection({super.key, required this.detail});

  final MatchDetailSnapshot detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              MatchStrings.inspectionView,
              style: AppTextStyles.label(fontSize: 16.sp).copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Icon(Icons.sync, size: 12.sp, color: AppColors.accentGreen),
            SizedBox(width: 4.w),
            Text(
              MatchStrings.equitableValue,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _InspectionCard(side: detail.yourSide)),
                SizedBox(width: 8.w),
                Expanded(child: _InspectionCard(side: detail.theirSide)),
              ],
            ),
            Positioned(
              top: 112.h,
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(Icons.swap_horiz, size: 15.sp, color: const Color(0xFF457000)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InspectionCard extends StatelessWidget {
  const _InspectionCard({required this.side});

  final MatchInspectionSide side;

  @override
  Widget build(BuildContext context) {
    final labelColor = side.requestedStyle ? AppColors.accentGreen : AppColors.primaryDark;

    return Container(
      padding: EdgeInsets.all(8.w),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                side.sectionLabel,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: labelColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  side.cornerBadge,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 159.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (side.imageUrl != null && side.imageUrl!.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: side.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const ColoredBox(color: AppColors.borderLight),
                      errorWidget: (_, _, _) => ColoredBox(
                        color: AppColors.infoBackground,
                        child: Icon(Icons.image_outlined, size: 32.sp, color: AppColors.textMuted),
                      ),
                    )
                  else
                    const ColoredBox(color: AppColors.borderLight),
                  Positioned(
                    left: 6.w,
                    bottom: 6.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        side.conditionOnImage,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            side.category,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            side.title,
            style: AppTextStyles.label(fontSize: 14.sp).copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MatchStrings.tierPrefix,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      side.tierRange,
                      style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  MatchStrings.seekingPrefix,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  side.seeking,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: side.highlightSeeking ? AppColors.accentGreen : AppColors.primaryDark,
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

class MatchPartnerBar extends StatelessWidget {
  const MatchPartnerBar({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.rating,
  });

  final String name;
  final String avatarUrl;
  final double rating;

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
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: CachedNetworkImage(imageUrl: avatarUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.verified, size: 14.sp, color: AppColors.accentGreen),
                  ],
                ),
                Text(
                  MatchStrings.topSwapperLine,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.star, size: 12.sp, color: AppColors.accentGreen),
                SizedBox(width: 2.w),
                Text(
                  rating.toStringAsFixed(1),
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
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

class MatchDetailFactorRow extends StatelessWidget {
  const MatchDetailFactorRow({super.key, required this.metric});

  final CompatibilityMetric metric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(metric.icon, size: 18.sp, color: AppColors.accentGreen),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  metric.title,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentGreen,
                  ),
                ),
              ),
              Text(
                '${metric.percent}%',
                style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: SizedBox(
              height: 8.h,
              child: LinearProgressIndicator(
                value: metric.percent / 100,
                backgroundColor: AppColors.borderLight,
                color: AppColors.accentLime,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            metric.detail,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class MatchDetailBottomBar extends StatelessWidget {
  const MatchDetailBottomBar({
    super.key,
    required this.partnerFirstName,
    required this.onPropose,
    required this.onMessage,
    required this.onDecline,
  });

  final String partnerFirstName;
  final VoidCallback onPropose;
  final VoidCallback onMessage;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: onPropose,
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.handshake_outlined, size: 18.sp, color: AppColors.accentLime),
                      SizedBox(width: 4.w),
                      Text(
                        MatchStrings.proposeOneTap,
                        style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.325,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(Icons.arrow_forward, size: 12.sp, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      onTap: onMessage,
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 44.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat_bubble_outline, size: 15.sp, color: AppColors.primaryDark),
                            SizedBox(width: 6.w),
                            Text(
                              '${MatchStrings.message} $partnerFirstName',
                              style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onDecline,
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      height: 44.h,
                      width: 121.w,
                      child: Center(
                        child: Text(
                          MatchStrings.declineMatch,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
