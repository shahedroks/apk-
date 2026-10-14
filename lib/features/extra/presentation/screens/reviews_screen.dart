import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 0),
              child: _ReviewsHeader(
                onMenu: () => showMockSnackBar(context, 'Reviews menu (mock)'),
                onProfile: () => context.push(AppRouter.profile),
                onBack: () => context.pop(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                children: [
                  const ReviewsSummaryCard(),
                  SizedBox(height: 8.h),
                  ReviewFilterChips(
                    labels: ExtraMockData.reviewFilters,
                    counts: ExtraMockData.reviewFilterCounts,
                    selectedIndex: filter,
                    onSelected: (i) =>
                        ref.read(reviewFilterProvider.notifier).state = i,
                  ),
                  SizedBox(height: 16.h),
                  ...ExtraMockData.reviews.map((r) => ReviewCard(review: r)),
                  const ReviewTrustBanner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewsHeader extends StatelessWidget {
  const _ReviewsHeader({
    required this.onBack,
    required this.onMenu,
    required this.onProfile,
  });

  final VoidCallback onBack;
  final VoidCallback onMenu;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 44.w,
                height: 44.w,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              ExtraStrings.reviewsTitle,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
                letterSpacing: -0.45,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onMenu,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 44.w,
                height: 44.w,
                child: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textPrimary),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onProfile,
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Center(
                    child: ProfileAvatar(
                      radius: 16,
                      imageUrl: ProfileStrings.profileAvatarUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
