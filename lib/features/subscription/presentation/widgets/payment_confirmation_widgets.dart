import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/subscription_checkout_mock.dart';

class PaymentConfirmationSecureBanner extends StatelessWidget {
  const PaymentConfirmationSecureBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
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
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.verified_user, size: 16.sp, color: const Color(0xFF102000)),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SubscriptionStrings.secureCheckout,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  SubscriptionStrings.secureCheckoutSub,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(999.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
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
                SizedBox(width: 4.w),
                Text(
                  SubscriptionStrings.liveSync,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentConfirmationIntroHeader extends StatelessWidget {
  const PaymentConfirmationIntroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          SubscriptionStrings.step3Of3,
          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.55,
            color: AppColors.accentGreen,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          SubscriptionStrings.reviewSubscriptionTitle,
          style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.55,
            color: AppColors.primaryDark,
            height: 28 / 22,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          SubscriptionStrings.reviewSubscriptionIntro,
          style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
            height: 20 / 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class PaymentConfirmationPlanCard extends StatelessWidget {
  const PaymentConfirmationPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              SubscriptionStrings.premiumYearly,
                              style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: AppColors.mintGlow,
                                borderRadius: BorderRadius.circular(999.r),
                              ),
                              child: Text(
                                SubscriptionStrings.activeChoice,
                                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: const Color(0xFF002117),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          SubscriptionStrings.billedAnnuallyPeriod,
                          style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                            height: 20 / 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFCAEAD6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.eco_outlined, size: 16.sp, color: const Color(0xFF042014)),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SubscriptionStrings.includedPerksUpper,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 8.h,
                      children: const [
                        _PerkPill(
                          icon: Icons.all_inclusive,
                          label: SubscriptionStrings.perkUnlimitedListings,
                        ),
                        _PerkPill(
                          icon: Icons.auto_awesome,
                          label: SubscriptionStrings.perkAiSmartMatching,
                        ),
                        _PerkPill(
                          icon: Icons.verified_outlined,
                          label: SubscriptionStrings.perkVerifiedBadge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -24.w,
          bottom: -24.h,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.eco, size: 128.sp, color: AppColors.primaryDark),
            ),
          ),
        ),
      ],
    );
  }
}

class _PerkPill extends StatelessWidget {
  const _PerkPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.accentGreen),
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentConfirmationPaymentCard extends StatelessWidget {
  const PaymentConfirmationPaymentCard({super.key, required this.onChange});

  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
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
            children: [
              Icon(Icons.credit_card_outlined, size: 16.sp, color: AppColors.primaryDark),
              SizedBox(width: 4.w),
              Text(
                SubscriptionStrings.paymentMethodLabel,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onChange,
                child: Row(
                  children: [
                    Text(
                      SubscriptionStrings.change,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentGreen,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, size: 16.sp, color: AppColors.accentGreen),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 45.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          'VISA',
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -0.33,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SubscriptionStrings.visaEnding,
                              style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Elena Vance',
                              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      SubscriptionStrings.billingZipLabel,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      SubscriptionStrings.billingZipValue,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentConfirmationPriceCard extends StatelessWidget {
  const PaymentConfirmationPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            SubscriptionStrings.priceBreakdownTitle,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _priceRow(
            SubscriptionStrings.subtotalTwelveMonths,
            SubscriptionCheckoutMock.listYearlyLabel,
            valueBold: false,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      SubscriptionStrings.promoDiscount,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        SubscriptionStrings.earlyBird,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF457000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                SubscriptionCheckoutMock.discountLabel,
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _priceRow(SubscriptionStrings.salesTax, '\$0.00', valueBold: false),
          SizedBox(height: 4.h),
          Divider(height: 1, thickness: 1, color: const Color(0xFFDEE9FC)),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SubscriptionStrings.totalDueToday,
                      style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        SubscriptionStrings.includesTwoMonthsFree,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF102000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                SubscriptionCheckoutMock.promoYearlyLabel,
                style: AppTextStyles.screenTitle(fontSize: 36.sp).copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.9,
                  color: AppColors.primaryDark,
                  height: 44 / 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {required bool valueBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
            fontWeight: valueBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
