import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';

/// Back control + ACCOUNT SECURITY chip (forgot / check-email flows).
class AuthSecurityHeader extends StatelessWidget {
  const AuthSecurityHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: AppColors.infoBackground,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onBack,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: AppColors.accentGreen,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          AppStrings.accountSecurity,
          style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
            letterSpacing: 0.8,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
