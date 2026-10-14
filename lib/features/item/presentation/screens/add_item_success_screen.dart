import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../../data/add_item_mock_data.dart';
import '../../data/item_mock_data.dart';

class AddItemSuccessScreen extends StatelessWidget {
  const AddItemSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  const _ConfettiBackdrop(),
                  Column(
                    children: [
                      SizedBox(height: 16.h),
                      const _SuccessHeroBadge(),
                      SizedBox(height: 16.h),
                      Text(
                        ItemStrings.successTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.screenTitle(fontSize: 28.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.7,
                          height: 1.29,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        child: Text.rich(
                          TextSpan(
                            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                              height: 23 / 14,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(text: ItemStrings.successBodyLead),
                              TextSpan(
                                text: ItemStrings.successBodyLocation,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              const TextSpan(text: ItemStrings.successBodyTail),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _ListingPreviewCard(),
              SizedBox(height: 16.h),
              _QuickTipCard(),
              SizedBox(height: 16.h),
              _PrimaryCta(
                onTap: () => context.push(AppRouter.item(ItemMockData.defaultItemId)),
              ),
              SizedBox(height: 8.h),
              _SecondaryCta(onTap: () => context.go(AppRouter.home)),
              SizedBox(height: 8.h),
              TextButton.icon(
                onPressed: () => showMockSnackBar(context, 'Listing shared (mock)'),
                icon: Icon(Icons.ios_share, size: 14.sp, color: AppColors.textSecondary),
                label: Text(
                  ItemStrings.shareListing,
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
    );
  }
}

class _ConfettiBackdrop extends StatelessWidget {
  const _ConfettiBackdrop();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      width: double.infinity,
      child: Stack(
        children: [
          _dot(0.58, 0.42, 5, AppColors.accentLime),
          _dot(0.52, 0.18, 7, Colors.white, h: 14),
          _dot(0.22, 0.35, 4, const Color(0xFF91DB2A)),
          _dot(0.28, 0.38, 4, AppColors.accentLime, h: 8),
          _dot(0.25, 0.12, 6, const Color(0xFF91DB2A)),
          _dot(0.62, 0.15, 6, Colors.white),
          _dot(0.45, 0.08, 8, AppColors.primary, h: 16),
          _dot(0.24, 0.14, 9, Colors.white, h: 18),
          _dot(0.66, 0.05, 4, AppColors.mintGlow),
          _dot(0.44, 0.22, 6, AppColors.mintGlow),
          _dot(0.46, 0.36, 4, const Color(0xFF91DB2A)),
        ],
      ),
    );
  }

  Widget _dot(double fx, double fy, double size, Color color, {double? h}) {
    return Positioned(
      left: (390 * fx).w.clamp(0, 320.w),
      top: (220 * fy).h,
      child: Transform.rotate(
        angle: fx * 2.2,
        child: Container(
          width: size.w,
          height: (h ?? size).h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(size > 6 ? 2.r : 999.r),
          ),
        ),
      ),
    );
  }
}

class _SuccessHeroBadge extends StatelessWidget {
  const _SuccessHeroBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112.w,
      height: 112.w,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 112.w,
            height: 112.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentLime.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          Container(
            width: 96.w,
            height: 96.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(96.w, 96.w),
                  painter: _DashedArcPainter(),
                ),
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: RoundedCheckMark(
                    size: 26.w,
                    color: const Color(0xFF00241A),
                    strokeWidth: 3.w,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: const Color(0xFF00241A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.swap_horiz_rounded, size: 14.sp, color: AppColors.accentLime),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(Icons.eco_outlined, size: 12.sp, color: AppColors.accentGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentLime.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final rect = Rect.fromLTWH(8, 8, size.width - 16, size.height - 16);
    canvas.drawArc(rect, -0.8, 1.2, false, paint);
    canvas.drawArc(rect, 2.3, 1.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ListingPreviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 80.w,
              height: 80.w,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: AddItemMockData.photoUrls.first,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 4.w,
                    top: 4.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xCC00241A),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        ItemStrings.successSwapBadge,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: SizedBox(
              height: 94.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              ItemStrings.successListingCategory,
                              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDEE9FC),
                              borderRadius: BorderRadius.circular(999.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentLime,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  ItemStrings.successListingActive,
                                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        ItemStrings.successListingTitle,
                        style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.43,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.infoBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.swap_horiz_rounded, size: 14.sp, color: AppColors.accentGreen),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            ItemStrings.successListingWants,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _QuickTipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: Color(0xFFD9E3F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lightbulb_outline, size: 16.sp, color: AppColors.accentGreen),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ItemStrings.quickTip,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text.rich(
                  TextSpan(
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      height: 19 / 14,
                      color: AppColors.textSecondary,
                    ),
                    children: const [
                      TextSpan(text: 'Swappers respond '),
                      TextSpan(
                        text: '3x faster',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            ' when you keep notifications turned on and reply within the first hour of a proposal.',
                      ),
                    ],
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

class _PrimaryCta extends StatelessWidget {
  const _PrimaryCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF00241A),
      borderRadius: BorderRadius.circular(12.r),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ItemStrings.viewListing,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward_rounded, size: 12.sp, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryCta extends StatelessWidget {
  const _SecondaryCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.public, size: 16.sp, color: AppColors.textPrimary),
                SizedBox(width: 8.w),
                Text(
                  ItemStrings.backToDiscover,
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
