import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../../../core/utils/mock_actions.dart';
import '../widgets/subscription_widgets.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.mySubscriptionTitle),
            _impactToast(),
            SizedBox(height: 14.h),
            _activePlanCard(context),
            SizedBox(height: 16.h),
            Text(SubscriptionStrings.planImpactQuotas, style: AppTextStyles.label(fontSize: 15.sp)),
            SizedBox(height: 10.h),
            _quotaRow(SubscriptionStrings.listings, '8', 'Unlimited', 0.35),
            SizedBox(height: 10.h),
            _quotaRow(SubscriptionStrings.stacks, '25', 'Min', 0.7),
            SizedBox(height: 16.h),
            _managementCard(
              title: SubscriptionStrings.paymentMethodOnFile,
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: AppColors.primary),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Visa ending 4242', style: AppTextStyles.label(fontSize: 14.sp)),
                        TextButton(
                          onPressed: () => showMockSnackBar(context, 'Manage cards (mock)'),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(SubscriptionStrings.manageCards),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => context.push(AppRouter.paymentMethod),
                    child: Text(SubscriptionStrings.update, style: TextStyle(fontSize: 12.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            _managementCard(
              title: SubscriptionStrings.billingHistory,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Premium Yearly · \$59.99',
                          style: AppTextStyles.subtitle(fontSize: 13.sp),
                        ),
                      ),
                      Icon(Icons.download_outlined, size: 20.sp),
                    ],
                  ),
                  Text('Mar 9, 2026', style: AppTextStyles.caption(fontSize: 11.sp)),
                  TextButton(
                    onPressed: () => showMockSnackBar(context, 'Invoice downloaded (mock)'),
                    child: Text(SubscriptionStrings.viewFullBillingHistory),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SwapSecondaryButton(
              label: SubscriptionStrings.switchToMonthly,
              onPressed: () => context.push(AppRouter.choosePlan),
            ),
            TextButton(
              onPressed: () => showMockSnackBar(context, 'Subscription cancelled (mock)'),
              child: Text(
                SubscriptionStrings.cancelSubscription,
                style: AppTextStyles.label(fontSize: 14.sp).copyWith(color: AppColors.error),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _impactToast() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.eco_outlined, size: 18.sp, color: AppColors.accentGreen),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              SubscriptionStrings.impactToast,
              style: AppTextStyles.label(fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activePlanCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SubscriptionStrings.activeAutoRenew,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              color: AppColors.accentLime,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            SubscriptionStrings.premiumYearly,
            style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(color: Colors.white),
          ),
          Text(
            '\$50.99 / year',
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(color: Colors.white70),
          ),
          SizedBox(height: 8.h),
          Text(
            '${SubscriptionStrings.nextBilling}: Apr 9, 2027',
            style: AppTextStyles.caption(fontSize: 12.sp).copyWith(color: Colors.white70),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.push(AppRouter.choosePlan),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentLime,
                foregroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                SubscriptionStrings.changePlanCadence,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quotaRow(String label, String used, String cap, double progress) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.label(fontSize: 14.sp)),
              Text('$used / $cap', style: AppTextStyles.caption(fontSize: 12.sp)),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: AppColors.toggleTrack,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _managementCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.label(fontSize: 14.sp)),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}
