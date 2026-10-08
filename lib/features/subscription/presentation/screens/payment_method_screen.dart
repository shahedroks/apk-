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

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.paymentMethodTitle),
            _securityStrip(),
            SizedBox(height: 16.h),
            const VirtualCardPreview(),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: () => showMockSnackBar(context, 'Card scan (mock)'),
              icon: Icon(Icons.camera_alt_outlined, size: 18.sp),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(SubscriptionStrings.scanCard),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.accentLime,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      SubscriptionStrings.fast,
                      style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                side: const BorderSide(color: AppColors.borderLight),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            const SubscriptionTextField(
              label: SubscriptionStrings.cardholderName,
              hint: 'Full name on card',
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: 12.h),
            SubscriptionTextField(
              label: SubscriptionStrings.cardNumber,
              hint: '0000 0000 0000 0000',
              prefixIcon: Icons.credit_card,
              suffix: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.payment, size: 18.sp, color: AppColors.textMuted),
                    SizedBox(width: 4.w),
                    Icon(Icons.credit_card, size: 18.sp, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: const SubscriptionTextField(
                    label: SubscriptionStrings.expiryDate,
                    hint: 'MM/YY',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: const SubscriptionTextField(
                    label: SubscriptionStrings.cvv,
                    hint: '•••',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const SubscriptionTextField(
              label: SubscriptionStrings.countryRegion,
              hint: 'United States',
              prefixIcon: Icons.public,
            ),
            SizedBox(height: 12.h),
            const SubscriptionTextField(
              label: SubscriptionStrings.postalZip,
              hint: '10001',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            SwapPrimaryButton(
              label: SubscriptionStrings.addCardCta,
              onPressed: () => context.push(AppRouter.paymentConfirmation),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                SubscriptionStrings.cancelReturnPayment,
                style: AppTextStyles.caption(fontSize: 12.sp),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _securityStrip() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.accentLime.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, size: 14.sp, color: AppColors.primary),
              SizedBox(width: 6.w),
              Text(
                SubscriptionStrings.pciBanner,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            SubscriptionStrings.tlsActive,
            style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
}
