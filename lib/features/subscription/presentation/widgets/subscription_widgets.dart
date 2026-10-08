import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
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
              style: AppTextStyles.screenTitle(fontSize: 16.sp),
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

class MembershipChip extends StatelessWidget {
  const MembershipChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(999.r),
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
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
            if (badge != null) ...[
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: selected ? AppColors.accentLime : AppColors.mintGlow,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  badge,
                  style: AppTextStyles.caption(fontSize: 8.sp).copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryDark,
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

  @override
  Widget build(BuildContext context) {
    final borderColor = plan.highlighted ? AppColors.primary : AppColors.borderLight;
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: plan.highlighted ? 2 : 1),
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
          if (plan.badge != null)
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.accentLime,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                plan.badge!,
                style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(plan.name, style: AppTextStyles.label(fontSize: 16.sp)),
              ),
              if (plan.isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    SubscriptionStrings.active,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                plan.price,
                style: AppTextStyles.screenTitle(fontSize: 26.sp),
              ),
              Text(
                plan.period,
                style: AppTextStyles.subtitle(fontSize: 13.sp),
              ),
              if (plan.strikePrice != null) ...[
                SizedBox(width: 8.w),
                Text(
                  plan.strikePrice!,
                  style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          ...plan.features.map(
            (f) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    f.included ? Icons.check_circle : Icons.check_circle_outline,
                    size: 16.sp,
                    color: f.included ? AppColors.accentGreen : AppColors.textMuted,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      f.text,
                      style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                        color: f.included ? AppColors.textPrimary : AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (plan.extraHighlight != null) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.mintGlow.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.military_tech_outlined, size: 18.sp, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      plan.extraHighlight!,
                      style: AppTextStyles.caption(fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 14.h),
          if (primaryFilled)
            SwapPrimaryButton(label: primaryLabel, onPressed: onPrimaryTap)
          else if (plan.isActive)
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: FilledButton(
                onPressed: null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.infoBackground,
                  disabledBackgroundColor: AppColors.infoBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  primaryLabel,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            )
          else
            SwapSecondaryButton(label: primaryLabel, onPressed: onPrimaryTap ?? () {}),
        ],
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

class VirtualCardPreview extends StatelessWidget {
  const VirtualCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF145A45), AppColors.primaryDark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SWAP IT',
                style: AppTextStyles.label(fontSize: 14.sp).copyWith(color: Colors.white),
              ),
              Icon(Icons.credit_card, color: Colors.white.withValues(alpha: 0.8), size: 28.sp),
            ],
          ),
          const Spacer(),
          Text(
            '•••• •••• •••• 4242',
            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SubscriptionStrings.cardPreviewName,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(color: Colors.white70),
              ),
              Text(
                '09/28',
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
