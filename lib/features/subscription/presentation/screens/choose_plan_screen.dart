import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/subscription_mock_data.dart';
import '../providers/subscription_ui_provider.dart';
import '../../../../core/utils/mock_actions.dart';
import '../widgets/subscription_widgets.dart';

class ChoosePlanScreen extends ConsumerWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final annual = ref.watch(billingCadenceProvider) == 1;
    final plans = SubscriptionMockData.plans(annual: annual);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            const SubscriptionTopBar(title: '02 Choose Plan'),
            const MembershipChip(label: SubscriptionStrings.circularMembership),
            SizedBox(height: 8.h),
            Text(
              SubscriptionStrings.choosePlanIntro,
              style: AppTextStyles.subtitle(fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            BillingCadenceToggle(
              selectedIndex: ref.watch(billingCadenceProvider),
              onChanged: (i) => ref.read(billingCadenceProvider.notifier).state = i,
            ),
            SizedBox(height: 16.h),
            ...plans.map((plan) {
              String cta;
              bool filled = true;
              VoidCallback? onTap;
              if (plan.isActive) {
                cta = SubscriptionStrings.yourActivePlan;
                filled = false;
              } else if (plan.id == 'yearly') {
                cta = SubscriptionStrings.chooseYearlyPlan;
                onTap = () => context.push(AppRouter.paymentMethod);
              } else if (plan.id == 'monthly') {
                cta = SubscriptionStrings.selectMonthly;
                filled = false;
                onTap = () => context.push(AppRouter.paymentMethod);
              } else {
                cta = SubscriptionStrings.selectMonthly;
              }
              return PlanTierCard(
                plan: plan,
                primaryLabel: cta,
                primaryFilled: filled,
                onPrimaryTap: onTap,
              );
            }),
            _trustGuarantee(),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => showMockSnackBar(context, 'Terms of service (mock)'),
                  child: Text(SubscriptionStrings.termsOfService),
                ),
                Text('·', style: AppTextStyles.caption(fontSize: 12.sp)),
                TextButton(
                  onPressed: () => showMockSnackBar(context, 'Privacy policy (mock)'),
                  child: Text(SubscriptionStrings.privacyPolicy),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _trustGuarantee() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SubscriptionStrings.circularTrustGuarantee,
                  style: AppTextStyles.label(fontSize: 14.sp),
                ),
                Text(
                  SubscriptionStrings.circularTrustBody,
                  style: AppTextStyles.caption(fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
