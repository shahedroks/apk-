import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../../data/item_mock_data.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key, this.itemId});

  final String? itemId;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  static const _wishlistSage = Color(0xFF79A694);
  static const _wishlistMint = Color(0xFFBEEDD9);
  static const _ctaDark = Color(0xFF00241A);
  static const _ecoBg = Color(0xFFDEE9FC);
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  static const int _photoCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _MediaShowcase(
                  pageController: _pageController,
                  pageIndex: _pageIndex,
                  onPageChanged: (i) => setState(() => _pageIndex = i),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TitleHeader(),
                      SizedBox(height: 24.h),
                      _OwnerTrustCard(
                        onProfile: () => context.push(AppRouter.publicUser('marcus_c')),
                      ),
                      SizedBox(height: 24.h),
                      _AboutSection(),
                      SizedBox(height: 24.h),
                      _SpecGridSection(),
                      SizedBox(height: 24.h),
                      _WishlistCard(
                        wishlistSage: _wishlistSage,
                        wishlistMint: _wishlistMint,
                      ),
                      SizedBox(height: 24.h),
                      _MeetupSection(),
                      SizedBox(height: 24.h),
                      _EcoBanner(ecoBg: _ecoBg, ctaDark: _ctaDark),
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
              ctaDark: _ctaDark,
              onPropose: () => context.push(
                '${AppRouter.proposeSwap}?itemId=${widget.itemId ?? ItemMockData.defaultItemId}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaShowcase extends StatelessWidget {
  const _MediaShowcase({
    required this.pageController,
    required this.pageIndex,
    required this.onPageChanged,
  });

  final PageController pageController;
  final int pageIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 390.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: AppColors.infoBackground),
          PageView.builder(
            controller: pageController,
            itemCount: _ItemDetailScreenState._photoCount,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: ItemStrings.detailHeroImageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(color: AppColors.infoBackground),
                errorWidget: (context, url, error) => ColoredBox(color: AppColors.infoBackground),
              );
            },
          ),
          Positioned(
            left: 16.w,
            top: topInset + 16.h,
            child: Row(
              children: [
                _LikeNewBadge(),
                SizedBox(width: 4.w),
                _AvailableSwapBadge(),
              ],
            ),
          ),
          Positioned(
            right: 16.w,
            top: topInset + 16.h,
            child: _FrostCircleButton(
              icon: Icons.more_vert,
              onTap: () => showMockSnackBar(context, 'Item options (mock)'),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0x6600241A),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_ItemDetailScreenState._photoCount, (i) {
                      final active = i == pageIndex;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.accentLime
                              : Colors.white.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16.w,
            bottom: 16.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xB300241A),
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                '${pageIndex + 1}/${_ItemDetailScreenState._photoCount}',
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LikeNewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            ItemStrings.likeNew,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableSwapBadge extends StatelessWidget {
  static const _swapText = Color(0xFF79A694);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(999.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.swap_horiz_rounded, size: 12.sp, color: _swapText),
          SizedBox(width: 4.w),
          Text(
            ItemStrings.availableForSwap,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: _swapText,
            ),
          ),
        ],
      ),
    );
  }
}

class _FrostCircleButton extends StatelessWidget {
  const _FrostCircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(icon, size: 20.sp, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _TitleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.borderLight,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            ItemStrings.categoryElectronics,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          ItemStrings.detailTitle,
          style: AppTextStyles.screenTitle(fontSize: 28.sp).copyWith(
            fontWeight: FontWeight.w700,
            height: 1.25,
            letterSpacing: -0.5,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.schedule, size: 13.sp, color: AppColors.textMuted),
            SizedBox(width: 6.w),
            Text(
              ItemStrings.listedAgo,
              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                '•',
                style: TextStyle(color: const Color(0xFFC0C8C3), fontSize: 14.sp),
              ),
            ),
            Icon(Icons.location_on_outlined, size: 12.sp, color: AppColors.textMuted),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                ItemStrings.locationDetail,
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OwnerTrustCard extends StatelessWidget {
  const _OwnerTrustCard({required this.onProfile});

  final VoidCallback onProfile;

  static const _verifiedBg = Color(0xFFCAEAD6);
  static const _verifiedText = Color(0xFF042014);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: ProfileStrings.profileAvatarUrl,
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: -2.w,
                      bottom: -2.h,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.accentGreen,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: RoundedCheckMark(
                          size: 8.w,
                          color: Colors.white,
                          strokeWidth: 1.4.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              ProfileStrings.marcusChen,
                              style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: _verifiedBg,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              ItemStrings.verified,
                              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                fontWeight: FontWeight.w700,
                                color: _verifiedText,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, size: 12.sp, color: AppColors.accentGreen),
                          SizedBox(width: 4.w),
                          Text(
                            ItemStrings.ownerRatingLine,
                            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              '•',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
                            ),
                          ),
                          Text(
                            ItemStrings.ownerSwapsLine,
                            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.bolt_rounded, size: 11.sp, color: AppColors.textMuted),
                          SizedBox(width: 4.w),
                          Text(
                            ItemStrings.ownerRepliesLine,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Material(
            color: AppColors.borderLight,
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: onProfile,
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Text(
                  ItemStrings.profile,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ItemStrings.aboutItem,
          style: AppTextStyles.label(fontSize: 18.sp).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        Text(
          ItemStrings.aboutBody,
          style: AppTextStyles.subtitle(fontSize: 16.sp).copyWith(
            height: 26 / 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _SpecGridSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final specs = [
      (ItemStrings.brand, ItemStrings.brandValue, false),
      (ItemStrings.condition, ItemStrings.conditionValue, true),
      (ItemStrings.power, ItemStrings.powerValue, false),
      (ItemStrings.packaging, ItemStrings.packagingValue, false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ItemStrings.itemSpecifications,
          style: AppTextStyles.label(fontSize: 18.sp).copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _SpecCell(label: specs[0].$1, value: specs[0].$2, highlight: specs[0].$3)),
                SizedBox(width: 8.w),
                Expanded(child: _SpecCell(label: specs[1].$1, value: specs[1].$2, highlight: specs[1].$3)),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _SpecCell(label: specs[2].$1, value: specs[2].$2, highlight: specs[2].$3)),
                SizedBox(width: 8.w),
                Expanded(child: _SpecCell(label: specs[3].$1, value: specs[3].$2, highlight: specs[3].$3)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SpecCell extends StatelessWidget {
  const _SpecCell({
    required this.label,
    required this.value,
    required this.highlight,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              height: 1.2,
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
              fontWeight: FontWeight.w600,
              height: 1.25,
              color: highlight ? AppColors.accentGreen : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  const _WishlistCard({
    required this.wishlistSage,
    required this.wishlistMint,
  });

  final Color wishlistSage;
  final Color wishlistMint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.swap_horiz_rounded,
              size: 18.sp,
              color: const Color(0xFF457000),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ItemStrings.wishlistTitle,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.325,
                    color: AppColors.accentLime,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  ItemStrings.wishlistBody,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    height: 19 / 14,
                    color: wishlistSage,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.format_list_bulleted_rounded, size: 11.sp, color: wishlistMint),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        ItemStrings.wishlistFooter,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: wishlistMint,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetupSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                ItemStrings.meetupZone,
                style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                ),
              ),
            ),
            Text(
              ItemStrings.meetupNeighborhoods,
              textAlign: TextAlign.right,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w600,
                height: 1.27,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 176.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: ItemStrings.detailMapImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ColoredBox(color: AppColors.infoBackground),
                ),
                ColoredBox(color: const Color(0x1A00241A)),
                Center(
                  child: Container(
                    width: 96.w,
                    height: 96.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentGreen.withValues(alpha: 0.2),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0x6600241A),
                      ),
                      child: Icon(Icons.location_on, size: 20.sp, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  left: 8.w,
                  right: 8.w,
                  bottom: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline, size: 13.sp, color: AppColors.textMuted),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            ItemStrings.meetupMapNote,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EcoBanner extends StatelessWidget {
  const _EcoBanner({required this.ecoBg, required this.ctaDark});

  final Color ecoBg;
  final Color ctaDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ecoBg,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.eco_outlined, size: 16.sp, color: ctaDark),
          SizedBox(width: 12.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                  height: 18 / 14,
                  color: AppColors.textPrimary,
                ),
                children: [
                  const TextSpan(
                    text: 'By swapping this item, you prevent roughly ',
                  ),
                  TextSpan(
                    text: '4.2 kg',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(
                    text: ' of e-waste from entering local landfills.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.ctaDark, required this.onPropose});

  final Color ctaDark;
  final VoidCallback onPropose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1400241A),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Material(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: () => showMockSnackBar(context, 'Saved (mock)'),
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 48.w,
                  height: 48.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 18.sp, color: AppColors.textPrimary),
                      Text(
                        ItemStrings.save,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Material(
                color: ctaDark,
                borderRadius: BorderRadius.circular(12.r),
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.1),
                child: InkWell(
                  onTap: onPropose,
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 17.sp, color: Colors.white),
                        SizedBox(width: 8.w),
                        Text(
                          ItemStrings.proposeSwapChat,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
