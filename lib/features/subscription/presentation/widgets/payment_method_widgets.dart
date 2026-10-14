import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/theme/text_styles.dart';

class PaymentSecurityStrip extends StatelessWidget {
  const PaymentSecurityStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.verified_outlined, size: 12.sp, color: AppColors.accentGreen),
              SizedBox(width: 4.w),
              Text(
                SubscriptionStrings.pciBanner,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                SubscriptionStrings.tlsActive,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentVirtualCardPreview extends StatelessWidget {
  const PaymentVirtualCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 226.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            Color(0xFF1E392B),
            AppColors.primaryDark,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: const Offset(0, 20),
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 8),
            spreadRadius: -6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            Positioned(
              right: -48.w,
              top: -48.h,
              child: Container(
                width: 192.w,
                height: 192.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentGreen.withValues(alpha: 0.15),
                ),
              ),
            ),
            Positioned(
              left: -40.w,
              bottom: -40.h,
              child: Container(
                width: 176.w,
                height: 176.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFA3D0BE).withValues(alpha: 0.1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.eco_outlined, size: 14.sp, color: AppColors.accentLime),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            SubscriptionStrings.cardPreviewBrand,
                            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.45,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.contactless_outlined,
                            size: 18.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'VISA',
                              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _EmvChip(),
                      SizedBox(width: 8.w),
                      Icon(Icons.lock_outline, size: 10.sp, color: Colors.white.withValues(alpha: 0.7)),
                      SizedBox(width: 4.w),
                      Text(
                        SubscriptionStrings.cardTokenized,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  Text(
                    SubscriptionStrings.cardPreviewNumber,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.88,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          offset: const Offset(0, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SubscriptionStrings.cardPreviewHolderLabel,
                            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            SubscriptionStrings.cardPreviewName,
                            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            SubscriptionStrings.cardPreviewExpiresLabel,
                            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            SubscriptionStrings.cardPreviewExpiryPlaceholder,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.7,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmvChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 32.h,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFCD34D), Color(0xFFFDE68A), Color(0xFFFBBF24)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (_) => Container(
            margin: EdgeInsets.symmetric(vertical: 1.5.h),
            height: 1,
            color: const Color(0xFFD97706).withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

class PaymentScanCardButton extends StatelessWidget {
  const PaymentScanCardButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.borderLight,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, size: 16.sp, color: AppColors.primaryDark),
              SizedBox(width: 8.w),
              Text(
                SubscriptionStrings.scanCard,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  SubscriptionStrings.fast,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF102000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentFormField extends StatelessWidget {
  const PaymentFormField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.icon,
    this.suffix,
    this.labelTrailing,
    this.showChevron = false,
    this.keyboardType,
    this.readOnly = false,
    this.monospace = false,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final Widget? suffix;
  final Widget? labelTrailing;
  final bool showChevron;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool monospace;

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFC0C8C3),
      fontFamily: monospace ? 'monospace' : null,
    );
    final textStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
      fontFamily: monospace ? 'monospace' : null,
      height: 18 / 14,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (labelTrailing != null) labelTrailing!,
          ],
        ),
        SizedBox(height: 6.h),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              readOnly: readOnly,
              keyboardType: keyboardType,
              style: textStyle,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: hintStyle,
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: EdgeInsets.fromLTRB(
                  icon != null ? 44.w : 16.w,
                  15.h,
                  showChevron ? 32.w : (suffix != null ? 96.w : 16.w),
                  15.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
              ),
            ),
            if (icon != null)
              Positioned(
                left: 16.w,
                child: Icon(icon, size: 16.sp, color: AppColors.textSecondary),
              ),
            if (suffix != null)
              Positioned(
                right: 12.w,
                child: suffix!,
              ),
            if (showChevron)
              Positioned(
                right: 12.w,
                child: Icon(Icons.keyboard_arrow_down_rounded, size: 18.sp, color: AppColors.textSecondary),
              ),
          ],
        ),
      ],
    );
  }
}

class PaymentCardBrandChips extends StatelessWidget {
  const PaymentCardBrandChips({super.key});

  @override
  Widget build(BuildContext context) {
    const labels = ['VISA', 'MC', 'AMEX'];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : 6.w),
            child: _brandChip(labels[i]),
          ),
      ],
    );
  }

  Widget _brandChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
