import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Dark envelope + check badge hero for the check-email screen.
class CheckEmailIllustration extends StatelessWidget {
  const CheckEmailIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 108.w,
            height: 108.w,
            decoration: BoxDecoration(
              color: AppColors.mintGlow.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.mail_rounded,
              size: 38.sp,
              color: Colors.white,
            ),
          ),
          Transform.translate(
            offset: Offset(30.w, 28.h),
            child: Container(
              width: 26.w,
              height: 26.w,
              decoration: BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2.5),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 16.sp,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
