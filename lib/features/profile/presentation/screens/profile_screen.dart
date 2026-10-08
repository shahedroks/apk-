import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/providers/home_ui_provider.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../../core/utils/mock_actions.dart';
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
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    size: 22.sp,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    ProfileStrings.profile,
                    style: AppTextStyles.screenTitle(fontSize: 20.sp),
                  ),
                ),
                ProfileCircleButton(
                  icon: Icons.notifications_none_rounded,
                  backgroundColor: AppColors.surface,
                  onTap: () => context.push(AppRouter.notifications),
                ),
                SizedBox(width: 8.w),
                const ProfileAvatar(radius: 18),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                ProfileCircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => context.pop(),
                ),
                const Spacer(),
                ProfileCircleButton(
                  icon: Icons.settings_outlined,
                  onTap: () => context.push(AppRouter.settings),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Center(child: const ProfileAvatar(radius: 52, showEdit: true)),
            SizedBox(height: 12.h),
            Text(
              ProfileStrings.marcusChen,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle(fontSize: 22.sp),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.textMuted),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    ProfileStrings.location,
                    style: AppTextStyles.subtitle(fontSize: 13.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              ProfileStrings.memberSince,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption(fontSize: 12.sp),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Material(
                color: AppColors.mintGlow.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(999.r),
                child: InkWell(
                  onTap: () => context.push(AppRouter.reviews),
                  borderRadius: BorderRadius.circular(999.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(color: AppColors.accentLime.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      '${ProfileStrings.communityVerified} • ${ProfileStrings.ratingSwaps}',
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRouter.settings),
              icon: Icon(Icons.edit_outlined, size: 18.sp),
              label: Text(ProfileStrings.editProfile),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.borderLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
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
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
              child: InkWell(
                onTap: () => context.push(AppRouter.subscriptionUpgrade),
                borderRadius: BorderRadius.circular(16.r),
                child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.accentLime,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.eco, color: AppColors.primaryDark, size: 26.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProfileStrings.planetGuardian,
                          style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ProfileStrings.planetGuardianBody,
                          style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.8)),
                ],
              ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            ProfileMenuTile(
              icon: Icons.inventory_2_outlined,
              title: ProfileStrings.myListings,
              subtitle: ProfileStrings.myListingsSub,
              badge: '3',
              onTap: () => context.push(AppRouter.myItems),
            ),
            ProfileMenuTile(
              icon: Icons.auto_awesome,
              title: 'My Matches',
              subtitle: 'AI-powered swap suggestions',
              onTap: () => context.push(AppRouter.myMatches),
            ),
            ProfileMenuTile(
              icon: Icons.swap_horiz_rounded,
              title: ProfileStrings.incomingSwapOfferMenu,
              subtitle: ProfileStrings.incomingSwapOfferSub,
              badge: '3',
              onTap: () => context.push(AppRouter.incomingSwapOffer),
            ),
            ProfileMenuTile(
              icon: Icons.favorite_border,
              title: ProfileStrings.savedItems,
              subtitle: ProfileStrings.savedItemsSub,
              badge: '4',
              badgeColor: AppColors.infoBorder,
              onTap: () {
                ref.read(homeTabIndexProvider.notifier).state = 1;
                context.go(AppRouter.home);
              },
            ),
            ProfileMenuTile(
              icon: Icons.workspace_premium_outlined,
              title: 'Circular Membership',
              subtitle: 'Upgrade, billing & plan quotas',
              onTap: () => context.push(AppRouter.mySubscription),
            ),
            ProfileMenuTile(
              icon: Icons.shield_outlined,
              title: ProfileStrings.settingsSecurity,
              subtitle: ProfileStrings.settingsSecuritySub,
              onTap: () => context.push(AppRouter.settings),
            ),
            ProfileMenuTile(
              icon: Icons.star_outline,
              title: 'Reviews & Trust',
              subtitle: 'See bilateral swap ratings',
              onTap: () => context.push(AppRouter.reviews),
            ),
            ProfileMenuTile(
              icon: Icons.help_outline,
              title: ProfileStrings.helpGuidelines,
              subtitle: ProfileStrings.helpGuidelinesSub,
              onTap: () => showMockSnackBar(context, 'Community guidelines (mock)'),
            ),
            ProfileMenuTile(
              icon: Icons.gavel_outlined,
              title: ProfileStrings.termsPrivacy,
              subtitle: ProfileStrings.termsPrivacySub,
              onTap: () => context.push(AppRouter.settings),
            ),
            SizedBox(height: 8.h),
            OutlinedButton.icon(
              onPressed: () => context.go(AppRouter.login),
              icon: Icon(Icons.logout, size: 18.sp, color: AppColors.error),
              label: Text(
                ProfileStrings.logOut,
                style: TextStyle(color: AppColors.error, fontSize: 14.sp),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            TextButton(
              onPressed: () => showMockSnackBar(context, 'Delete account (mock — not implemented)'),
              child: Text(
                ProfileStrings.deleteAccount,
                style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                  color: AppColors.error,
                  decoration: TextDecoration.underline,
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
