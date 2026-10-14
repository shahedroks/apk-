import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../data/subscription_mock_data.dart';

class SubscriptionTopBar extends StatelessWidget {
  const SubscriptionTopBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 8.h),
      child: Row(
        children: [
          ProfileCircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            backgroundColor: AppColors.surface,
            onTap: onBack ?? () => context.pop(),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
                letterSpacing: -0.45,
              ),
            ),
          ),
          ProfileCircleButton(
            icon: Icons.help_outline,
            backgroundColor: AppColors.surface,
            onTap: () => showMockSnackBar(context, 'Membership help (mock)'),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => context.push(AppRouter.profile),
            child: const ProfileAvatar(radius: 18),
          ),
        ],
      ),
    );
  }
}

class SubscriptionFlowStepLabel extends StatelessWidget {
  const SubscriptionFlowStepLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.55,
        color: AppColors.accentGreen,
      ),
    );
  }
}

class MembershipChip extends StatelessWidget {
  const MembershipChip({super.key, required this.label});

  final String label;

  static const _chipBg = Color(0xFFDEE9FC);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.eco_outlined, size: 10.sp, color: AppColors.accentGreen),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class BillingCadenceToggle extends StatelessWidget {
  const BillingCadenceToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(999.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _cadenceTab(
              label: SubscriptionStrings.billedMonthly,
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _cadenceTab(
              label: SubscriptionStrings.billedAnnually,
              badge: SubscriptionStrings.twoMonthsFree,
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cadenceTab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    String? badge,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(999.r),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.primaryDark : AppColors.textSecondary,
              ),
            ),
            if (badge != null) ...[
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  badge,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF457000),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PlanTierCard extends StatelessWidget {
  const PlanTierCard({
    super.key,
    required this.plan,
    required this.onPrimaryTap,
    required this.primaryLabel,
    this.primaryFilled = true,
  });

  final PlanTier plan;
  final VoidCallback? onPrimaryTap;
  final String primaryLabel;
  final bool primaryFilled;

  static const _chipBlue = Color(0xFFDEE9FC);

  @override
  Widget build(BuildContext context) {
    final isFree = plan.variant == ChoosePlanCardVariant.freeCurrent;
    final isYearly = plan.variant == ChoosePlanCardVariant.featuredYearly;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isFree ? AppColors.infoBackground.withValues(alpha: 0.9) : AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: isYearly
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 25,
                      offset: const Offset(0, 20),
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 8),
                      spreadRadius: -6,
                    ),
                  ]
                : [
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
              _cardHeader(),
              SizedBox(height: 8.h),
              Text(
                plan.name,
                style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              if (plan.tagline != null) ...[
                SizedBox(height: 2.h),
                Text(
                  plan.tagline!,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    height: 20 / 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              SizedBox(height: 8.h),
              _priceRow(),
              if (plan.savingsLine != null) ...[
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      plan.variant == ChoosePlanCardVariant.featuredYearly
                          ? Icons.bolt_rounded
                          : Icons.eco_outlined,
                      size: 11.sp,
                      color: AppColors.accentGreen,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      plan.savingsLine!,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 8.h),
              Divider(height: 1, thickness: 1, color: AppColors.borderLight),
              SizedBox(height: 8.h),
              ...plan.features.map(_featureRow),
              if (plan.perkHighlight != null) ...[
                SizedBox(height: 8.h),
                _perkHighlightBox(plan.perkHighlight!),
              ],
              SizedBox(height: 16.h),
              _ctaButton(),
            ],
          ),
        ),
        if (isYearly)
          Positioned(
            top: -24.h,
            right: -20.w,
            child: IgnorePointer(
              child: Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentLime.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _cardHeader() {
    final badge = plan.headerBadge;
    if (badge == null) return const SizedBox.shrink();

    Color badgeBg;
    Color badgeFg;
    Widget? leading;
    switch (plan.variant) {
      case ChoosePlanCardVariant.featuredYearly:
        badgeBg = AppColors.accentLime;
        badgeFg = const Color(0xFF457000);
        leading = Icon(Icons.star_rounded, size: 11.sp, color: badgeFg);
      case ChoosePlanCardVariant.monthly:
        badgeBg = AppColors.borderLight;
        badgeFg = AppColors.textSecondary;
        leading = Container(
          width: 9.w,
          height: 9.w,
          decoration: const BoxDecoration(
            color: AppColors.textSecondary,
            shape: BoxShape.circle,
          ),
        );
      case ChoosePlanCardVariant.freeCurrent:
        badgeBg = _chipBlue;
        badgeFg = AppColors.textSecondary;
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[leading, SizedBox(width: 4.w)],
              Text(
                badge,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: badgeFg,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        if (plan.trailingHeaderBadge != null)
          Text(
            plan.trailingHeaderBadge!,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          )
        else if (plan.variant == ChoosePlanCardVariant.featuredYearly)
          Container(
            width: 24.w,
            height: 24.w,
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
            child: Center(
              child: Icon(Icons.check_rounded, size: 14.sp, color: const Color(0xFF457000)),
            ),
          )
        else if (plan.variant == ChoosePlanCardVariant.monthly)
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: AppColors.borderLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.calendar_month_outlined, size: 12.sp, color: AppColors.textSecondary),
          ),
      ],
    );
  }

  Widget _priceRow() {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              plan.price,
              style: AppTextStyles.screenTitle(fontSize: 36.sp).copyWith(
                fontWeight: FontWeight.w800,
                height: 1,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              plan.period,
              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (plan.strikePrice != null) ...[
              const Spacer(),
              Text(
                plan.strikePrice!,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        );
  }

  Widget _featureRow(PlanFeature f) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (f.included && plan.variant == ChoosePlanCardVariant.featuredYearly)
            Container(
              width: 20.w,
              height: 20.w,
              margin: EdgeInsets.only(top: 2.h),
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
            )
          else
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Icon(
                f.included ? Icons.check_rounded : Icons.remove_rounded,
                size: 15.sp,
                color: f.included ? AppColors.accentGreen : AppColors.textSecondary,
              ),
            ),
          SizedBox(width: 10.w),
          Expanded(child: _featureText(f)),
        ],
      ),
    );
  }

  Widget _featureText(PlanFeature f) {
    final baseStyle = AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
      color: f.included ? AppColors.textPrimary : AppColors.textSecondary,
      fontWeight: f.emphasized ? FontWeight.w700 : FontWeight.w400,
    );
    final phrase = f.highlightPhrase;
    if (phrase == null || !f.text.contains(phrase)) {
      return Text(f.text, style: baseStyle);
    }
    final parts = f.text.split(phrase);
    if (f.boldHighlight) {
      return Text.rich(
        TextSpan(
          style: baseStyle.copyWith(fontWeight: FontWeight.w400),
          children: [
            TextSpan(text: parts.first),
            TextSpan(
              text: phrase,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            if (parts.length > 1) TextSpan(text: parts[1]),
          ],
        ),
      );
    }
    final parts2 = f.text.split(phrase);
    return Text.rich(
      TextSpan(
        style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
          color: AppColors.textPrimary,
        ),
        children: [
          TextSpan(text: parts2.first),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              color: AppColors.infoBackground,
              child: Text(
                phrase,
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          if (parts2.length > 1) TextSpan(text: parts2[1]),
        ],
      ),
    );
  }

  Widget _perkHighlightBox(PlanPerkHighlight highlight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.military_tech_outlined, size: 14.sp, color: AppColors.accentGreen),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  highlight.title,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  highlight.subtitle,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
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

  Widget _ctaButton() {
    if (plan.isActive) {
      return SizedBox(
        width: double.infinity,
        height: 48.h,
        child: FilledButton(
          onPressed: null,
          style: FilledButton.styleFrom(
            backgroundColor: _chipBlue,
            disabledBackgroundColor: _chipBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            elevation: 0,
          ),
          child: Text(
            primaryLabel,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    if (primaryFilled && plan.variant == ChoosePlanCardVariant.featuredYearly) {
      return SizedBox(
        width: double.infinity,
        height: 48.h,
        child: FilledButton.icon(
          onPressed: onPrimaryTap,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            elevation: 0,
          ),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 12.sp, color: Colors.white),
          label: Text(
            primaryLabel,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: FilledButton(
        onPressed: onPrimaryTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.borderLight,
          foregroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
        ),
        child: Text(
          primaryLabel,
          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}

class DarkGradientHeroCard extends StatelessWidget {
  const DarkGradientHeroCard({
    super.key,
    required this.title,
    required this.body,
    this.topChip,
  });

  final String? topChip;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topChip != null) ...[
            Text(
              topChip!,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                color: AppColors.accentLime,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          Text(
            title,
            style: AppTextStyles.screenTitle(fontSize: 26.sp).copyWith(
              color: Colors.white,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            body,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              color: const Color(0xFF79A694),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionTextField extends StatelessWidget {
  const SubscriptionTextField({
    super.key,
    required this.label,
    this.hint,
    this.suffix,
    this.prefixIcon,
    this.keyboardType,
  });

  final String label;
  final String? hint;
  final Widget? suffix;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption(fontSize: 12.sp)),
        SizedBox(height: 6.h),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20.sp, color: AppColors.textMuted)
                : null,
            suffixIcon: suffix,
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
      ],
    );
  }
}

