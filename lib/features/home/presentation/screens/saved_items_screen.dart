import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/mappers/listing_mapper.dart';
import '../providers/firebase_data_providers.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/item_grid_card.dart';
import '../../data/home_mock_data.dart';
import '../widgets/saved_category_chip_bar.dart';

class SavedItemsScreen extends ConsumerWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(savedCategoryProvider);
    final savedAsync = ref.watch(savedListingsProvider);

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
                  onManage: () => context.push(AppRouter.myItems),
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
          sliver: savedAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: Center(
                      child: Text(
                        'No saved items yet. Tap the heart on Discover.',
                        style: AppTextStyles.subtitle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              final listings = items.map(ListingMapper.toSwapListing).toList();
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.58,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = listings[index];
                    return ItemGridCard(
                      item: item.copyWith(isSaved: true),
                      showProposeButton: true,
                      filledHeart: true,
                      wantsStyle: ItemWantsStyle.savedPill,
                      onTap: () => context.push(AppRouter.item(item.id)),
                      onProposeTap: () => context.push(
                        '${AppRouter.proposeSwap}?itemId=${item.id}',
                      ),
                    );
                  },
                  childCount: listings.length,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverToBoxAdapter(
              child: Text('Could not load saved items: $e'),
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
    return Material(
      color: AppColors.sageCard,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onManage,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Icon(Icons.bookmark, color: AppColors.primary, size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  HomeStrings.savedBannerLine1,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.primaryDark),
            ],
          ),
        ),
      ),
    );
  }
}
