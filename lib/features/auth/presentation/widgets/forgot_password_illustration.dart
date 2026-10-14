import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Layered envelope + key hero (matches `doc/auto.md` forgot-password art).
class ForgotPasswordIllustration extends StatelessWidget {
  const ForgotPasswordIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112.h,
      child: Center(
        child: SizedBox(
          width: 80.w,
          height: 80.w,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: -8.w,
                top: -8.w,
                child: Container(
                  width: 96.w,
                  height: 96.w,
                  decoration: BoxDecoration(
                    color: AppColors.mintGlow.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.mintGlow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            size: 22.sp,
                            color: AppColors.accentLime,
                          ),
                        ),
                        Positioned(
                          right: 6.w,
                          top: 6.h,
                          child: Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: const BoxDecoration(
                              color: AppColors.accentLime,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              size: 10.sp,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -4.w,
                bottom: -4.w,
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.vpn_key_rounded,
                    size: 14.sp,
                    color: AppColors.primaryDark,
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
