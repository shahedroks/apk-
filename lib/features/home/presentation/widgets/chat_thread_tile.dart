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
    final isRecent = thread.timeAgo.contains('m ago');

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Material(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _UserAvatar(thread: thread),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      thread.userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.label(fontSize: 18.sp)
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF121C2A),
                                      ),
                                    ),
                                  ),
                                  if (thread.isVerified) ...[
                                    SizedBox(width: 6.w),
                                    Icon(
                                      Icons.verified_rounded,
                                      size: 15.sp,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              thread.timeAgo,
                              style: AppTextStyles.caption(fontSize: 10.sp)
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                                color: isRecent
                                    ? AppColors.accentGreen
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          thread.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.subtitle(fontSize: 14.sp)
                              .copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF121C2A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.swap_horiz_rounded,
                                size: 11.sp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                thread.itemTitle,
                                style: AppTextStyles.caption(fontSize: 10.sp)
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _ItemThumbnail(color: thread.itemColor),
                      if (thread.unreadCount > 0) ...[
                        SizedBox(height: 4.h),
                        Container(
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.accentLime,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(
                            '${thread.unreadCount}',
                            style: AppTextStyles.caption(fontSize: 10.sp)
                                .copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.thread});

  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      height: 48.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: thread.avatarColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              size: 28.sp,
              color: AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          if (thread.isOnline)
            Positioned(
              right: -2.w,
              bottom: -2.h,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ItemThumbnail extends StatelessWidget {
  const _ItemThumbnail({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              Color.lerp(color, Colors.black, 0.18)!,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SizedBox(
          width: 48.w,
          height: 48.w,
          child: Icon(
            Icons.photo_outlined,
            color: Colors.white.withValues(alpha: 0.45),
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
