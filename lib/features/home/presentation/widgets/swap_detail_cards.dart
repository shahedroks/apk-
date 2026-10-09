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
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item.imageColor,
                  Color.lerp(item.imageColor, Colors.black, 0.22)!,
                ],
              ),
            ),
            child: SizedBox(
              height: 72.h,
              width: double.infinity,
              child: Icon(
                Icons.photo_outlined,
                color: Colors.white.withValues(alpha: 0.4),
                size: 28.sp,
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
    this.stepDates = const [],
  });

  final int completedSteps;
  final SwapProgressStep activeStep;
  final List<String> stepDates;

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

          return _TimelineRow(
            title: step.title,
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
  });

  final String title;
  final String dateLabel;
  final bool isDone;
  final bool isActive;
  final bool showLine;

  Widget _stepIndicator() {
    if (isDone) {
      return Container(
        width: 22.w,
        height: 22.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check_rounded, size: 14.sp, color: Colors.white),
      );
    }
    if (isActive) {
      return Container(
        width: 22.w,
        height: 22.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.accentLime,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Container(
          width: 7.w,
          height: 7.w,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.infoBorder),
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
                    color: isDone ? AppColors.primary.withValues(alpha: 0.35) : AppColors.infoBorder,
                  ),
                ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLine ? 14.h : 0, top: 2.h),
              child: Row(
                children: [
                  Expanded(
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
                  if (dateLabel.isNotEmpty)
                    Text(
                      dateLabel,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
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
                radius: 18.r,
                backgroundColor: const Color(0xFF78909C),
                child: Icon(Icons.person, size: 20.sp, color: Colors.white),
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
                  color: AppColors.mintGlow.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.accentLime.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  swap.statusLabel,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentGreen,
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
            stepDates: swap.stepDates,
          ),
          if (!swap.needsReview) ...[
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(
                      AppRouter.chat('c1', name: swap.partnerName),
                    ),
                    icon: Icon(Icons.chat_bubble_outline, size: 16.sp),
                    label: Text(
                      HomeStrings.openChat,
                      style: AppTextStyles.label(fontSize: 12.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      backgroundColor: AppColors.surface,
                      side: const BorderSide(color: AppColors.borderLight),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => context.push(AppRouter.swapCompleted),
                    icon: Icon(Icons.check_rounded, size: 18.sp, color: AppColors.primaryDark),
                    label: Text(
                      HomeStrings.confirmSwap,
                      style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.accentLime,
                      foregroundColor: AppColors.primaryDark,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
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
