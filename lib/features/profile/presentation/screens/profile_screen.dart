import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/storage/auth_session.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/providers/home_ui_provider.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/home_top_bar.dart';
import '../widgets/profile_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            HomeTopBar(
              title: ProfileStrings.profile,
              darkBrandMark: true,
              darkProfileAvatar: true,
              onProfileTap: () {},
              onNotificationTap: () => context.push(AppRouter.notifications),
            ),
            SizedBox(height: 12.h),
            ProfileSubNavRow(
              onBack: () => context.pop(),
              onSettings: () => context.push(AppRouter.settings),
            ),
            SizedBox(height: 16.h),
            ProfileHeroCard(
              onEditProfile: () => context.push(AppRouter.settings),
              onVerifiedTap: () => context.push(AppRouter.reviews),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                ProfileStatCard(
                  icon: Icons.inventory_2_outlined,
                  value: '3',
                  label: ProfileStrings.activeListings,
                ),
                SizedBox(width: 10.w),
                ProfileStatCard(
                  icon: Icons.swap_horiz_rounded,
                  value: '18',
                  label: ProfileStrings.swapsDone,
                ),
                SizedBox(width: 10.w),
                ProfileStatCard(
                  icon: Icons.eco_outlined,
                  value: '18.5kg',
                  label: ProfileStrings.co2Diverted,
                  showEcoAccent: true,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ProfilePlanetGuardianBanner(
              onTap: () => context.push(AppRouter.subscriptionUpgrade),
            ),
            SizedBox(height: 16.h),
            ProfileMenuGroup(
              children: [
                ProfileMenuTile(
                  icon: Icons.workspace_premium_outlined,
                  title: ProfileStrings.mySubscription,
                  subtitle: ProfileStrings.mySubscriptionSub,
                  onTap: () => context.push(AppRouter.mySubscription),
                ),
                ProfileMenuTile(
                  icon: Icons.inventory_2_outlined,
                  title: ProfileStrings.myListings,
                  subtitle: ProfileStrings.myListingsSub,
                  badge: '3',
                  onTap: () => context.push(AppRouter.myItems),
                ),
                ProfileMenuTile(
                  icon: Icons.swap_horiz_rounded,
                  title: ProfileStrings.incomingSwapOfferMenu,
                  subtitle: ProfileStrings.incomingSwapOfferSub,
                  badge: '3',
                  onTap: () => context.push(AppRouter.incomingSwapOffers),
                ),
                ProfileMenuTile(
                  icon: Icons.favorite_border,
                  title: ProfileStrings.savedItems,
                  subtitle: ProfileStrings.savedItemsSub,
                  badge: '4',
                  badgeColor: const Color(0xFFDEE9FC),
                  onTap: () {
                    ref.read(homeTabIndexProvider.notifier).state = 1;
                    context.go(AppRouter.home);
                  },
                ),
                ProfileMenuTile(
                  icon: Icons.shield_outlined,
                  title: ProfileStrings.settingsSecurity,
                  subtitle: ProfileStrings.settingsSecuritySub,
                  onTap: () => context.push(AppRouter.settings),
                ),
                ProfileMenuTile(
                  icon: Icons.help_outline,
                  title: ProfileStrings.helpGuidelines,
                  subtitle: ProfileStrings.helpGuidelinesSub,
                  onTap: () =>
                      showMockSnackBar(context, 'Community guidelines (mock)'),
                ),
                ProfileMenuTile(
                  icon: Icons.gavel_outlined,
                  title: ProfileStrings.termsPrivacy,
                  subtitle: ProfileStrings.termsPrivacySub,
                  showDivider: false,
                  onTap: () => context.push(AppRouter.settings),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ProfileLogOutSection(
              onLogOut: () async {
                await AuthSession.signOut();
                if (context.mounted) context.go(AppRouter.login);
              },
              onDeleteAccount: () => showMockSnackBar(
                context,
                'Delete account (mock — not implemented)',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
