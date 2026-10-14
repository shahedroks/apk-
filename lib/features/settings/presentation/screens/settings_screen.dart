import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/storage/auth_session.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../profile/presentation/providers/settings_ui_provider.dart';
import '../widgets/settings_widgets.dart';

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
        backgroundColor: AppColors.background.withValues(alpha: 0.8),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.03),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ProfileStrings.settings,
          style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textSecondary),
            onPressed: () => showMockSnackBar(context, 'Settings menu (mock)'),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          const SettingsProfileMiniCard(),
          SizedBox(height: 24.h),
          SettingsSection(
            title: ProfileStrings.accountSettings,
            children: [
              SettingsNavRow(
                icon: Icons.person_outline_rounded,
                title: ProfileStrings.personalInfo,
                subtitle: ProfileStrings.email,
                onTap: () => showMockSnackBar(context, 'Personal info (mock)'),
              ),
              const SettingsDivider(),
              SettingsNavRow(
                icon: Icons.lock_reset_rounded,
                title: ProfileStrings.changePassword,
                subtitle: ProfileStrings.passwordUpdated,
                onTap: () => showMockSnackBar(context, 'Change password (mock)'),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsSection(
            title: ProfileStrings.notificationPrefs,
            children: [
              SettingsToggleRow(
                icon: Icons.chat_bubble_outline_rounded,
                title: ProfileStrings.swapInquiries,
                subtitle: ProfileStrings.swapInquiriesSub,
                value: swapInquiries,
                onChanged: (v) =>
                    ref.read(swapInquiriesToggleProvider.notifier).state = v,
              ),
              const SettingsDivider(),
              SettingsToggleRow(
                icon: Icons.notifications_none_outlined,
                title: ProfileStrings.statusAlerts,
                subtitle: ProfileStrings.statusAlertsSub,
                value: statusAlerts,
                onChanged: (v) =>
                    ref.read(statusAlertsToggleProvider.notifier).state = v,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsSection(
            title: ProfileStrings.privacySafety,
            children: [
              SettingsToggleRow(
                icon: Icons.my_location_outlined,
                title: ProfileStrings.approxLocation,
                subtitle: ProfileStrings.approxLocationSub,
                value: approxLocation,
                onChanged: (v) =>
                    ref.read(approxLocationToggleProvider.notifier).state = v,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsSection(
            title: ProfileStrings.legalSupport,
            children: [
              SettingsNavRow(
                icon: Icons.groups_outlined,
                title: ProfileStrings.communityGuidelines,
                onTap: () =>
                    showMockSnackBar(context, 'Community guidelines (mock)'),
              ),
              const SettingsDivider(),
              SettingsNavRow(
                icon: Icons.description_outlined,
                title: ProfileStrings.termsOfService,
                onTap: () => showMockSnackBar(context, 'Terms of service (mock)'),
              ),
              const SettingsDivider(),
              SettingsNavRow(
                icon: Icons.privacy_tip_outlined,
                title: ProfileStrings.privacyPolicy,
                onTap: () => showMockSnackBar(context, 'Privacy policy (mock)'),
              ),
              const SettingsDivider(),
              SettingsNavRow(
                icon: Icons.support_agent_outlined,
                title: ProfileStrings.contactSupport,
                subtitle: ProfileStrings.supportResponse,
                onTap: () =>
                    showMockSnackBar(context, 'Support request sent (mock)'),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsLogOutBlock(
            onLogOut: () async {
              await AuthSession.clear();
              if (context.mounted) context.go(AppRouter.login);
            },
            onDeleteAccount: () =>
                showMockSnackBar(context, 'Delete account (mock)'),
          ),
        ],
      ),
    );
  }
}
