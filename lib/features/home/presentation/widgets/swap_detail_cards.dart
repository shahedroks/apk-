import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/models/swap_listing.dart';

class CircularImpactCard extends StatelessWidget {
  const CircularImpactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
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
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.eco_outlined,
              size: 18.sp,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HomeStrings.circularImpactTrades,
                  style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
                    color: AppColors.accentLime,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  HomeStrings.impactStat,
                  style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
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

class SwapComparisonRow extends StatelessWidget {
  const SwapComparisonRow({
    super.key,
    required this.youGive,
    required this.youGet,
    this.mutedCenterIcon = false,
  });

  final SwapListing youGive;
  final SwapListing youGet;
  final bool mutedCenterIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _ItemThumb(
              label: HomeStrings.youGive,
              item: youGive,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 38.w),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: mutedCenterIcon
                    ? AppColors.infoBackground
                    : AppColors.accentLime,
                shape: BoxShape.circle,
                border: mutedCenterIcon
                    ? Border.all(color: AppColors.borderLight)
                    : null,
                boxShadow: mutedCenterIcon
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                          spreadRadius: -1,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                          spreadRadius: -2,
                        ),
                      ],
              ),
              child: Icon(
                Icons.swap_horiz_rounded,
                size: 16.sp,
                color: mutedCenterIcon
                    ? AppColors.textMuted
                    : AppColors.primaryDark,
              ),
            ),
          ),
          Expanded(
            child: _ItemThumb(
              label: HomeStrings.youGet,
              item: youGet,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemThumb extends StatelessWidget {
  const _ItemThumb({
    required this.label,
    required this.item,
  });

  final String label;
  final SwapListing item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: AspectRatio(
                aspectRatio: 1,
                child: _SwapItemPhoto(item: item),
              ),
            ),
            Positioned(
              left: 6.w,
              top: 6.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          item.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.label(fontSize: 11.sp).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (item.swapDetail != null) ...[
          SizedBox(height: 2.h),
          Text(
            item.swapDetail!,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
              color: AppColors.textSecondary,
              height: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}

class _SwapItemPhoto extends StatelessWidget {
  const _SwapItemPhoto({required this.item});

  final SwapListing item;

  @override
  Widget build(BuildContext context) {
    final url = item.imageUrl;
    if (url != null && url.isNotEmpty) {
      return ColoredBox(
        color: _SwapItemPhoto._itemImageBg,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => _placeholder(),
          errorWidget: (context, url, error) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  static const _itemImageBg = Color(0xFFE6EEFF);

  Widget _placeholder() {
    return ColoredBox(
      color: _itemImageBg,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.textMuted.withValues(alpha: 0.45),
          size: 28.sp,
        ),
      ),
    );
  }
}

class SwapProgressTimeline extends StatelessWidget {
  const SwapProgressTimeline({
    super.key,
    required this.completedSteps,
    required this.activeStep,
    this.stepDates = const [],
    this.stepSubtitles = const [],
  });

  final int completedSteps;
  final SwapProgressStep activeStep;
  final List<String> stepDates;
  final List<String?> stepSubtitles;

  @override
  Widget build(BuildContext context) {
    final steps = <_StepData>[
      _StepData(HomeStrings.stepProposed, SwapProgressStep.proposed),
      _StepData(HomeStrings.stepAccepted, SwapProgressStep.accepted),
      _StepData(HomeStrings.stepMeetup, SwapProgressStep.meetup),
      _StepData(HomeStrings.stepCompleted, SwapProgressStep.completed),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          HomeStrings.exchangeProgress,
          style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
            letterSpacing: 0.6,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isDone = index < completedSteps;
          final isActive = step.step == activeStep;
          final isLast = index == steps.length - 1;
          final date = index < stepDates.length ? stepDates[index] : '';
          final sub = index < stepSubtitles.length ? stepSubtitles[index] : null;
          final showSubtitle = sub != null && (isDone || isActive);
          final locationPin = isActive && step.step == SwapProgressStep.meetup;

          return _TimelineRow(
            title: step.title,
            subtitle: showSubtitle ? sub : null,
            showLocationPin: locationPin,
            dateLabel: date,
            isDone: isDone,
            isActive: isActive,
            showLine: !isLast,
          );
        }),
      ],
    );
  }
}

class _StepData {
  const _StepData(this.title, this.step);
  final String title;
  final SwapProgressStep step;
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.title,
    required this.dateLabel,
    required this.isDone,
    required this.isActive,
    required this.showLine,
    this.subtitle,
    this.showLocationPin = false,
  });

  final String title;
  final String? subtitle;
  final bool showLocationPin;
  final String dateLabel;
  final bool isDone;
  final bool isActive;
  final bool showLine;

  Widget _stepIndicator() {
    if (isDone) {
      return Container(
        width: 20.w,
        height: 20.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: RoundedCheckMark(
          size: 10.w,
          color: Colors.white,
          strokeWidth: 1.8.w,
        ),
      );
    }
    if (isActive) {
      return Container(
        width: 20.w,
        height: 20.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.accentLime,
          shape: BoxShape.circle,
        ),
        child: Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: AppColors.primaryDark,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Container(
      width: 20.w,
      height: 20.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Container(
        width: 6.w,
        height: 6.w,
        decoration: BoxDecoration(
          color: AppColors.textMuted.withValues(alpha: 0.45),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _stepIndicator(),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: isDone
                        ? AppColors.primary.withValues(alpha: 0.35)
                        : AppColors.borderLight,
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLine ? 14.h : 0, top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.subtitle(
                            fontSize: isActive ? 13.sp : 12.sp,
                          ).copyWith(
                            fontWeight:
                                isActive || isDone ? FontWeight.w700 : FontWeight.w500,
                            color: isActive || isDone
                                ? AppColors.primaryDark
                                : AppColors.textMuted,
                          ),
                        ),
                      ),
                      if (dateLabel.isNotEmpty)
                        Text(
                          dateLabel,
                          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                            color: isActive
                                ? AppColors.accentGreen
                                : AppColors.textMuted,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        if (showLocationPin) ...[
                          Icon(
                            Icons.location_on_outlined,
                            size: 11.sp,
                            color: AppColors.accentGreen,
                          ),
                          SizedBox(width: 4.w),
                        ],
                        Expanded(
                          child: Text(
                            subtitle!,
                            style: AppTextStyles.caption(fontSize: 11.sp)
                                .copyWith(
                              color: showLocationPin
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveSwapCard extends StatelessWidget {
  const ActiveSwapCard({super.key, required this.swap});

  final ActiveSwap swap;

  @override
  Widget build(BuildContext context) {
    final awaiting = swap.statusLabel.toLowerCase().contains('awaiting');

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: AppColors.borderLight,
                    backgroundImage: swap.partnerAvatarUrl != null
                        ? CachedNetworkImageProvider(swap.partnerAvatarUrl!)
                        : null,
                    child: swap.partnerAvatarUrl == null
                        ? Icon(Icons.person, size: 22.sp, color: AppColors.textMuted)
                        : null,
                  ),
                  if (!swap.needsReview)
                    Positioned(
                      right: -2.w,
                      bottom: -2.h,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surface, width: 2),
                        ),
                        child: RoundedCheckMark(
                          size: 8.w,
                          color: Colors.white,
                          strokeWidth: 1.4.w,
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
                        Flexible(
                          child: Text(
                            swap.partnerName,
                            style: AppTextStyles.label(fontSize: 15.sp).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (swap.isPro) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentLime,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'PRO',
                              style: AppTextStyles.caption(fontSize: 9.sp)
                                  .copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      swap.partnerSubtitle ??
                          '★ ${swap.partnerRating.toStringAsFixed(1)}',
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: awaiting
                      ? AppColors.infoBackground
                      : AppColors.mintGlow.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!awaiting) ...[
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          color: AppColors.accentGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      swap.statusLabel,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: awaiting
                            ? AppColors.textSecondary
                            : AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          SwapComparisonRow(
            youGive: swap.youGive,
            youGet: swap.youGet,
            mutedCenterIcon: swap.needsReview,
          ),
          SizedBox(height: 14.h),
          if (!swap.needsReview)
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 12.h),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SwapProgressTimeline(
                completedSteps: swap.completedSteps,
                activeStep: swap.activeStep,
                stepDates: swap.stepDates,
                stepSubtitles: swap.stepSubtitles,
              ),
            ),
          if (!swap.needsReview) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: FilledButton.icon(
                      onPressed: () => context.push(
                        AppRouter.chat('c1', name: swap.partnerName),
                      ),
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        size: 15.sp,
                        color: AppColors.textPrimary,
                      ),
                      label: Text(
                        HomeStrings.openChat,
                        style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.borderLight,
                        foregroundColor: AppColors.textPrimary,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: FilledButton.icon(
                      onPressed: () => context.push(AppRouter.swapCompleted),
                      icon: RoundedCheckMark(
                        size: 15.w,
                        color: Colors.white,
                        strokeWidth: 2.2.w,
                      ),
                      label: Text(
                        HomeStrings.confirmSwap,
                        style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (swap.needsReview) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    swap.reviewStepLabel ?? '',
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  HomeStrings.actionNeeded,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: FilledButton.icon(
                onPressed: () => context.push(
                  AppRouter.incomingSwapOffer('1', reviewTitle: true),
                ),
                icon: Icon(
                  Icons.description_outlined,
                  size: 18.sp,
                  color: AppColors.primaryDark,
                ),
                label: Text(
                  HomeStrings.reviewOffer,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accentLime,
                  foregroundColor: AppColors.primaryDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Check mark with rounded stroke caps (timeline, badges, Confirm Swap).
class RoundedCheckMark extends StatelessWidget {
  const RoundedCheckMark({
    super.key,
    required this.size,
    required this.color,
    this.strokeWidth,
  });

  final double size;
  final Color color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _RoundedCheckPainter(
        color: color,
        strokeWidth: strokeWidth ?? size * 0.14,
      ),
    );
  }
}

class _RoundedCheckPainter extends CustomPainter {
  _RoundedCheckPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.22, size.height * 0.54)
      ..lineTo(size.width * 0.44, size.height * 0.76)
      ..lineTo(size.width * 0.8, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoundedCheckPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

class SwapArchiveTile extends StatelessWidget {
  const SwapArchiveTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.history_rounded,
                  size: 20.sp,
                  color: AppColors.accentLime,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HomeStrings.swapArchive,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      HomeStrings.archiveSubtitle,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted, size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }
}
