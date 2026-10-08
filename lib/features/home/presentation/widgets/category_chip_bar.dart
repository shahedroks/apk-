import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

class CategoryChipBar extends StatelessWidget {
  const CategoryChipBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isActive = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isActive ? AppColors.textPrimary : AppColors.surface,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(
                  color: isActive ? AppColors.textPrimary : AppColors.borderLight,
                ),
              ),
              child: Text(
                labels[index],
                style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
