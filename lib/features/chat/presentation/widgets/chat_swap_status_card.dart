import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/chat_strings.dart';
import '../../../../core/theme/text_styles.dart';

class ChatSwapStatusCard extends StatelessWidget {
  const ChatSwapStatusCard({super.key, this.onDetailsTap});

  final VoidCallback? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        ChatStrings.swapInProgress,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.accentGreen,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onDetailsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ChatStrings.details,
                      style: AppTextStyles.label(fontSize: 11.sp).copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 10.sp,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _SwapSide(
                    label: ChatStrings.youOffer,
                    title: ChatStrings.yourKeyboard,
                    color: const Color(0xFF5C6BC0),
                  ),
                ),
                Container(
                  width: 32.w,
                  height: 32.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: const BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    size: 18.sp,
                    color: AppColors.primaryDark,
                  ),
                ),
                Expanded(
                  child: _SwapSide(
                    label: ChatStrings.partnerName,
                    title: ChatStrings.partnerItem,
                    color: const Color(0xFF37474F),
                    alignEnd: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapSide extends StatelessWidget {
  const _SwapSide({
    required this.label,
    required this.title,
    required this.color,
    this.alignEnd = false,
  });

  final String label;
  final String title;
  final Color color;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: ColoredBox(
            color: color,
            child: SizedBox(
              width: 48.w,
              height: 48.w,
              child: Icon(
                Icons.inventory_2_outlined,
                color: Colors.white.withValues(alpha: 0.85),
                size: 22.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          title,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.label(fontSize: 11.sp),
        ),
      ],
    );
  }
}
