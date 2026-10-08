import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/constants/home_strings.dart';
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
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            HomeStrings.circularImpact,
            style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
              color: AppColors.accentLime,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            HomeStrings.impactStat,
            style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
              color: Colors.white,
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
  });

  final SwapListing youGive;
  final SwapListing youGet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _ItemThumb(label: HomeStrings.youGive, item: youGive)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Container(
            width: 32.w,
            height: 32.w,
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
        ),
        Expanded(child: _ItemThumb(label: HomeStrings.youGet, item: youGet)),
      ],
    );
  }
}

class _ItemThumb extends StatelessWidget {
  const _ItemThumb({required this.label, required this.item});

  final String label;
  final SwapListing item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: ColoredBox(
            color: item.imageColor,
            child: SizedBox(
              height: 72.h,
              width: double.infinity,
              child: Icon(
                Icons.inventory_2_outlined,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          item.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption(fontSize: 10.sp),
        ),
      ],
    );
  }
}

class SwapProgressTimeline extends StatelessWidget {
  const SwapProgressTimeline({
    super.key,
    required this.completedSteps,
    required this.activeStep,
  });

  final int completedSteps;
  final SwapProgressStep activeStep;

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
          style: AppTextStyles.label(fontSize: 13.sp),
        ),
        SizedBox(height: 10.h),
        ...steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isDone = index < completedSteps;
          final isActive = step.step == activeStep;
          final isLast = index == steps.length - 1;

          return _TimelineRow(
            title: step.title,
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
    required this.isDone,
    required this.isActive,
    required this.showLine,
  });

  final String title;
  final bool isDone;
  final bool isActive;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    final Color dotColor = isDone || isActive
        ? AppColors.primary
        : AppColors.infoBorder;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: isDone
                    ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                    : isActive
                        ? Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: AppColors.accentLime,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: AppColors.infoBorder,
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLine ? 12.h : 0, top: 2.h),
              child: Text(
                title,
                style: AppTextStyles.subtitle(fontSize: 12.sp).copyWith(
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive || isDone
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.infoBackground,
                child: Text(
                  swap.partnerName.substring(0, 1),
                  style: AppTextStyles.label(fontSize: 12.sp),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          swap.partnerName,
                          style: AppTextStyles.label(fontSize: 14.sp),
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
                                  .copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      '★ ${swap.partnerRating}',
                      style: AppTextStyles.caption(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  swap.statusLabel,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          SwapComparisonRow(youGive: swap.youGive, youGet: swap.youGet),
          SizedBox(height: 14.h),
          SwapProgressTimeline(
            completedSteps: swap.completedSteps,
            activeStep: swap.activeStep,
          ),
          if (!swap.needsReview) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.push(
                      AppRouter.chat('c1', name: swap.partnerName),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.borderLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(HomeStrings.openChat),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => context.push(AppRouter.swapCompleted),
                    icon: Icon(Icons.check_circle_outline, size: 18.sp),
                    label: Text(HomeStrings.confirmSwap),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
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
                if (swap.reviewStepLabel != null)
                  Text(
                    swap.reviewStepLabel!,
                    style: AppTextStyles.caption(fontSize: 11.sp),
                  ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    HomeStrings.actionNeeded,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.push(AppRouter.incomingSwapOffer),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accentLime,
                  foregroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  HomeStrings.reviewOffer,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
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
