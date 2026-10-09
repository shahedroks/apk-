import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/home_mock_data.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/swap_detail_cards.dart';

class MySwapsScreen extends ConsumerWidget {
  const MySwapsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(swapsTabProvider);

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      children: [
        HomeTopBar(
          title: HomeStrings.mySwaps,
          showSettings: true,
          onSettings: () => context.push(AppRouter.settings),
          onProfileTap: () => context.push(AppRouter.profile),
          onNotificationTap: () => context.push(AppRouter.notifications),
        ),
        SizedBox(height: 14.h),
        Material(
          color: AppColors.mintGlow.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(14.r),
          child: InkWell(
            onTap: () => context.push(AppRouter.myMatches),
            borderRadius: BorderRadius.circular(14.r),
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: AppColors.primary),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MatchStrings.myMatches, style: AppTextStyles.label(fontSize: 14.sp)),
                        Text(
                          MatchStrings.weFoundMatches,
                          style: AppTextStyles.caption(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.textMuted),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        _SwapTabs(selected: tab, onSelect: (i) {
          ref.read(swapsTabProvider.notifier).state = i;
        }),
        SizedBox(height: 16.h),
        const CircularImpactCard(),
        SizedBox(height: 16.h),
        if (tab == 0) ...[
          ActiveSwapCard(swap: HomeMockData.primarySwap),
          ActiveSwapCard(swap: HomeMockData.reviewSwap),
        ] else
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Center(
              child: Text(
                tab == 1 ? 'Completed swaps' : 'Cancelled swaps',
                style: AppTextStyles.subtitle(fontSize: 14.sp),
              ),
            ),
          ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Icon(Icons.archive_outlined, color: AppColors.primary, size: 22.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HomeStrings.swapArchive,
                      style: AppTextStyles.label(fontSize: 14.sp),
                    ),
                    Text(
                      HomeStrings.archiveSubtitle,
                      style: AppTextStyles.caption(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwapTabs extends StatelessWidget {
  const _SwapTabs({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final labels = [
      '${HomeStrings.inProgress} (2)',
      '${HomeStrings.completed} (8)',
      '${HomeStrings.cancelled} (1)',
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isActive = index == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  labels[index],
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? Colors.white : AppColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
