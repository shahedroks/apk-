import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/home_top_bar.dart';
import '../../data/item_mock_data.dart';
import '../providers/item_form_provider.dart';

class MyItemsScreen extends ConsumerWidget {
  const MyItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(myItemsTabProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            HomeTopBar(
              title: ItemStrings.myItems,
              darkBrandMark: true,
              darkProfileAvatar: true,
              onProfileTap: () => context.push(AppRouter.profile),
              onNotificationTap: () => context.push(AppRouter.notifications),
            ),
            SizedBox(height: 16.h),
            _SubHeaderRow(onAdd: () => context.push(AppRouter.addItem)),
            SizedBox(height: 4.h),
            _StatusSegmentedTabs(
              selected: tab,
              onSelect: (i) => ref.read(myItemsTabProvider.notifier).state = i,
            ),
            SizedBox(height: 16.h),
            _SearchFilterRow(
              onFilter: () => showMockSnackBar(context, 'Filters (mock)'),
            ),
            SizedBox(height: 24.h),
            if (tab == 0)
              ...ItemMockData.myActiveListings.map(
                (item) => _MyItemCard(
                  item: item,
                  onView: () => context.push(AppRouter.item(item.id)),
                  onEdit: () => context.push(AppRouter.addItem),
                  onDelete: () => showMockSnackBar(context, 'Listing removed (mock)'),
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

class _SubHeaderRow extends StatelessWidget {
  const _SubHeaderRow({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ItemStrings.myItems,
                style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.55,
                  height: 1.27,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 11.sp, color: AppColors.accentGreen),
                  SizedBox(width: 6.w),
                  Text(
                    ItemStrings.myItemsLocationLine,
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Material(
          color: const Color(0xFF00241A),
          borderRadius: BorderRadius.circular(12.r),
          elevation: 1,
          shadowColor: Colors.black.withValues(alpha: 0.05),
          child: InkWell(
            onTap: onAdd,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 15.sp, color: AppColors.accentLime),
                  SizedBox(width: 6.w),
                  Text(
                    ItemStrings.addNewLabel,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusSegmentedTabs extends StatelessWidget {
  const _StatusSegmentedTabs({
    required this.selected,
    required this.onSelect,
  });

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final labels = [ItemStrings.tabActive, ItemStrings.tabHidden, ItemStrings.tabSwapped];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: List.generate(labels.length, (i) {
            final active = selected == i;
            return Padding(
              padding: EdgeInsets.only(right: i < labels.length - 1 ? 4.w : 0),
              child: Material(
                color: active ? const Color(0xFF00241A) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                child: InkWell(
                  onTap: () => onSelect(i),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          labels[i],
                          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: active ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                        if (active && i == 0) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            height: 12.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.accentLime,
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Text(
                              '${ItemStrings.myItemsActiveCount}',
                              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF00241A),
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SearchFilterRow extends StatelessWidget {
  const _SearchFilterRow({required this.onFilter});

  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 15.sp, color: AppColors.textSecondary),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    ItemStrings.searchMyItems,
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: onFilter,
            borderRadius: BorderRadius.circular(12.r),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SizedBox(
                width: 44.w,
                height: 44.h,
                child: Icon(Icons.tune, size: 15.sp, color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MyItemCard extends StatelessWidget {
  const _MyItemCard({
    required this.item,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final UserListingItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ItemThumbnail(item: item),
              SizedBox(width: 16.w),
              Expanded(
                child: SizedBox(
                  height: 96.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.33,
                                  ),
                                ),
                              ),
                              Icon(Icons.more_vert, size: 18.sp, color: AppColors.textSecondary),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            item.categoryConditionLine,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentGreen,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _StatChip(icon: Icons.visibility_outlined, label: '${item.views}'),
                              SizedBox(width: 8.w),
                              Text(
                                '•',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              _StatChip(
                                icon: Icons.chat_bubble_outline,
                                label: '${item.inquiries}',
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            item.listedAgo,
                            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _ActionChip(label: ItemStrings.view, icon: Icons.visibility_outlined, onTap: onView)),
              SizedBox(width: 4.w),
              Expanded(child: _ActionChip(label: ItemStrings.edit, icon: Icons.edit_outlined, onTap: onEdit)),
              SizedBox(width: 4.w),
              _DeleteChip(onTap: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemThumbnail extends StatelessWidget {
  const _ItemThumbnail({required this.item});

  final UserListingItem item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 96.w,
        height: 96.w,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (item.imageUrl != null)
              CachedNetworkImage(imageUrl: item.imageUrl!, fit: BoxFit.cover)
            else
              ColoredBox(color: item.color),
            Positioned(
              left: 6.w,
              top: 6.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(999.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item.status,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12.sp, color: AppColors.textSecondary),
        SizedBox(width: 2.w),
        Text(
          label,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12.sp, color: const Color(0xFF00241A)),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteChip extends StatelessWidget {
  const _DeleteChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x99FFDAD6),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          width: 40.w,
          height: 36.h,
          child: Icon(Icons.delete_outline, size: 14.sp, color: const Color(0xFFBA1A1A)),
        ),
      ),
    );
  }
}
