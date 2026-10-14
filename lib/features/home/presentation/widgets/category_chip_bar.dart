import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';

enum CategoryChipStyle { bordered, discover }

class CategoryChipBar extends StatelessWidget {
  const CategoryChipBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.style = CategoryChipStyle.bordered,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final CategoryChipStyle style;

  @override
  Widget build(BuildContext context) {
    final discover = style == CategoryChipStyle.discover;

    final chipHeight = discover ? 34.h : 30.h;
    final barHeight = discover ? 42.h : 36.h;
    final verticalInset = (barHeight - chipHeight) / 2;

    return SizedBox(
      height: barHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.only(
          right: 8.w,
          top: verticalInset,
          bottom: verticalInset,
        ),
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: discover ? 4.w : 8.w),
        itemBuilder: (context, index) {
          final isActive = index == selectedIndex;
          final activeColor =
              discover ? AppColors.primaryDark : AppColors.primary;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              height: chipHeight,
              padding: EdgeInsets.symmetric(
                horizontal: discover ? 16.w : 14.w,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive
                    ? activeColor
                    : (discover ? AppColors.infoBackground : AppColors.surface),
                borderRadius: BorderRadius.circular(999.r),
                border: discover
                    ? null
                    : Border.all(
                        color: isActive ? activeColor : AppColors.borderLight,
                      ),
                boxShadow: discover && isActive
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                labels[index],
                style: AppTextStyles.label(fontSize: discover ? 13.sp : 12.sp)
                    .copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  height: discover ? 18 / 13 : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}