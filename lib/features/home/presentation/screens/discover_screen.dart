import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/theme/text_styles.dart';
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
                  onProfileTap: () => context.push(AppRouter.profile),
                  onNotificationTap: () => context.push(AppRouter.notifications),
                ),
                SizedBox(height: 14.h),
                const HomeSearchBar(),
                SizedBox(height: 16.h),
                Text(
                  HomeStrings.goodMorning,
                  style: AppTextStyles.screenTitle(fontSize: 20.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  HomeStrings.readyToSwap,
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                SizedBox(height: 16.h),
                PromoBanner(
                  onTap: () => context.push(AppRouter.myMatches),
                ),
                SizedBox(height: 16.h),
                CategoryChipBar(
                  labels: HomeMockData.discoverCategories,
                  selectedIndex: category,
                  onSelected: (i) =>
                      ref.read(discoverCategoryProvider.notifier).state = i,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        HomeStrings.itemsYouMayLike,
                        style: AppTextStyles.label(fontSize: 15.sp),
                      ),
                    ),
                    Text(
                      HomeStrings.viewAll,
                      style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                        color: AppColors.accentGreen,
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
              childAspectRatio: 0.62,
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
