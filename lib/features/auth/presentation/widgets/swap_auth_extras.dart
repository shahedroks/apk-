import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';

class SwapDividerLabel extends StatelessWidget {
  const SwapDividerLabel({super.key, this.label = AppStrings.orContinueWith});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderLight, height: 1)),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.overline(fontSize: 10.sp),
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderLight, height: 1)),
      ],
    );
  }
}

class SwapSocialButtons extends StatelessWidget {
  const SwapSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SocialChip(label: AppStrings.google)),
        SizedBox(width: 12.w),
        Expanded(child: _SocialChip(label: AppStrings.apple)),
      ],
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label == AppStrings.google) _GoogleDots(),
            if (label == AppStrings.apple)
              Icon(Icons.apple, size: 20.sp, color: AppColors.textPrimary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      height: 18.w,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: _dot(const Color(0xFF4285F4)),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _dot(const Color(0xFF34A853)),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: _dot(const Color(0xFFFBBC05)),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _dot(const Color(0xFFEA4335)),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) => Container(
        width: 7.w,
        height: 7.w,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class SwapStatsBanner extends StatelessWidget {
  const SwapStatsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.eco_outlined,
              color: AppColors.primaryDark,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              AppStrings.itemsDiverted,
              style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.trending_up_rounded,
            color: AppColors.accentGreen,
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}

class SwapInfoBox extends StatelessWidget {
  const SwapInfoBox({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.infoBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20.sp, color: AppColors.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label(fontSize: 13.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                    color: AppColors.textSecondary,
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

class SwapAuthScaffold extends StatelessWidget {
  const SwapAuthScaffold({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: child,
        ),
      ),
    );
  }
}
