import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../profile/presentation/providers/settings_ui_provider.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swapInquiries = ref.watch(swapInquiriesToggleProvider);
    final statusAlerts = ref.watch(statusAlertsToggleProvider);
    final approxLocation = ref.watch(approxLocationToggleProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ProfileStrings.settings,
          style: AppTextStyles.screenTitle(fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showMockSnackBar(context, 'Settings menu (mock)'),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16.r),
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
                const ProfileAvatar(radius: 28),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ProfileStrings.marcusChen,
                            style: AppTextStyles.label(fontSize: 15.sp),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentLime,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              ProfileStrings.proSwapper,
                              style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ProfileStrings.email,
                        style: AppTextStyles.caption(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          const SettingsSectionHeader(title: ProfileStrings.accountSettings),
          SettingsNavTile(
            icon: Icons.person_outline,
            title: ProfileStrings.personalInfo,
            onTap: () => showMockSnackBar(context, 'Personal info (mock)'),
          ),
          SettingsNavTile(
            icon: Icons.workspace_premium_outlined,
            title: 'My Subscription',
            subtitle: 'Premium Yearly · Manage plan',
            onTap: () => context.push(AppRouter.mySubscription),
          ),
          SettingsNavTile(
            icon: Icons.rocket_launch_outlined,
            title: 'Upgrade to Premium',
            subtitle: 'Unlimited listings & smart match',
            onTap: () => context.push(AppRouter.subscriptionUpgrade),
          ),
          SettingsNavTile(
            icon: Icons.lock_outline,
            title: ProfileStrings.changePassword,
            subtitle: ProfileStrings.passwordUpdated,
            onTap: () => showMockSnackBar(context, 'Change password (mock)'),
          ),
          SizedBox(height: 12.h),
          const SettingsSectionHeader(title: ProfileStrings.notificationPrefs),
          SettingsNavTile(
            icon: Icons.chat_bubble_outline,
            title: ProfileStrings.swapInquiries,
            subtitle: ProfileStrings.swapInquiriesSub,
            trailing: Switch(
              value: swapInquiries,
              activeThumbColor: AppColors.surface,
              activeTrackColor: AppColors.primary,
              onChanged: (v) =>
                  ref.read(swapInquiriesToggleProvider.notifier).state = v,
            ),
          ),
          SettingsNavTile(
            icon: Icons.notifications_none_outlined,
            title: ProfileStrings.statusAlerts,
            subtitle: ProfileStrings.statusAlertsSub,
            trailing: Switch(
              value: statusAlerts,
              activeThumbColor: AppColors.surface,
              activeTrackColor: AppColors.primary,
              onChanged: (v) =>
                  ref.read(statusAlertsToggleProvider.notifier).state = v,
            ),
          ),
          SizedBox(height: 12.h),
          const SettingsSectionHeader(title: ProfileStrings.privacySafety),
          SettingsNavTile(
            icon: Icons.location_on_outlined,
            title: ProfileStrings.approxLocation,
            subtitle: ProfileStrings.approxLocationSub,
            trailing: Switch(
              value: approxLocation,
              activeThumbColor: AppColors.surface,
              activeTrackColor: AppColors.primary,
              onChanged: (v) =>
                  ref.read(approxLocationToggleProvider.notifier).state = v,
            ),
          ),
          SizedBox(height: 12.h),
          const SettingsSectionHeader(title: ProfileStrings.legalSupport),
          SettingsNavTile(
            icon: Icons.groups_outlined,
            title: ProfileStrings.communityGuidelines,
            onTap: () => showMockSnackBar(context, 'Community guidelines (mock)'),
          ),
          SettingsNavTile(
            icon: Icons.description_outlined,
            title: ProfileStrings.termsOfService,
            onTap: () => showMockSnackBar(context, 'Terms of service (mock)'),
          ),
          SettingsNavTile(
            icon: Icons.privacy_tip_outlined,
            title: ProfileStrings.privacyPolicy,
            onTap: () => showMockSnackBar(context, 'Privacy policy (mock)'),
          ),
          SettingsNavTile(
            icon: Icons.support_agent_outlined,
            title: ProfileStrings.contactSupport,
            subtitle: ProfileStrings.supportResponse,
            onTap: () => showMockSnackBar(context, 'Support request sent (mock)'),
          ),
          SizedBox(height: 20.h),
          OutlinedButton.icon(
            onPressed: () => context.go(AppRouter.login),
            icon: Icon(Icons.logout, size: 18.sp, color: AppColors.error),
            label: Text(
              ProfileStrings.logOut,
              style: TextStyle(color: AppColors.error),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 48.h),
              side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => showMockSnackBar(context, 'Delete account (mock)'),
            icon: Icon(Icons.delete_outline, size: 18.sp, color: AppColors.error),
            label: Text(
              ProfileStrings.deleteAccountShort,
              style: TextStyle(color: AppColors.error, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
