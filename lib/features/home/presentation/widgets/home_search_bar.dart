import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                Icon(Icons.search, size: 18.sp, color: AppColors.textSecondary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    HomeStrings.searchHint,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Icon(
            Icons.tune_rounded,
            size: 20.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
