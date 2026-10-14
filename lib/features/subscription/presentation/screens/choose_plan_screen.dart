import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/subscription_mock_data.dart';
import '../providers/subscription_ui_provider.dart';
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
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.choosePlanTitle),
            SizedBox(height: 8.h),
            const SubscriptionFlowStepLabel(label: SubscriptionStrings.step1Of3),
            SizedBox(height: 8.h),
            const MembershipChip(label: SubscriptionStrings.circularMembership),
            SizedBox(height: 4.h),
            Text(
              SubscriptionStrings.choosePlanIntro,
              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                height: 20 / 14,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            BillingCadenceToggle(
              selectedIndex: ref.watch(billingCadenceProvider),
              onChanged: (i) => ref.read(billingCadenceProvider.notifier).state = i,
            ),
            SizedBox(height: 24.h),
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
            SizedBox(height: 16.h),
            const _CircularTrustCard(),
            SizedBox(height: 28.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegalLink(
                  label: SubscriptionStrings.termsOfService,
                  onTap: () => showMockSnackBar(context, 'Terms of service (mock)'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    '·',
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFC0C8C3),
                    ),
                  ),
                ),
                _LegalLink(
                  label: SubscriptionStrings.privacyPolicy,
                  onTap: () => showMockSnackBar(context, 'Privacy policy (mock)'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularTrustCard extends StatelessWidget {
  const _CircularTrustCard();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.accentLime.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified_user_outlined, size: 16.sp, color: AppColors.accentGreen),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SubscriptionStrings.circularTrustGuarantee,
                      style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      SubscriptionStrings.circularTrustBody,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        height: 19 / 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(height: 1, thickness: 1, color: AppColors.borderLight),
        ],
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}
