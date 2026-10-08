import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/models/swap_listing.dart';

class ItemGridCard extends StatelessWidget {
  const ItemGridCard({
    super.key,
    required this.item,
    this.showProposeButton = false,
    this.filledHeart = false,
    this.onTap,
    this.onProposeTap,
  });

  final SwapListing item;
  final bool showProposeButton;
  final bool filledHeart;
  final VoidCallback? onTap;
  final VoidCallback? onProposeTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: item.imageColor),
                Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 36.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: _Badge(text: item.badge),
                ),
                Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      filledHeart ? Icons.favorite : Icons.favorite_border,
                      size: 16.sp,
                      color: filledHeart
                          ? AppColors.accentLime
                          : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label(fontSize: 13.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${HomeStrings.wants}: ${item.wants}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${item.location} • ${item.postedAgo}',
                  style: AppTextStyles.caption(fontSize: 10.sp),
                ),
                if (showProposeButton) ...[
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 36.h,
                    child: FilledButton(
                      onPressed: onProposeTap ?? onTap,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accentLime,
                        foregroundColor: AppColors.primaryDark,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        HomeStrings.proposeSwap,
                        style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
