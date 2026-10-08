import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/match_mock_data.dart';

class MatchSummaryBanner extends StatelessWidget {
  const MatchSummaryBanner({super.key, this.onRecalculate});

  final VoidCallback? onRecalculate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mintGlow.withValues(alpha: 0.7),
            AppColors.accentLime.withValues(alpha: 0.25),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.accentLime.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onRecalculate,
              icon: Icon(Icons.sync, size: 16.sp, color: AppColors.primary),
              label: Text(
                MatchStrings.recalculate,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          Text(
            MatchStrings.weFoundMatches,
            style: AppTextStyles.screenTitle(fontSize: 18.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            MatchStrings.matchBannerSub,
            style: AppTextStyles.subtitle(fontSize: 13.sp),
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
    Icons.place_outlined,
    Icons.schedule,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final active = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: active ? AppColors.primaryDark : AppColors.surface,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: active ? AppColors.primaryDark : AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _icons[index],
                    size: 14.sp,
                    color: active ? Colors.white : AppColors.textMuted,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    _labels[index],
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w700,
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
    final theyOffers = '${match.partnerName.split(' ').first.toUpperCase()} OFFERS';

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.infoBackground,
                child: Text(match.partnerName.substring(0, 1)),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(match.partnerName, style: AppTextStyles.label(fontSize: 14.sp)),
                        if (match.isPro) ...[
                          SizedBox(width: 6.w),
                          _proBadge(),
                        ],
                      ],
                    ),
                    Text(match.activeLabel, style: AppTextStyles.caption(fontSize: 11.sp)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  '${match.matchPercent}% Match',
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _miniItem(
                  MatchStrings.youOffer,
                  match.youOfferTitle,
                  match.youColor,
                ),
              ),
              Container(
                width: 32.w,
                height: 32.w,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.swap_horiz, size: 18.sp, color: AppColors.primaryDark),
              ),
              Expanded(
                child: _miniItem(theyOffers, match.theyOfferTitle, match.theyColor),
              ),
            ],
          ),
          SizedBox(height: 12.h),
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
                Icon(Icons.check_circle, size: 18.sp, color: AppColors.accentGreen),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    match.reason,
                    style: AppTextStyles.caption(fontSize: 12.sp).copyWith(height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: onPropose,
                  icon: Icon(Icons.arrow_forward, size: 18.sp),
                  label: Text(MatchStrings.proposesSwap),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(0, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: onSecondary ?? onDetails,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(0, 44.h),
                    backgroundColor: AppColors.infoBackground,
                    side: const BorderSide(color: AppColors.infoBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    match.secondaryAction,
                    style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                      fontWeight: FontWeight.w700,
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
        style: AppTextStyles.caption(fontSize: 9.sp).copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _miniItem(String label, String title, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.caption(fontSize: 9.sp).copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 4.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: ColoredBox(
            color: color,
            child: SizedBox(width: 56.w, height: 56.w),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption(fontSize: 10.sp),
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
