import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../widgets/my_subscription_widgets.dart';
import '../widgets/subscription_widgets.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.mySubscriptionTitle),
            SizedBox(height: 16.h),
            const MySubscriptionImpactToast(),
            SizedBox(height: 16.h),
            MySubscriptionHeroCard(
              onChangePlan: () => context.push(AppRouter.choosePlan),
            ),
            SizedBox(height: 16.h),
            const MySubscriptionImpactSection(),
            SizedBox(height: 16.h),
            MySubscriptionPaymentCard(
              onManageCards: () => showMockSnackBar(context, 'Manage cards (mock)'),
              onUpdate: () => context.push(AppRouter.paymentMethod),
            ),
            SizedBox(height: 16.h),
            const MySubscriptionBillingHistoryCard(),
            SizedBox(height: 16.h),
            SwapSecondaryButton(
              label: SubscriptionStrings.switchToMonthly,
              onPressed: () => context.push(AppRouter.choosePlan),
            ),
            SizedBox(height: 8.h),
            Center(
              child: TextButton(
                onPressed: () => showMockSnackBar(context, 'Subscription cancelled (mock)'),
                child: Text(
                  SubscriptionStrings.cancelSubscription,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
