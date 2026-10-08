import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/extra_mock_data.dart';
import '../providers/extra_ui_provider.dart';
import '../widgets/extra_widgets.dart';

class ReviewsScreen extends ConsumerWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reviewFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(ExtraStrings.reviewsTitle, style: AppTextStyles.screenTitle(fontSize: 17.sp)),
        actions: [
          IconButton(
            onPressed: () => showMockSnackBar(context, 'Reviews menu (mock)'),
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
            onPressed: () => context.push(AppRouter.profile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ExtraStrings.ratingSummary, style: AppTextStyles.screenTitle(fontSize: 28.sp)),
                  Row(
                    children: List.generate(5, (_) => Icon(Icons.star, color: Colors.amber, size: 18.sp)),
                  ),
                  Text(ExtraStrings.ratingBased, style: AppTextStyles.caption(fontSize: 11.sp)),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 100.w,
                child: Column(
                  children: [5, 4, 3, 2, 1].map((star) {
                    final width = star == 5 ? 1.0 : star == 4 ? 0.15 : 0.05;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          Text('$star', style: AppTextStyles.caption(fontSize: 10.sp)),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: width,
                              minHeight: 6.h,
                              backgroundColor: AppColors.infoBorder,
                              color: AppColors.accentLime,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          HorizontalFilterChips(
            labels: ExtraMockData.reviewFilters,
            selectedIndex: filter,
            onSelected: (i) => ref.read(reviewFilterProvider.notifier).state = i,
          ),
          SizedBox(height: 16.h),
          ...ExtraMockData.reviews.map((r) => ReviewCard(review: r)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.shield_outlined, color: AppColors.accentLime),
                SizedBox(width: 10.w),
                Text(
                  ExtraStrings.verifiedTrust,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
