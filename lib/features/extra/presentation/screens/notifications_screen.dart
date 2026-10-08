import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../data/extra_mock_data.dart';
import '../providers/extra_ui_provider.dart';
import '../widgets/extra_widgets.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(notificationFilterProvider);
    final filters = ['${ExtraStrings.filterAll} 5', ...ExtraMockData.notificationFilters.skip(1)];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    ExtraStrings.notifications,
                    style: AppTextStyles.screenTitle(fontSize: 22.sp),
                  ),
                ),
                ProfileCircleButton(
                  icon: Icons.notifications_none_rounded,
                  backgroundColor: AppColors.surface,
                ),
                SizedBox(width: 8.w),
                ProfileCircleButton(
                  icon: Icons.settings_outlined,
                  onTap: () => context.push(AppRouter.settings),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => context.push(AppRouter.profile),
                  child: const ProfileAvatar(radius: 18),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            HorizontalFilterChips(
              labels: filters,
              selectedIndex: filter,
              darkSelected: true,
              onSelected: (i) => ref.read(notificationFilterProvider.notifier).state = i,
            ),
            const SectionLabel(label: ExtraStrings.today),
            ...ExtraMockData.todayNotifications.map(
              (n) => NotificationTile(
                notification: n,
                onAction: n.onActionRoute != null
                    ? () => context.push(n.onActionRoute!)
                    : null,
              ),
            ),
            const SectionLabel(label: ExtraStrings.yesterday),
            ...ExtraMockData.yesterdayNotifications.map(
              (n) => NotificationTile(
                notification: n,
                onAction: n.onActionRoute != null
                    ? () => context.push(n.onActionRoute!)
                    : null,
              ),
            ),
            const SectionLabel(label: ExtraStrings.thisWeek),
            ...ExtraMockData.weekNotifications.map(
              (n) => NotificationTile(notification: n),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
