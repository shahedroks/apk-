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
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        item.imageColor,
                        Color.lerp(item.imageColor, Colors.black, 0.25)!,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.photo_outlined,
                      size: 32.sp,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                ),
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: _Badge(
                    text: item.badge,
                    showLiveDot: item.badge.toLowerCase() == 'available',
                  ),
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
                SizedBox(height: 6.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.w,
                      margin: EdgeInsets.only(top: 2.h),
                      decoration: const BoxDecoration(
                        color: AppColors.accentLime,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.swap_horiz_rounded,
                        size: 10.sp,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${HomeStrings.wants}: ',
                              style: AppTextStyles.caption(fontSize: 10.sp)
                                  .copyWith(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w600,
                                height: 1.35,
                              ),
                            ),
                            TextSpan(
                              text: item.wants,
                              style: AppTextStyles.caption(fontSize: 10.sp)
                                  .copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  '${item.location} • ${item.postedAgo}',
                  style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (showProposeButton) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    height: 34.h,
                    child: FilledButton.icon(
                      onPressed: onProposeTap ?? onTap,
                      icon: Icon(
                        Icons.swap_horiz_rounded,
                        size: 16.sp,
                        color: AppColors.primaryDark,
                      ),
                      label: Text(
                        HomeStrings.proposeSwap,
                        style: AppTextStyles.label(fontSize: 11.sp).copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accentLime,
                        foregroundColor: AppColors.primaryDark,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
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
  const _Badge({required this.text, this.showLiveDot = false});

  final String text;
  final bool showLiveDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLiveDot) ...[
            Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Text(
            text,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
