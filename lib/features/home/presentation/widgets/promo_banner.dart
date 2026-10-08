import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.mintGlow.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.accentLime.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    HomeStrings.circularExchange,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  HomeStrings.promoBody,
                  style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.recycling_rounded,
            size: 40.sp,
            color: AppColors.primary.withValues(alpha: 0.35),
          ),
        ],
      ),
        ),
      ),
    );
  }
}
