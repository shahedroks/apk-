import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/listing_item.dart';
import '../../../home/presentation/providers/listings_provider.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/home_top_bar.dart';
import '../providers/item_form_provider.dart';

class MyItemsScreen extends ConsumerWidget {
  const MyItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(myItemsTabProvider);
    final listingsAsync = ref.watch(myListingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: listingsAsync.when(
          data: (listings) {
            final active = listings.where((i) => i.status != 'hidden').toList();
            final hidden = listings.where((i) => i.status == 'hidden').toList();
            final swapped = listings.where((i) => i.status == 'rejected').toList();

            return ListView(
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
                SizedBox(height: 24.h),
                if (tab == 0)
                  ...active.map(
                    (item) => _MyItemCard(
                      item: item,
                      onView: () => context.push(AppRouter.item(item.id)),
                      onEdit: () => context.push(AppRouter.addItem),
                      onDelete: () async {
                        await ref.read(itemRepositoryProvider).deleteItem(item.id);
                      },
                    ),
                  )
                else if (tab == 1)
                  ...hidden.map(
                    (item) => _MyItemCard(
                      item: item,
                      onView: () => context.push(AppRouter.item(item.id)),
                      onEdit: () => context.push(AppRouter.addItem),
                      onDelete: () async {
                        await ref.read(itemRepositoryProvider).deleteItem(item.id);
                      },
                    ),
                  )
                else if (swapped.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: Center(
                      child: Text(
                        'No swapped items yet',
                        style: AppTextStyles.subtitle(fontSize: 14.sp),
                      ),
                    ),
                  )
                else
                  ...swapped.map(
                    (item) => _MyItemCard(
                      item: item,
                      onView: () => context.push(AppRouter.item(item.id)),
                      onEdit: () => context.push(AppRouter.addItem),
                      onDelete: () async {
                        await ref.read(itemRepositoryProvider).deleteItem(item.id);
                      },
                    ),
                  ),
                if (tab == 0 && active.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: Center(
                      child: Text(
                        'No listings yet. Add your first item!',
                        style: AppTextStyles.subtitle(fontSize: 14.sp),
                      ),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
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
      children: [
        Expanded(
          child: Text(
            ItemStrings.myItems,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 18),
          label: Text(ItemStrings.addItem),
        ),
      ],
    );
  }
}

class _StatusSegmentedTabs extends StatelessWidget {
  const _StatusSegmentedTabs({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final labels = [ItemStrings.activeTab, ItemStrings.hiddenTab, ItemStrings.swappedTab];
    return Row(
      children: List.generate(labels.length, (i) {
        final active = i == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < labels.length - 1 ? 8.w : 0),
            child: Material(
              color: active ? AppColors.primary : AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
              child: InkWell(
                onTap: () => onSelect(i),
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
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

  final ListingItem item;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.imageUrls.isNotEmpty ? item.imageUrls.first : null;
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: imageUrl != null
              ? CachedNetworkImage(imageUrl: imageUrl, width: 56.w, height: 56.w, fit: BoxFit.cover)
              : Container(width: 56.w, height: 56.w, color: AppColors.fieldGray),
        ),
        title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text('${item.status} • ${item.categoryName}'),
        trailing: PopupMenuButton<String>(
          onSelected: (v) {
            if (v == 'view') onView();
            if (v == 'edit') onEdit();
            if (v == 'delete') onDelete();
          },
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'view', child: Text('View')),
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
