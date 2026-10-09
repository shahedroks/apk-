import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  static const Color _bannerGreen = Color(0xFFCAEAD6);
  static const Color _headlineGreen = Color(0xFF072317);
  static const Color _bodyGreen = Color(0xFF314D3E);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: _bannerGreen,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Icon(
                  Icons.auto_awesome,
                  size: 33.sp,
                  color: AppColors.accentLime,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.accentLime,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.eco_outlined,
                          size: 10.sp,
                          color: const Color(0xFF102000),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          HomeStrings.circularExchange,
                          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                            color: const Color(0xFF102000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    HomeStrings.promoHeadline,
                    style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: _headlineGreen,
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    HomeStrings.promoBody,
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w400,
                      color: _bodyGreen,
                      height: 23 / 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
