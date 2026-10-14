import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
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
        style: AppTextStyles.overline(
          fontSize: 10.sp,
        ).copyWith(color: AppColors.textMuted),
      ),
    );
  }
}

class NotificationSectionHeader extends StatelessWidget {
  const NotificationSectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.325,
              color: AppColors.primaryDark,
            ),
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing!,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

class NotificationFilterChips extends StatelessWidget {
  const NotificationFilterChips({
    super.key,
    required this.labels,
    required this.counts,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final List<int?> counts;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _chipIcons = <IconData?>[
    null,
    Icons.swap_horiz_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.notifications_none_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final active = index == selectedIndex;
          final count = counts.length > index ? counts[index] : null;
          final icon = index < _chipIcons.length ? _chipIcons[index] : null;
          final labelColor = active ? Colors.white : AppColors.textSecondary;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              height: 26.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.primaryDark : AppColors.borderLight,
                borderRadius: BorderRadius.circular(999.r),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 12.sp, color: labelColor),
                    SizedBox(width: 6.w),
                  ],
                  Text(
                    labels[index],
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      height: 14 / 11,
                      color: labelColor,
                    ),
                  ),
                  if (active && count != null) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      constraints: BoxConstraints(minHeight: 13.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        '$count',
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 12 / 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
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

  static const _unreadAccent = Color(0xFF91DB2A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            if (notification.unread)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 4.w, color: _unreadAccent),
              ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NotificationIcon(notification: notification),
                  SizedBox(width: 16.w),
                  Expanded(child: _NotificationContent(notification: notification, onAction: onAction)),
                ],
              ),
            ),
            if (notification.unread)
              Positioned(
                right: 14.w,
                top: 16.h,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: _unreadAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: notification.iconBackground,
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Icon(
            notification.icon,
            size: 20.sp,
            color: notification.iconOnDark ? Colors.white : notification.iconColor,
          ),
        ),
        if (notification.showMatchIconBadge)
          Positioned(
            right: -4.w,
            bottom: -4.h,
            child: Container(
              width: 16.w,
              height: 16.w,
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.favorite, size: 8.sp, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.notification,
    this.onAction,
  });

  final AppNotification notification;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (notification.style == NotificationCardStyle.message)
          _MessageHeader(notification: notification)
        else if (notification.categoryChip != null)
          _MetaRow(notification: notification),
        if (notification.style == NotificationCardStyle.message)
          _MessageBody(notification: notification)
        else ...[
          Text(
            notification.body,
            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
              fontWeight: FontWeight.w700,
              height: 1.43,
              color: AppColors.primaryDark,
            ),
          ),
        ],
        if (notification.starRating != null) ...[
          SizedBox(height: 10.h),
          Row(
            children: [
              ...List.generate(
                notification.starRating!,
                (_) => Icon(Icons.star, size: 15.sp, color: AppColors.accentGreen),
              ),
              if (notification.action != null) ...[
                SizedBox(width: 6.w),
                GestureDetector(
                  onTap: onAction,
                  child: Text(
                    notification.action!,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ] else if (notification.ecoTier != null) ...[
          SizedBox(height: 10.h),
          _EcoProgressRow(
            tier: notification.ecoTier!,
            points: notification.ecoPoints ?? '',
          ),
        ] else if (notification.action != null) ...[
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.infoBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (notification.actionShowsMapPin) ...[
                    Icon(Icons.location_on_outlined, size: 10.sp, color: AppColors.primaryDark),
                    SizedBox(width: 4.w),
                  ],
                  Text(
                    notification.action!,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  if (notification.actionShowsArrow) ...[
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward, size: 9.sp, color: AppColors.primaryDark),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final chip = notification.categoryChip!;
    Color chipBg;
    Color chipFg;
    FontWeight chipWeight;

    switch (notification.style) {
      case NotificationCardStyle.match:
        chipBg = AppColors.accentLime.withValues(alpha: 0.4);
        chipFg = const Color(0xFF304F00);
        chipWeight = FontWeight.w700;
      case NotificationCardStyle.meetup:
        chipBg = AppColors.primaryDark.withValues(alpha: 0.1);
        chipFg = AppColors.primaryDark;
        chipWeight = FontWeight.w600;
      case NotificationCardStyle.swapCompleted:
        chipBg = const Color(0x99CAEAD6);
        chipFg = const Color(0xFF314D3E);
        chipWeight = FontWeight.w700;
      case NotificationCardStyle.eco:
        chipBg = AppColors.accentLime.withValues(alpha: 0.3);
        chipFg = const Color(0xFF102000);
        chipWeight = FontWeight.w700;
      case NotificationCardStyle.message:
        chipBg = AppColors.borderLight;
        chipFg = AppColors.textSecondary;
        chipWeight = FontWeight.w600;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              chip,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: chipWeight,
                color: chipFg,
              ),
            ),
          ),
          if (notification.timeAgo != null) ...[
            SizedBox(width: 6.w),
            Text(
              notification.timeAgo!,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageHeader extends StatelessWidget {
  const _MessageHeader({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Text(
            notification.senderName ?? '',
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
          const Spacer(),
          if (notification.timeAgo != null)
            Text(
              notification.timeAgo!,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

class _MessageBody extends StatelessWidget {
  const _MessageBody({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (notification.messageLine != null)
          Text(
            notification.messageLine!,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        if (notification.quote != null) ...[
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              notification.quote!,
              style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                fontStyle: FontStyle.italic,
                height: 1.54,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _EcoProgressRow extends StatelessWidget {
  const _EcoProgressRow({required this.tier, required this.points});

  final String tier;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Text(
              '2',
              style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              tier,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          Text(
            points,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewsSummaryCard extends StatelessWidget {
  const ReviewsSummaryCard({super.key});

  static const _starColor = Color(0xFF91DB2A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '4.9',
                          style: AppTextStyles.screenTitle(fontSize: 36.sp).copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.9,
                            color: AppColors.primaryDark,
                            height: 1.22,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          ExtraStrings.ratingOutOf,
                          style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: List.generate(
                        5,
                        (_) => Icon(Icons.star, size: 15.sp, color: _starColor),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      ExtraStrings.ratingBased,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Column(
                    children: [5, 4, 3, 2, 1].map((star) {
                      final fraction = ExtraMockData.ratingDistribution[star] ?? 0;
                      final pct = (fraction * 100).round();
                      return Padding(
                        padding: EdgeInsets.only(bottom: star == 1 ? 0 : 6.h),
                        child: _RatingBarRow(
                          star: star,
                          fraction: fraction,
                          percentLabel: '$pct%',
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -32.w,
            top: -32.h,
            child: Container(
              width: 112.w,
              height: 112.w,
              decoration: BoxDecoration(
                color: AppColors.accentLime.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({
    required this.star,
    required this.fraction,
    required this.percentLabel,
  });

  final int star;
  final double fraction;
  final String percentLabel;

  Color _fillForStar(int star, double fraction) {
    if (fraction <= 0) return AppColors.primary;
    if (star >= 5) return AppColors.primary;
    if (star == 4) return AppColors.primary.withValues(alpha: 0.6);
    return AppColors.primary.withValues(alpha: 0.35);
  }

  @override
  Widget build(BuildContext context) {
    final hasFill = fraction > 0;

    return SizedBox(
      height: 12.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 12.w,
            child: Text(
              '$star',
              textAlign: TextAlign.right,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                height: 12 / 10,
                color: AppColors.textMuted,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999.r),
              child: SizedBox(
                height: 6.h,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.centerLeft,
                  children: [
                    const ColoredBox(color: AppColors.borderLight),
                    if (hasFill)
                      FractionallySizedBox(
                        widthFactor: fraction.clamp(0.0, 1.0),
                        child: ColoredBox(color: _fillForStar(star, fraction)),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          SizedBox(
            width: 24.w,
            child: Text(
              percentLabel,
              textAlign: TextAlign.right,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                height: 12 / 10,
                color: hasFill ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewFilterChips extends StatelessWidget {
  const ReviewFilterChips({
    super.key,
    required this.labels,
    required this.counts,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final List<int?> counts;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final active = index == selectedIndex;
          final count = counts.length > index ? counts[index] : null;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              height: 26.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.primaryDark : AppColors.surface,
                borderRadius: BorderRadius.circular(999.r),
                border: active ? null : Border.all(color: AppColors.borderLight),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index == 1)
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Icon(
                        Icons.memory_outlined,
                        size: 12.sp,
                        color: active ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  if (index == 2)
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Icon(
                        Icons.local_florist_outlined,
                        size: 12.sp,
                        color: active ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  Text(
                    labels[index],
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  if (active && count != null) ...[
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        '$count',
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF457000),
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReviewTrustBanner extends StatelessWidget {
  const ReviewTrustBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shield_outlined, size: 14.sp, color: const Color(0xFF457000)),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ExtraStrings.verifiedTrust,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentLime,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  ExtraStrings.verifiedTrustBody,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                    color: const Color(0xFF79A694),
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

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewItem review;

  static const _starColor = Color(0xFF91DB2A);
  static const _tagBg = Color(0xFFDEE9FC);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: review.avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: review.avatarUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => const ColoredBox(color: AppColors.borderLight),
                          errorWidget: (_, _, _) => ColoredBox(
                            color: AppColors.borderLight,
                            child: Center(
                              child: Text(
                                review.userName.substring(0, 1),
                                style: AppTextStyles.label(fontSize: 16.sp),
                              ),
                            ),
                          ),
                        )
                      : ColoredBox(
                          color: AppColors.borderLight,
                          child: Center(
                            child: Text(
                              review.userName.substring(0, 1),
                              style: AppTextStyles.label(fontSize: 16.sp),
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            review.userName,
                            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.verified, size: 14.sp, color: AppColors.accentGreen),
                      ],
                    ),
                    Text(
                      ExtraStrings.verifiedSwapper,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(Icons.star, size: 13.sp, color: _starColor),
                    ],
                  ),
                  Text(
                    review.timeAgo,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.swap_horiz, size: 15.sp, color: AppColors.primaryDark),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: 'Traded '),
                        TextSpan(
                          text: review.tradeGiven,
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        ),
                        const TextSpan(text: ' for '),
                        TextSpan(
                          text: review.tradeReceived,
                          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            review.body,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              height: 1.62,
              color: AppColors.textSecondary,
            ),
          ),
          if (review.attachmentImageUrl != null) ...[
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 64.w,
                height: 64.w,
                child: CachedNetworkImage(
                  imageUrl: review.attachmentImageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => const ColoredBox(color: AppColors.borderLight),
                  errorWidget: (_, _, _) => ColoredBox(
                    color: AppColors.infoBackground,
                    child: Icon(Icons.image_outlined, size: 24.sp, color: AppColors.textMuted),
                  ),
                ),
              ),
            ),
          ],
          if (review.traits.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: review.traits.map((t) => _ReviewTraitChip(trait: t)).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReviewTraitChip extends StatelessWidget {
  const _ReviewTraitChip({required this.trait});

  final ReviewTrait trait;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ReviewCard._tagBg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(trait.icon, size: 10.sp, color: AppColors.textSecondary),
          SizedBox(width: 4.w),
          Text(
            trait.label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
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
                    ? (darkSelected
                          ? AppColors.textPrimary
                          : AppColors.primaryDark)
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
