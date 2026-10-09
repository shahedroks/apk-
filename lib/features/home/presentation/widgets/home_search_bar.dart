import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    this.hint,
    this.showFilterButton = true,
    this.useWhiteField = false,
    this.discoverStyle = false,
  });

  final String? hint;
  final bool showFilterButton;
  final bool useWhiteField;
  /// Discover: #EFF4FF field + matching filter tile (no white border).
  final bool discoverStyle;

  @override
  Widget build(BuildContext context) {
    final fieldColor =
        useWhiteField ? AppColors.surface : AppColors.infoBackground;
    final shadowColor = useWhiteField
        ? AppColors.primary.withValues(alpha: 0.04)
        : Colors.black.withValues(alpha: 0.05);
    final filterColor = discoverStyle ? AppColors.infoBackground : AppColors.surface;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: useWhiteField ? 12 : 2,
                  offset: Offset(0, useWhiteField ? 2 : 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 18.sp, color: AppColors.textSecondary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    hint ?? HomeStrings.searchHint,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.subtitle(
                      fontSize: useWhiteField || discoverStyle ? 14.sp : 13.sp,
                    ).copyWith(
                      color: useWhiteField || discoverStyle
                          ? AppColors.textMuted
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showFilterButton) ...[
          SizedBox(width: 8.w),
          Material(
            color: filterColor,
            borderRadius: BorderRadius.circular(12.r),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {},
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: discoverStyle
                      ? null
                      : Border.all(color: AppColors.borderLight),
                  boxShadow: discoverStyle
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  Icons.tune_rounded,
                  size: 16.5.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
