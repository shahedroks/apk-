import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

class SwapPrimaryButton extends StatelessWidget {
  const SwapPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.iconAtEnd = false,
    this.iconAtStart = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  /// When true, label stays centered and icon sits on the trailing edge (auth screens).
  final bool iconAtEnd;
  /// When true, icon is placed before the label (check-email primary CTA).
  final bool iconAtStart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : icon != null && iconAtEnd
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: AppTextStyles.button(fontSize: 15.sp),
                      ),
                      SizedBox(width: 4.w),
                      Icon(icon, size: 18.sp, color: Colors.white),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null && iconAtStart) ...[
                        Icon(icon, size: 20.sp, color: Colors.white),
                        SizedBox(width: 10.w),
                      ],
                      Text(
                        label,
                        style: AppTextStyles.button(fontSize: 15.sp),
                      ),
                      if (icon != null && !iconAtStart && !iconAtEnd) ...[
                        SizedBox(width: 8.w),
                        Icon(icon, size: 18.sp, color: Colors.white),
                      ],
                    ],
                  ),
      ),
    );
  }
}

class SwapSecondaryButton extends StatelessWidget {
  const SwapSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.borderLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18.sp, color: AppColors.textPrimary),
              SizedBox(width: 8.w),
            ],
            Text(
              label,
              style: AppTextStyles.label(fontSize: 15.sp).copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
