import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/extra_mock_data.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Text(
        label,
        style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    this.onAction,
  });

  final AppNotification notification;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: notification.iconBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(notification.icon, size: 20.sp, color: AppColors.primaryDark),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTextStyles.label(fontSize: 14.sp),
                      ),
                    ),
                    if (notification.badge != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.accentLime,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          notification.badge!,
                          style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.body,
                  style: AppTextStyles.subtitle(fontSize: 12.sp).copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (notification.action != null) ...[
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: onAction,
                    child: Text(
                      notification.action!,
                      style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewItem review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                child: Text(review.userName.substring(0, 1)),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.userName, style: AppTextStyles.label(fontSize: 14.sp)),
                    Text(
                      'Verified Swapper',
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text('${review.rating}', style: AppTextStyles.label(fontSize: 13.sp)),
              Icon(Icons.star, size: 16.sp, color: Colors.amber),
              SizedBox(width: 6.w),
              Text(review.timeAgo, style: AppTextStyles.caption(fontSize: 10.sp)),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(review.tradeBadge, style: AppTextStyles.caption(fontSize: 10.sp)),
          ),
          SizedBox(height: 8.h),
          Text(review.body, style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(height: 1.35)),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: review.traits
                .map(
                  (t) => Chip(
                    label: Text(t, style: AppTextStyles.caption(fontSize: 10.sp)),
                    backgroundColor: AppColors.infoBackground,
                    side: const BorderSide(color: AppColors.infoBorder),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class HorizontalFilterChips extends StatelessWidget {
  const HorizontalFilterChips({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.darkSelected = false,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool darkSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final active = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: active
                    ? (darkSelected ? AppColors.textPrimary : AppColors.primaryDark)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Text(
                labels[index],
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
