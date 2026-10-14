import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/chat_strings.dart';
import '../../../../core/theme/text_styles.dart';

class ChatSwapStatusCard extends StatelessWidget {
  const ChatSwapStatusCard({super.key, this.onDetailsTap});

  final VoidCallback? onDetailsTap;

  static const Color _cardBlue = Color(0xFFEFF4FF);
  static const Color _thumbWash = Color(0xFFE6EEFF);
  static const Color _statusGreen = Color(0xFF457000);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _cardBlue,
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
                    Text(
                      ChatStrings.swapInProgress,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: _statusGreen,
                        letterSpacing: 0.25,
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
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 12.sp,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
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
                  child: _SwapSideRow(
                    label: ChatStrings.youOffer,
                    title: ChatStrings.yourKeyboard,
                    imageUrl: ChatStrings.youOfferImageUrl,
                    thumbWash: _thumbWash,
                    mirror: false,
                  ),
                ),
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    size: 18.sp,
                    color: AppColors.primaryDark,
                  ),
                ),
                Expanded(
                  child: _SwapSideRow(
                    label: ChatStrings.partnerName,
                    title: ChatStrings.partnerItem,
                    imageUrl: ChatStrings.partnerItemImageUrl,
                    thumbWash: _thumbWash,
                    mirror: true,
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

class _SwapSideRow extends StatelessWidget {
  const _SwapSideRow({
    required this.label,
    required this.title,
    required this.imageUrl,
    required this.thumbWash,
    required this.mirror,
  });

  final String label;
  final String title;
  final String imageUrl;
  final Color thumbWash;
  final bool mirror;

  @override
  Widget build(BuildContext context) {
    final thumb = _ItemThumb(imageUrl: imageUrl, wash: thumbWash);
    final copy = Expanded(
      child: Column(
        crossAxisAlignment:
            mirror ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            title,
            textAlign: mirror ? TextAlign.right : TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF121C2A),
              height: 1.35,
            ),
          ),
        ],
      ),
    );

    return Row(
      children: mirror
          ? [copy, SizedBox(width: 8.w), thumb]
          : [thumb, SizedBox(width: 8.w), copy],
    );
  }
}

class _ItemThumb extends StatelessWidget {
  const _ItemThumb({required this.imageUrl, required this.wash});

  final String imageUrl;
  final Color wash;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: ColoredBox(
        color: wash,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 48.w,
          height: 48.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => SizedBox(
            width: 48.w,
            height: 48.w,
            child: Icon(
              Icons.image_outlined,
              size: 22.sp,
              color: AppColors.textMuted.withValues(alpha: 0.45),
            ),
          ),
          errorWidget: (context, url, error) => SizedBox(
            width: 48.w,
            height: 48.w,
            child: Icon(
              Icons.image_outlined,
              size: 22.sp,
              color: AppColors.textMuted.withValues(alpha: 0.45),
            ),
          ),
        ),
      ),
    );
  }
}
