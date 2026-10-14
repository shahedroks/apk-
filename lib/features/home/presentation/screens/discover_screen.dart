import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/home_mock_data.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/category_chip_bar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/item_grid_card.dart';
import '../widgets/promo_banner.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(discoverCategoryProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBar(
                  title: HomeStrings.discover,
                  showTitle: true,
                  onProfileTap: () => context.push(AppRouter.profile),
                  onNotificationTap: () => context.push(AppRouter.notifications),
                ),
                SizedBox(height: 12.h),
                const HomeSearchBar(discoverStyle: true),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '👋',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      HomeStrings.goodMorning,
                      style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: -0.55,
                        height: 1.27,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  HomeStrings.readyToSwap,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.43,
                  ),
                ),
                SizedBox(height: 16.h),
                Material(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: () => context.push(AppRouter.myMatches),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome, size: 18.sp, color: AppColors.accentLime),
                          SizedBox(width: 8.w),
                          Text(
                            HomeStrings.myMatches,
                            style: AppTextStyles.label(fontSize: 15.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward, size: 16.sp, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                PromoBanner(
                  onTap: () => context.push(AppRouter.myMatches),
                ),
                SizedBox(height: 20.h),
                CategoryChipBar(
                  labels: HomeMockData.discoverCategories,
                  selectedIndex: category,
                  style: CategoryChipStyle.discover,
                  onSelected: (i) =>
                      ref.read(discoverCategoryProvider.notifier).state = i,
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      HomeStrings.itemsYouMayLike,
                      style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        HomeStrings.nearbyBadge,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => showMockSnackBar(context, 'View all (mock)'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            HomeStrings.viewAll,
                            style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentGreen,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 16.sp,
                            color: AppColors.accentGreen,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.64,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = HomeMockData.discoverItems[index];
                return ItemGridCard(
                  item: item,
                  onTap: () => context.push(AppRouter.item(item.id)),
                );
              },
              childCount: HomeMockData.discoverItems.length,
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
