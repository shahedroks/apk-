import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';

class SwapBrandHeader extends StatelessWidget {
  const SwapBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.accentLime,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.swap_horiz_rounded,
            size: 28.sp,
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          AppStrings.appName,
          style: AppTextStyles.brandTitle(fontSize: 18.sp),
        ),
      ],
    );
  }
}
