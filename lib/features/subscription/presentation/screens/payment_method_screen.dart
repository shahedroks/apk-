import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../widgets/payment_method_widgets.dart';
import '../widgets/subscription_widgets.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _postalController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: SubscriptionStrings.cardholderHint);
    _postalController = TextEditingController(text: SubscriptionStrings.postalDefault);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
          children: [
            const SubscriptionTopBar(title: SubscriptionStrings.paymentMethodTitle),
            SizedBox(height: 8.h),
            const SubscriptionFlowStepLabel(label: SubscriptionStrings.step2Of3),
            SizedBox(height: 16.h),
            const PaymentSecurityStrip(),
            SizedBox(height: 24.h),
            const PaymentVirtualCardPreview(),
            SizedBox(height: 24.h),
            PaymentScanCardButton(
              onPressed: () => showMockSnackBar(context, 'Card scan (mock)'),
            ),
            SizedBox(height: 24.h),
            PaymentFormField(
              label: SubscriptionStrings.cardholderName,
              controller: _nameController,
              icon: Icons.person_outline,
            ),
            SizedBox(height: 16.h),
            PaymentFormField(
              label: SubscriptionStrings.cardNumber,
              hint: SubscriptionStrings.cardNumberHint,
              icon: Icons.credit_card_outlined,
              monospace: true,
              suffix: const PaymentCardBrandChips(),
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PaymentFormField(
                    label: SubscriptionStrings.expiryDate,
                    hint: SubscriptionStrings.expiryHint,
                    icon: Icons.calendar_today_outlined,
                    monospace: true,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: PaymentFormField(
                    label: SubscriptionStrings.cvv,
                    hint: SubscriptionStrings.cvvHint,
                    icon: Icons.lock_outline,
                    monospace: true,
                    labelTrailing: GestureDetector(
                      onTap: () => showMockSnackBar(context, 'CVV help (mock)'),
                      child: Icon(Icons.info_outline, size: 14.sp, color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PaymentFormField(
                    label: SubscriptionStrings.countryRegion,
                    hint: SubscriptionStrings.countryDefault,
                    icon: Icons.public_outlined,
                    readOnly: true,
                    showChevron: true,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: PaymentFormField(
                    label: SubscriptionStrings.postalZip,
                    controller: _postalController,
                    icon: Icons.location_on_outlined,
                    keyboardType: TextInputType.number,
                    monospace: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: FilledButton.icon(
                onPressed: () => context.push(AppRouter.paymentConfirmation),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                ),
                icon: Icon(Icons.lock_outline, size: 14.sp, color: Colors.white),
                label: Text(
                  SubscriptionStrings.addCardCta,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => context.pop(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                minimumSize: Size(double.infinity, 34.h),
              ),
              child: Text(
                SubscriptionStrings.cancelReturnPayment,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
