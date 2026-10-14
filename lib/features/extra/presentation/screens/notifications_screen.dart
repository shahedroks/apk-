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
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/swap_brand_mark.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../data/extra_mock_data.dart';
import '../providers/extra_ui_provider.dart';
import '../widgets/extra_widgets.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(notificationFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: _NotificationsTopBar(
                onSettings: () => context.push(AppRouter.settings),
                onProfile: () => context.push(AppRouter.profile),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 16.h),
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                    child: _UtilityRow(
                      onMarkAllRead: () =>
                          showMockSnackBar(context, 'All notifications marked read (mock)'),
                    ),
                  ),
                  NotificationFilterChips(
                    labels: ExtraMockData.notificationFilters,
                    counts: ExtraMockData.notificationFilterCounts,
                    selectedIndex: filter,
                    onSelected: (i) =>
                        ref.read(notificationFilterProvider.notifier).state = i,
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        const NotificationSectionHeader(
                          title: ExtraStrings.today,
                          trailing: ExtraStrings.todayAlertsMeta,
                        ),
                        ...ExtraMockData.todayNotifications.map(
                          (n) => NotificationTile(
                            notification: n,
                            onAction: n.onActionRoute != null
                                ? () => context.push(n.onActionRoute!)
                                : null,
                          ),
                        ),
                        const NotificationSectionHeader(
                          title: ExtraStrings.yesterday,
                          trailing: ExtraStrings.yesterdayMeta,
                        ),
                        ...ExtraMockData.yesterdayNotifications.map(
                          (n) => NotificationTile(
                            notification: n,
                            onAction: n.onActionRoute != null
                                ? () => context.push(n.onActionRoute!)
                                : null,
                          ),
                        ),
                        const NotificationSectionHeader(
                          title: ExtraStrings.thisWeek,
                          trailing: ExtraStrings.thisWeekMeta,
                        ),
                        ...ExtraMockData.weekNotifications.map(
                          (n) => NotificationTile(notification: n),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                size: 12.sp,
                                color: AppColors.textSecondary.withValues(alpha: 0.6),
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  ExtraStrings.notificationsFooter,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}

class _NotificationsTopBar extends StatelessWidget {
  const _NotificationsTopBar({
    required this.onSettings,
    required this.onProfile,
  });

  final VoidCallback onSettings;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SwapBrandMark(dark: true),
        SizedBox(width: 8.w),
        Text(
          ExtraStrings.notifications,
          style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
            letterSpacing: -0.45,
          ),
        ),
        const Spacer(),
        _HeaderIconButton(icon: Icons.notifications_none_rounded),
        SizedBox(width: 8.w),
        _HeaderIconButton(icon: Icons.settings_outlined, onTap: onSettings),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onProfile,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryDark.withValues(alpha: 0.1),
                  blurRadius: 0,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ProfileAvatar(
              radius: 18,
              imageUrl: ProfileStrings.profileAvatarUrl,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44.w,
          height: 44.w,
          child: Icon(icon, size: 18.sp, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _UtilityRow extends StatelessWidget {
  const _UtilityRow({required this.onMarkAllRead});

  final VoidCallback onMarkAllRead;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ExtraStrings.notifications,
          style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
            letterSpacing: -0.55,
            height: 1.27,
          ),
        ),
        SizedBox(width: 4.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.accentLime,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            ExtraStrings.unreadBadge,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF457000),
            ),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          child: InkWell(
            onTap: onMarkAllRead,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.done_all, size: 14.sp, color: AppColors.accentGreen),
                  SizedBox(width: 4.w),
                  Text(
                    ExtraStrings.markAllRead,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentGreen,
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
