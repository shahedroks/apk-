import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          Expanded(
            child: _SocialChip(
              label: AppStrings.google,
              onTap: () => showMockSnackBar(context, 'Google sign-in (mock)'),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _SocialChip(
              label: AppStrings.apple,
              onTap: () => showMockSnackBar(context, 'Apple sign-in (mock)'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 44.h,
          alignment: Alignment.center,
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label == AppStrings.google)
                SvgPicture.asset(
                  'assets/icons/google.svg',
                  width: 18.w,
                  height: 18.w,
                ),
              if (label == AppStrings.apple)
                Icon(Icons.apple, size: 18.sp, color: AppColors.textPrimary),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyles.label(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwapStatsBanner extends StatelessWidget {
  const SwapStatsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFDEE9FC).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.eco_outlined,
              color: AppColors.primary,
              size: 14.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.itemsDivertedHeadline,
                  style: AppTextStyles.label(fontSize: 11.sp).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Text(
                  AppStrings.itemsDivertedSubline,
                  style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.trending_up_rounded,
            size: 14.sp,
            color: AppColors.accentGreen,
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
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.info_outline, size: 20.sp, color: AppColors.primary),
          ),
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
