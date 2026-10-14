import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/models/swap_listing.dart';

enum ItemWantsStyle { discover, savedPill }

class ItemGridCard extends StatelessWidget {
  const ItemGridCard({
    super.key,
    required this.item,
    this.showProposeButton = false,
    this.filledHeart = false,
    this.wantsStyle = ItemWantsStyle.discover,
    this.onTap,
    this.onProposeTap,
  });

  final SwapListing item;
  final bool showProposeButton;
  final bool filledHeart;
  final ItemWantsStyle wantsStyle;
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
                    _ListingPhoto(item: item),
                    Positioned(
                      left: 8.w,
                      top: 8.h,
                      child: _ConditionBadge(
                        text: item.badge,
                        style: item.badgeStyle,
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          filledHeart ? Icons.favorite : Icons.favorite_border,
                          size: 15.sp,
                          color: filledHeart
                              ? AppColors.accentLime
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _WantsRow(wants: item.wants, style: wantsStyle),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 9.sp,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            '${item.location} • ${item.postedAgo}',
                            style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (showProposeButton) ...[
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: double.infinity,
                        height: 26.h,
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

class _WantsRow extends StatelessWidget {
  const _WantsRow({required this.wants, required this.style});

  final String wants;
  final ItemWantsStyle style;

  @override
  Widget build(BuildContext context) {
    final label = '${HomeStrings.wants}: $wants';

    if (style == ItemWantsStyle.savedPill) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: const Color(0xFFCAEAD6).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.swap_horiz_rounded,
              size: 11.sp,
              color: AppColors.primaryDark,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  color: const Color(0xFF314D3E),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            Icons.swap_horiz_rounded,
            size: 10.sp,
            color: AppColors.accentGreen,
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              color: AppColors.accentGreen,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ListingPhoto extends StatelessWidget {
  const _ListingPhoto({required this.item});

  final SwapListing item;

  @override
  Widget build(BuildContext context) {
    final url = item.imageUrl;
    if (url == null || url.isEmpty) {
      return _placeholder();
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, _) => _placeholder(loading: true),
      errorWidget: (_, _, _) => _placeholder(),
    );
  }

  Widget _placeholder({bool loading = false}) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.borderLight),
      child: Center(
        child: loading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                Icons.photo_outlined,
                size: 32.sp,
                color: AppColors.textMuted.withValues(alpha: 0.35),
              ),
      ),
    );
  }
}

class _ConditionBadge extends StatelessWidget {
  const _ConditionBadge({required this.text, required this.style});

  final String text;
  final ListingBadgeStyle style;

  @override
  Widget build(BuildContext context) {
    final available = style == ListingBadgeStyle.available;
    final solid = style == ListingBadgeStyle.categorySolid;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: available
            ? Colors.white.withValues(alpha: 0.9)
            : solid
                ? AppColors.accentGreen
                : AppColors.primaryDark.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(999.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (available) ...[
            Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: available ? AppColors.primaryDark : Colors.white,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
