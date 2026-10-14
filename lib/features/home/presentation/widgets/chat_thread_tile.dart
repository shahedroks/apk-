import 'package:cached_network_image/cached_network_image.dart';
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

  static const _titleColor = Color(0xFF121C2A);
  static const _chipGreen = Color(0xFF0A2E22);

  @override
  Widget build(BuildContext context) {
    final isRecent = thread.timeAgo.contains('m ago');

    return Padding(
      padding: EdgeInsets.only(bottom: thread.unreadCount > 0 ? 10.h : 4.h),
      child: Material(
        color: AppColors.surface,
        elevation: 0,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _UserAvatar(thread: thread),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      thread.userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.label(fontSize: 18.sp)
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _titleColor,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  if (thread.isVerified) ...[
                                    SizedBox(width: 6.w),
                                    Icon(
                                      Icons.verified_rounded,
                                      size: 15.sp,
                                      color: _chipGreen,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Text(
                              thread.timeAgo,
                              style: AppTextStyles.caption(fontSize: 10.sp)
                                  .copyWith(
                                fontWeight: FontWeight.w700,
                                color: isRecent
                                    ? AppColors.accentGreen
                                    : AppColors.textMuted,
                                height: 1.2,
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
                            color: _titleColor,
                            height: 1.25,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.fromLTRB(8.w, 2.h, 8.w, 2.h),
                          decoration: BoxDecoration(
                            color: AppColors.infoBackground,
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.swap_horiz_rounded,
                                size: 11.sp,
                                color: _chipGreen,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                thread.itemTitle,
                                style: AppTextStyles.caption(fontSize: 10.sp)
                                    .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: _chipGreen,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  _ItemThumbnailWithBadge(thread: thread),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: thread.avatarUrl != null
                ? CachedNetworkImage(
                    imageUrl: thread.avatarUrl!,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        _AvatarFallback(thread: thread),
                    errorWidget: (context, url, error) =>
                        _AvatarFallback(thread: thread),
                  )
                : _AvatarFallback(thread: thread),
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

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.thread});

  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.w,
      color: thread.avatarColor,
      child: Icon(
        Icons.person_rounded,
        size: 28.sp,
        color: AppColors.primary.withValues(alpha: 0.35),
      ),
    );
  }
}

class _ItemThumbnailWithBadge extends StatelessWidget {
  const _ItemThumbnailWithBadge({required this.thread});

  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      height: 48.w,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: thread.itemImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: thread.itemImageUrl!,
                    width: 48.w,
                    height: 48.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        _ItemPlaceholder(color: thread.itemColor),
                    errorWidget: (context, url, error) =>
                        _ItemPlaceholder(color: thread.itemColor),
                  )
                : _ItemPlaceholder(color: thread.itemColor),
          ),
          if (thread.unreadCount > 0)
            Positioned(
              bottom: -6.h,
              child: Container(
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
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: ChatThreadTile._chipGreen,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ItemPlaceholder extends StatelessWidget {
  const _ItemPlaceholder({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
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
          color: color.withValues(alpha: 0.45),
          size: 22.sp,
        ),
      ),
    );
  }
}
