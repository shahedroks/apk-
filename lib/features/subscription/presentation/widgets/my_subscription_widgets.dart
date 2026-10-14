import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';

class MySubscriptionImpactToast extends StatelessWidget {
  const MySubscriptionImpactToast();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.eco_outlined, size: 14.sp, color: const Color(0xFF416900)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  height: 18 / 13,
                  color: AppColors.textPrimary,
                ),
                children: [
                  const TextSpan(text: 'You are saving an estimated '),
                  TextSpan(
                    text: SubscriptionStrings.impactToastCo2Highlight,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentGreen,
                    ),
                  ),
                  const TextSpan(text: ' each month via circular trade.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySubscriptionHeroCard extends StatelessWidget {
  const MySubscriptionHeroCard({required this.onChangePlan});

  final VoidCallback onChangePlan;

  static const _heroBg = Color(0xFF072317);
  static const _innerBg = Color(0xFF1E392B);
  static const _mutedOnDark = Color(0xFFAFCEBA);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: _heroBg,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
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
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      SubscriptionStrings.activeAutoRenew,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.25,
                        color: const Color(0xFF457000),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.military_tech_rounded, size: 20.sp, color: const Color(0xFF91DB2A)),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  SubscriptionStrings.premiumYearly,
                  style: AppTextStyles.screenTitle(fontSize: 28.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.29,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _innerBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  SubscriptionStrings.saveFortyPercent,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: _mutedOnDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                SubscriptionStrings.yearlyPrice,
                style: AppTextStyles.screenTitle(fontSize: 36.sp).copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                SubscriptionStrings.yearlyPriceSuffix,
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                  color: _mutedOnDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            SubscriptionStrings.yearlyEquivalent,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: _mutedOnDark,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _innerBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14.sp, color: _mutedOnDark),
                    SizedBox(width: 6.w),
                    Text(
                      SubscriptionStrings.nextBilling,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: _mutedOnDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      SubscriptionStrings.nextBillingDate,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SubscriptionStrings.daysUntilBilling,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: _mutedOnDark,
                      ),
                    ),
                    Text(
                      SubscriptionStrings.memberSince,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: _mutedOnDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: FilledButton.icon(
              onPressed: onChangePlan,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentLime,
                foregroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              icon: Icon(Icons.swap_horiz_rounded, size: 16.sp, color: AppColors.primaryDark),
              label: Text(
                SubscriptionStrings.changePlanCadence,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySubscriptionImpactSection extends StatelessWidget {
  const MySubscriptionImpactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
              Icon(Icons.show_chart_rounded, size: 18.sp, color: AppColors.primaryDark),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  SubscriptionStrings.planImpactQuotas,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  SubscriptionStrings.proTier,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF102000),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _QuotaMetricCard(
                  label: SubscriptionStrings.listings,
                  value: '8',
                  highlight: SubscriptionStrings.quotaUnlimited,
                  footer: SubscriptionStrings.listingsFreeCap,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _QuotaMetricCard(
                  label: SubscriptionStrings.radius,
                  value: '25',
                  highlight: SubscriptionStrings.radiusMiles,
                  footer: SubscriptionStrings.radiusActiveMetro,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            SubscriptionStrings.includedInPlan,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          _IncludedPerkRow(text: SubscriptionStrings.perkListingsPhotos),
          SizedBox(height: 8.h),
          _IncludedPerkRow(text: SubscriptionStrings.perkSafeHub),
          SizedBox(height: 8.h),
          _IncludedPerkRow(text: SubscriptionStrings.perkChampionBadge),
        ],
      ),
    );
  }
}

class _QuotaMetricCard extends StatelessWidget {
  const _QuotaMetricCard({
    required this.label,
    required this.value,
    required this.highlight,
    required this.footer,
  });

  final String label;
  final String value;
  final String highlight;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
              height: 1.27,
            ),
          ),
          Text(
            highlight,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.accentGreen,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            footer,
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

class _IncludedPerkRow extends StatelessWidget {
  const _IncludedPerkRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: const BoxDecoration(
            color: AppColors.accentLime,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: RoundedCheckMark(
              size: 10.w,
              color: const Color(0xFF102000),
              strokeWidth: 1.8.w,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              height: 20 / 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class MySubscriptionPaymentCard extends StatelessWidget {
  const MySubscriptionPaymentCard({
    required this.onManageCards,
    required this.onUpdate,
  });

  final VoidCallback onManageCards;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
              Expanded(
                child: Text(
                  SubscriptionStrings.paymentMethodOnFile,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onManageCards,
                child: Text(
                  SubscriptionStrings.manageCards,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 32.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'VISA',
                    style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SubscriptionStrings.visaEnding,
                        style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        SubscriptionStrings.visaExpiry,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: onUpdate,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFD9E3F6),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: Text(
                    SubscriptionStrings.update,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
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

class MySubscriptionBillingHistoryCard extends StatelessWidget {
  const MySubscriptionBillingHistoryCard({this.onViewAll});

  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
              Expanded(
                child: Text(
                  SubscriptionStrings.billingHistory,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.receipt_long_outlined, size: 18.sp, color: AppColors.textMuted),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded, size: 16.sp, color: AppColors.accentGreen),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SubscriptionStrings.billingHistoryItem,
                      style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${SubscriptionStrings.billingHistoryDate} · ${SubscriptionStrings.billingHistoryAmount}',
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.download_outlined, size: 20.sp, color: AppColors.textMuted),
            ],
          ),
          if (onViewAll != null) ...[
            SizedBox(height: 8.h),
            TextButton(
              onPressed: onViewAll,
              child: Text(SubscriptionStrings.viewFullBillingHistory),
            ),
          ],
        ],
      ),
    );
  }
}
