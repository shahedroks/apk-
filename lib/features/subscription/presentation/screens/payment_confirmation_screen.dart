import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../data/subscription_mock_data.dart';
import '../widgets/subscription_widgets.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.paymentConfirmationTitle),
            _secureBanner(),
            SizedBox(height: 8.h),
            Text(
              SubscriptionStrings.step2Of3,
              style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
                color: AppColors.textMuted,
              ),
            ),
            SizedBox(height: 12.h),
            _reviewCard(),
            SizedBox(height: 14.h),
            _paymentMethodRow(context),
            SizedBox(height: 14.h),
            _priceBreakdown(),
            SizedBox(height: 20.h),
            SwapPrimaryButton(
              label: SubscriptionStrings.confirmPay,
              onPressed: () => context.go(AppRouter.mySubscription),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _secureBanner() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: AppColors.primary, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              SubscriptionStrings.secureCheckout,
              style: AppTextStyles.label(fontSize: 14.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              SubscriptionStrings.liveSync,
              style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  SubscriptionStrings.premiumYearly,
                  style: AppTextStyles.label(fontSize: 16.sp),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.mintGlow,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  SubscriptionStrings.activeChoice,
                  style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Mar 9, 2026 – Mar 9, 2027',
            style: AppTextStyles.caption(fontSize: 12.sp),
          ),
          SizedBox(height: 14.h),
          Text(SubscriptionStrings.includedPerks, style: AppTextStyles.label(fontSize: 13.sp)),
          SizedBox(height: 8.h),
          ...SubscriptionMockData.confirmationPerks.map(
            (p) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16.sp, color: AppColors.accentGreen),
                  SizedBox(width: 8.w),
                  Expanded(child: Text(p, style: AppTextStyles.subtitle(fontSize: 12.sp))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(Icons.credit_card, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Visa', style: AppTextStyles.label(fontSize: 14.sp)),
                Text('•••• 4242', style: AppTextStyles.caption(fontSize: 12.sp)),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push(AppRouter.paymentMethod),
            child: Text(SubscriptionStrings.change),
          ),
        ],
      ),
    );
  }

  Widget _priceBreakdown() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          _line(SubscriptionStrings.subtotal, '\$59.99'),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(SubscriptionStrings.promoDiscount, style: AppTextStyles.subtitle(fontSize: 13.sp)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  SubscriptionStrings.earlyBird,
                  style: AppTextStyles.caption(fontSize: 9.sp),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '-\$22.89',
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(color: AppColors.accentGreen),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _line(SubscriptionStrings.salesTax, '\$0.00'),
          const Divider(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SubscriptionStrings.totalDueToday,
                      style: AppTextStyles.label(fontSize: 14.sp),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        SubscriptionStrings.includesTwoMonthsFree,
                        style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$59.99',
                style: AppTextStyles.screenTitle(fontSize: 28.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.subtitle(fontSize: 13.sp)),
        Text(value, style: AppTextStyles.label(fontSize: 13.sp)),
      ],
    );
  }
}
