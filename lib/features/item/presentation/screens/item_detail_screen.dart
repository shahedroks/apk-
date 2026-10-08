import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/item_mock_data.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, this.itemId});

  final String? itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _HeroImage()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ItemStrings.categoryElectronics,
                        style: AppTextStyles.overline(fontSize: 10.sp),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        ItemStrings.detailTitle,
                        style: AppTextStyles.screenTitle(fontSize: 22.sp),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 4.h,
                        children: [
                          _meta(Icons.star_rounded, ItemStrings.ratingMeta),
                          _meta(Icons.schedule, ItemStrings.listedAgo),
                          _meta(Icons.location_on_outlined, ItemStrings.location),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _OwnerCard(
                        onProfile: () => context.push(AppRouter.publicUser('marcus_c')),
                      ),
                      SizedBox(height: 20.h),
                      Text(ItemStrings.aboutItem, style: AppTextStyles.label(fontSize: 15.sp)),
                      SizedBox(height: 8.h),
                      Text(
                        ItemStrings.aboutBody,
                        style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(height: 1.4),
                      ),
                      SizedBox(height: 16.h),
                      _SpecGrid(),
                      SizedBox(height: 16.h),
                      _WishlistCard(),
                      SizedBox(height: 16.h),
                      Text(ItemStrings.meetupZone, style: AppTextStyles.label(fontSize: 15.sp)),
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: Container(
                          height: 120.h,
                          color: AppColors.infoBorder,
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(Icons.map_outlined, size: 40.sp, color: AppColors.textMuted),
                              ),
                              Center(
                                child: Container(
                                  width: 80.w,
                                  height: 80.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 2),
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        ItemStrings.meetupNote,
                        style: AppTextStyles.caption(fontSize: 12.sp),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Icon(Icons.eco_outlined, color: AppColors.accentGreen, size: 20.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              ItemStrings.ecoImpact,
                              style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomBar(
              onPropose: () => context.push(
                '${AppRouter.proposeSwap}?itemId=${itemId ?? ItemMockData.defaultItemId}',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.textMuted),
        SizedBox(width: 4.w),
        Text(text, style: AppTextStyles.caption(fontSize: 11.sp)),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: const Color(0xFF37474F)),
          Center(
            child: Icon(Icons.album_outlined, size: 80.sp, color: Colors.white54),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8.h,
            left: 12.w,
            right: 12.w,
            child: Row(
              children: [
                ProfileCircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => context.pop(),
                ),
                const Spacer(),
                ProfileCircleButton(
                  icon: Icons.ios_share,
                  backgroundColor: AppColors.surface,
                ),
                SizedBox(width: 8.w),
                ProfileCircleButton(
                  icon: Icons.more_horiz,
                  backgroundColor: AppColors.surface,
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.w,
            top: MediaQuery.paddingOf(context).top + 56.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _chip(ItemStrings.likeNew),
                SizedBox(height: 6.h),
                _chip(ItemStrings.availableForSwap),
              ],
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: i == 0 ? 8.w : 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: i == 0 ? AppColors.surface : AppColors.surface.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _OwnerCard extends StatelessWidget {
  const _OwnerCard({required this.onProfile});

  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          const ProfileAvatar(radius: 22),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(ProfileStrings.marcusChen, style: AppTextStyles.label(fontSize: 14.sp)),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.mintGlow,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        ItemStrings.verified,
                        style: AppTextStyles.caption(fontSize: 9.sp).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Text(ItemStrings.location, style: AppTextStyles.caption(fontSize: 11.sp)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onProfile,
            child: Text(ItemStrings.profile),
          ),
        ],
      ),
    );
  }
}

class _SpecGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final specs = [
      (ItemStrings.brand, ItemStrings.brandValue),
      (ItemStrings.condition, ItemStrings.conditionValue),
      (ItemStrings.power, ItemStrings.powerValue),
      (ItemStrings.packaging, ItemStrings.packagingValue),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 2.2,
      children: specs
          .map(
            (s) => Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(s.$1, style: AppTextStyles.caption(fontSize: 10.sp)),
                  Text(s.$2, style: AppTextStyles.label(fontSize: 13.sp)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.mintGlow.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.accentLime.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.swap_horiz_rounded, color: AppColors.primary, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ItemStrings.wishlistTitle, style: AppTextStyles.label(fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text(ItemStrings.wishlistBody, style: AppTextStyles.subtitle(fontSize: 13.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.onPropose});

  final VoidCallback onPropose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () => showMockSnackBar(context, 'Saved to wishlist (mock)'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(52.w, 52.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Icon(Icons.favorite_border, color: AppColors.primary),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SwapPrimaryButton(
                label: ItemStrings.proposeSwapChat,
                icon: Icons.chat_bubble_outline,
                onPressed: onPropose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
