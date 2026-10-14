import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/home_mock_data.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/item_grid_card.dart';
import '../widgets/saved_category_chip_bar.dart';

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
                  showTitle: true,
                  onProfileTap: () => context.push(AppRouter.profile),
                  onNotificationTap: () =>
                      context.push(AppRouter.notifications),
                ),
                SizedBox(height: 12.h),
                _SavedTreasuresBanner(
                  onManage: () => showMockSnackBar(context, 'Manage saved (mock)'),
                ),
                SizedBox(height: 16.h),
                SavedCategoryChipBar(
                  filters: HomeMockData.savedCategoryFilters,
                  selectedIndex: category,
                  onSelected: (i) =>
                      ref.read(savedCategoryProvider.notifier).state = i,
                ),
                SizedBox(height: 14.h),
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
              childAspectRatio: 0.58,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = HomeMockData.savedItems[index];
                return ItemGridCard(
                  item: item,
                  showProposeButton: true,
                  filledHeart: true,
                  wantsStyle: ItemWantsStyle.savedPill,
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

class _SavedTreasuresBanner extends StatelessWidget {
  const _SavedTreasuresBanner({required this.onManage});

  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.mintGlow.withValues(alpha: 0.4),
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
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.eco_outlined,
              size: 14.sp,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HomeStrings.savedBannerLine1,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                    height: 1.25,
                  ),
                ),
                Text(
                  HomeStrings.savedBannerLine2,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF234E40),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onManage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  HomeStrings.manage,
                  style: AppTextStyles.label(fontSize: 11.sp).copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 16.sp,
                  color: AppColors.primaryDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
