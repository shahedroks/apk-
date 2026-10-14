import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/extra_mock_data.dart';
import '../providers/extra_ui_provider.dart';
import '../widgets/public_profile_widgets.dart';

class PublicProfileScreen extends ConsumerWidget {
  const PublicProfileScreen({super.key, this.username});

  final String? username;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(publicProfileTabProvider);
    final tabs = [
      ExtraStrings.listingsTab,
      ExtraStrings.reviewsTab,
      ExtraStrings.wishlistTab,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: PublicProfileTopBar(
                onBack: () => context.pop(),
                onMenu: () => showMockSnackBar(context, 'Profile menu (mock)'),
                onProfile: () => context.push(AppRouter.profile),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                children: [
                  PublicProfileHandleBar(
                    onShare: () => showMockSnackBar(context, 'Profile shared (mock)'),
                    onMore: () => showMockSnackBar(context, 'More options (mock)'),
                  ),
                  SizedBox(height: 8.h),
                  const PublicProfileHeroCard(),
                  SizedBox(height: 16.h),
                  const PublicProfileImpactCard(),
                  SizedBox(height: 16.h),
                  const PublicProfileDesiredTradesCard(),
                  SizedBox(height: 16.h),
                  PublicProfileSegmentTabs(
                    labels: tabs,
                    selectedIndex: tab,
                    onSelected: (i) => ref.read(publicProfileTabProvider.notifier).state = i,
                  ),
                  SizedBox(height: 16.h),
                  if (tab == 0)
                    ...ExtraMockData.publicListings.map(
                      (listing) => PublicProfileListingCard(
                        listing: listing,
                        onPropose: () => context.push('${AppRouter.proposeSwap}?itemId=${listing.id}'),
                      ),
                    )
                  else if (tab == 1)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Center(
                        child: TextButton(
                          onPressed: () => context.push(AppRouter.reviews),
                          child: Text(
                            'View all reviews',
                            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                              color: AppColors.accentGreen,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                      child: Text(
                        'Wishlist preview (mock)',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subtitle(fontSize: 14.sp),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Material(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: () => context.push(AppRouter.chat('c1', name: ExtraStrings.marcusChen)),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 18.sp, color: AppColors.primaryDark),
                    SizedBox(width: 8.w),
                    Text(
                      ExtraStrings.messageMarcus,
                      style: AppTextStyles.label(fontSize: 15.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
