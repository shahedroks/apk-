import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/home_search_bar.dart';
import '../../../home/presentation/widgets/home_top_bar.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/item_mock_data.dart';
import '../providers/item_form_provider.dart';

class MyItemsScreen extends ConsumerWidget {
  const MyItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(myItemsTabProvider);
    final tabs = [ItemStrings.activeTab, ItemStrings.hiddenTab, ItemStrings.swappedTab];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            HomeTopBar(
              title: ItemStrings.myItems,
              onProfileTap: () => context.push(AppRouter.profile),
              onNotificationTap: () => context.push(AppRouter.notifications),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Williamsburg, Brooklyn',
                    style: AppTextStyles.caption(fontSize: 12.sp),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => context.push(AppRouter.addItem),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(ItemStrings.addNew),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: List.generate(tabs.length, (i) {
                final active = tab == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => ref.read(myItemsTabProvider.notifier).state = i,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: active ? AppColors.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tabs[i],
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                          color: active ? AppColors.primary : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 12.h),
            const HomeSearchBar(),
            SizedBox(height: 14.h),
            if (tab == 0)
              ...ItemMockData.myActiveListings.map(
                (item) => _MyItemCard(
                  item: item,
                  onView: () => context.push(AppRouter.item(item.id)),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48.h),
                child: Center(
                  child: Text(
                    tab == 1 ? 'No hidden listings' : 'No swapped items yet',
                    style: AppTextStyles.subtitle(fontSize: 14.sp),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}

class _MyItemCard extends StatelessWidget {
  const _MyItemCard({required this.item, required this.onView});

  final UserListingItem item;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: ColoredBox(
                  color: item.color,
                  child: SizedBox(width: 88.w, height: 88.w),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColors.mintGlow,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.status,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(item.title, style: AppTextStyles.label(fontSize: 15.sp)),
                    Text(item.category, style: AppTextStyles.caption(fontSize: 11.sp)),
                    Text(
                      '${item.inquiries} inquiries • ${item.estimatedValue}',
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onView,
                  child: Text(ItemStrings.view),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push(AppRouter.addItem),
                  child: Text(ItemStrings.edit),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: () => showMockSnackBar(context, 'Listing removed (mock)'),
                icon: Icon(Icons.delete_outline, color: AppColors.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
