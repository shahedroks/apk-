import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../widgets/payment_confirmation_widgets.dart';
import '../widgets/subscription_widgets.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.paymentConfirmationTitle),
            SizedBox(height: 16.h),
            const PaymentConfirmationSecureBanner(),
            SizedBox(height: 24.h),
            const PaymentConfirmationIntroHeader(),
            SizedBox(height: 24.h),
            const PaymentConfirmationPlanCard(),
            SizedBox(height: 24.h),
            PaymentConfirmationPaymentCard(
              onChange: () => context.push(AppRouter.paymentMethod),
            ),
            SizedBox(height: 24.h),
            const PaymentConfirmationPriceCard(),
            SizedBox(height: 24.h),
            SwapPrimaryButton(
              label: SubscriptionStrings.confirmPay,
              onPressed: () {
                context.go(AppRouter.mySubscription);
              },
            ),
          ],
        ),
      ),
    );
  }
}
