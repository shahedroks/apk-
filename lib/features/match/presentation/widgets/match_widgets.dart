import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/match_mock_data.dart';

class MatchSummaryBanner extends StatelessWidget {
  const MatchSummaryBanner({super.key, this.onRecalculate});

  final VoidCallback? onRecalculate;

  static const _bannerBg = Color(0xFFCAEAD6);
  static const _bodyColor = Color(0xFF314D3E);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _bannerBg,
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
            right: -16.w,
            top: -24.h,
            child: Container(
              width: 112.w,
              height: 112.w,
              decoration: BoxDecoration(
                color: AppColors.accentLime.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
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
                child: Icon(Icons.auto_awesome, size: 18.sp, color: AppColors.primaryDark),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            MatchStrings.weFoundMatches,
                            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                              letterSpacing: -0.45,
                              height: 1.33,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(999.r),
                          child: InkWell(
                            onTap: onRecalculate,
                            borderRadius: BorderRadius.circular(999.r),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.sync, size: 12.sp, color: AppColors.primaryDark),
                                  SizedBox(width: 4.w),
                                  Text(
                                    MatchStrings.recalculate,
                                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      MatchStrings.matchBannerSub,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        height: 1.62,
                        color: _bodyColor,
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

class MatchFilterChips extends StatelessWidget {
  const MatchFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _labels = [
    MatchStrings.filterHighMatch,
    MatchStrings.filterNearby,
    MatchStrings.filterRecent,
  ];

  static const _icons = [
    Icons.bolt,
    Icons.near_me_outlined,
    Icons.schedule_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: _labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final active = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: active ? AppColors.primaryDark : AppColors.infoBackground,
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _icons[index],
                    size: 12.sp,
                    color: active ? Colors.white : AppColors.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _labels[index],
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.match,
    required this.onDetails,
    required this.onPropose,
    this.onSecondary,
  });

  final SwapMatchSummary match;
  final VoidCallback onDetails;
  final VoidCallback onPropose;
  final VoidCallback? onSecondary;

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
          Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: match.avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: match.avatarUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => const ColoredBox(color: AppColors.borderLight),
                          errorWidget: (_, _, _) => ColoredBox(
                            color: AppColors.borderLight,
                            child: Center(
                              child: Text(
                                match.partnerName.substring(0, 1),
                                style: AppTextStyles.label(fontSize: 16.sp),
                              ),
                            ),
                          ),
                        )
                      : ColoredBox(
                          color: AppColors.borderLight,
                          child: Center(
                            child: Text(
                              match.partnerName.substring(0, 1),
                              style: AppTextStyles.label(fontSize: 16.sp),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          match.partnerName,
                          style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (match.isPro) ...[
                          SizedBox(width: 6.w),
                          _proBadge(),
                        ],
                      ],
                    ),
                    if (!match.isPro && match.activeLabel.isNotEmpty)
                      Text(
                        match.activeLabel,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              _MatchPercentBadge(percent: match.matchPercent, high: match.isHighMatch),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _OfferColumn(label: MatchStrings.youOffer, title: match.youOfferTitle, imageUrl: match.youImageUrl, fallback: match.youColor)),
                Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: AppColors.accentLime,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.swap_horiz, size: 18.sp, color: AppColors.primaryDark),
                  ),
                ),
                Expanded(
                  child: _OfferColumn(
                    label: match.theyOffersLabel,
                    title: match.theyOfferTitle,
                    imageUrl: match.theyImageUrl,
                    fallback: match.theyColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(match.reasonIcon, size: 16.sp, color: AppColors.accentGreen),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    match.reason,
                    style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                      height: 1.35,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Material(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(8.r),
                  child: InkWell(
                    onTap: onPropose,
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      height: 44.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            MatchStrings.proposesSwap,
                            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.arrow_forward, size: 14.sp, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Material(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(8.r),
                  child: InkWell(
                    onTap: onSecondary ?? onDetails,
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      height: 44.h,
                      child: Center(
                        child: Text(
                          match.secondaryAction,
                          style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                          ),
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
    );
  }

  Widget _proBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.accentLime,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        MatchStrings.pro,
        style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}

class _MatchPercentBadge extends StatelessWidget {
  const _MatchPercentBadge({required this.percent, required this.high});

  final int percent;
  final bool high;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: high ? AppColors.accentLime : const Color(0xFFDEE9FC),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (high) ...[
            Icon(Icons.bolt, size: 10.sp, color: AppColors.primaryDark),
            SizedBox(width: 4.w),
          ],
          Text(
            '$percent% Match',
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: high ? AppColors.primaryDark : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _offerImageFallback(Color fallback) {
  return ColoredBox(
    color: fallback,
    child: Center(
      child: Icon(Icons.image_outlined, size: 28.sp, color: AppColors.textMuted),
    ),
  );
}

class _OfferColumn extends StatelessWidget {
  const _OfferColumn({
    required this.label,
    required this.title,
    this.imageUrl,
    required this.fallback,
  });

  final String label;
  final String title;
  final String? imageUrl;
  final Color fallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(
            width: double.infinity,
            height: 120.h,
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => ColoredBox(
                      color: fallback,
                      child: Center(
                        child: SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.accentGreen.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (_, _, _) => _offerImageFallback(fallback),
                  )
                : _offerImageFallback(fallback),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class MatchScoreRing extends StatelessWidget {
  const MatchScoreRing({super.key, required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.w,
      height: 72.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent / 100,
            strokeWidth: 6,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            color: AppColors.accentLime,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent%',
                style: AppTextStyles.label(fontSize: 16.sp).copyWith(color: Colors.white),
              ),
              Text(
                'MATCH',
                style: AppTextStyles.caption(fontSize: 8.sp).copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompatibilityFactorRow extends StatelessWidget {
  const CompatibilityFactorRow({super.key, required this.metric});

  final CompatibilityMetric metric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(metric.icon, size: 18.sp, color: AppColors.primary),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(metric.title, style: AppTextStyles.label(fontSize: 13.sp)),
              ),
              Text(
                '${metric.percent}%',
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: metric.percent / 100,
              minHeight: 6.h,
              backgroundColor: AppColors.infoBorder,
              color: metric.percent >= 98 ? AppColors.accentLime : AppColors.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(metric.detail, style: AppTextStyles.caption(fontSize: 11.sp)),
        ],
      ),
    );
  }
}
