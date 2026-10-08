import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/extra_mock_data.dart';
import '../providers/extra_ui_provider.dart';

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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ExtraStrings.publicHandle, style: AppTextStyles.label(fontSize: 15.sp)),
            SizedBox(width: 4.w),
            Icon(Icons.verified, size: 16.sp, color: AppColors.accentGreen),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showMockSnackBar(context, 'Profile shared (mock)'),
            icon: const Icon(Icons.ios_share),
          ),
          IconButton(
            onPressed: () => showMockSnackBar(context, 'More options (mock)'),
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 90.h),
        children: [
          Center(
            child: Stack(
              children: [
                const ProfileAvatar(radius: 48),
                Positioned(
                  right: 4.w,
                  bottom: 4.h,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      color: AppColors.accentLime,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(ExtraStrings.marcusChen, textAlign: TextAlign.center, style: AppTextStyles.screenTitle(fontSize: 20.sp)),
          Text(ExtraStrings.publicLocation, textAlign: TextAlign.center, style: AppTextStyles.subtitle(fontSize: 13.sp)),
          Text(ExtraStrings.swappingSince, textAlign: TextAlign.center, style: AppTextStyles.caption(fontSize: 12.sp)),
          SizedBox(height: 14.h),
          Row(
            children: [
              _stat(Icons.verified_user_outlined, ExtraStrings.reliable),
              _stat(Icons.star_outline, '4.9\n${ExtraStrings.reviewsCount}'),
              _stat(Icons.swap_horiz, ExtraStrings.swapsCount),
              _stat(Icons.schedule, ExtraStrings.replyTime),
            ],
          ),
          SizedBox(height: 14.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.mintGlow.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ExtraStrings.co2Saved, style: AppTextStyles.label(fontSize: 16.sp)),
                Text(ExtraStrings.planetTier, style: AppTextStyles.caption(fontSize: 12.sp)),
                Text(ExtraStrings.circularityBadge, style: AppTextStyles.label(fontSize: 12.sp).copyWith(color: AppColors.accentGreen)),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(ExtraStrings.desiredTrades, style: AppTextStyles.label(fontSize: 14.sp)),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ExtraMockData.desiredTradeChips
                .map((c) => Chip(label: Text(c), backgroundColor: AppColors.surface))
                .toList(),
          ),
          SizedBox(height: 16.h),
          Row(
            children: List.generate(tabs.length, (i) {
              final active = tab == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () => ref.read(publicProfileTabProvider.notifier).state = i,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: active ? AppColors.textPrimary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      tabs[i],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 14.h),
          if (tab == 0) _listingCard(context) else if (tab == 1)
            TextButton(
              onPressed: () => context.push(AppRouter.reviews),
              child: const Text('View all reviews'),
            )
          else
            Text('Wishlist items', style: AppTextStyles.subtitle(fontSize: 14.sp)),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SwapPrimaryButton(
            label: ExtraStrings.messageMarcus,
            icon: Icons.chat_bubble_outline,
            onPressed: () => context.push(AppRouter.chat('c1', name: 'Marcus Chen')),
          ),
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String label) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            SizedBox(height: 4.h),
            Text(label, textAlign: TextAlign.center, style: AppTextStyles.caption(fontSize: 9.sp)),
          ],
        ),
      ),
    );
  }

  Widget _listingCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ColoredBox(
                color: const Color(0xFF37474F),
                child: SizedBox(height: 140.h, width: double.infinity),
              ),
              Positioned(
                left: 10.w,
                top: 10.h,
                child: Text(ItemStrings.likeNew, style: AppTextStyles.caption(fontSize: 10.sp)),
              ),
              Positioned(
                right: 10.w,
                top: 10.h,
                child: Text('~\$160 val', style: AppTextStyles.caption(fontSize: 10.sp)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ItemStrings.detailTitle, style: AppTextStyles.label(fontSize: 15.sp)),
                Text('Seeking: keyboards, cameras', style: AppTextStyles.caption(fontSize: 11.sp)),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('${AppRouter.proposeSwap}?itemId=4'),
                    child: const Text('Propose →'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
