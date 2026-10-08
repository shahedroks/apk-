import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/models/swap_listing.dart';

class ChatThreadTile extends StatelessWidget {
  const ChatThreadTile({
    super.key,
    required this.thread,
    this.onTap,
  });

  final ChatThread thread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.infoBackground,
                child: Text(
                  thread.userName.substring(0, 1),
                  style: AppTextStyles.label(fontSize: 14.sp),
                ),
              ),
              if (thread.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppColors.accentLime,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                  ),
                ),
            ],
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
                        thread.userName,
                        style: AppTextStyles.label(fontSize: 14.sp),
                      ),
                    ),
                    Text(
                      thread.timeAgo,
                      style: AppTextStyles.caption(fontSize: 10.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  thread.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subtitle(fontSize: 12.sp).copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    thread.itemTitle,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ColoredBox(
              color: thread.itemColor,
              child: SizedBox(
                width: 44.w,
                height: 44.w,
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 20.sp,
                ),
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
