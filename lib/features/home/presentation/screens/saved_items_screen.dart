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
import '../widgets/home_top_bar.dart';
import '../widgets/item_grid_card.dart';

class SavedItemsScreen extends ConsumerWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(savedCategoryProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBar(
                  title: HomeStrings.savedItems,
                  onProfileTap: () => context.push(AppRouter.profile),
                  onNotificationTap: () => context.push(AppRouter.notifications),
                ),
                SizedBox(height: 14.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: AppColors.mintGlow.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.accentLime.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          HomeStrings.savedBanner,
                          style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        HomeStrings.manage,
                        style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                          color: AppColors.accentGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                CategoryChipBar(
                  labels: HomeMockData.savedCategories,
                  selectedIndex: category,
                  onSelected: (i) =>
                      ref.read(savedCategoryProvider.notifier).state = i,
                ),
                SizedBox(height: 16.h),
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
              childAspectRatio: 0.52,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = HomeMockData.savedItems[index];
                return ItemGridCard(
                  item: item,
                  showProposeButton: true,
                  filledHeart: true,
                  onTap: () => context.push(AppRouter.item(item.id)),
                  onProposeTap: () => context.push(
                    '${AppRouter.proposeSwap}?itemId=${item.id}',
                  ),
                );
              },
              childCount: HomeMockData.savedItems.length,
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
      ],
    );
  }
}
