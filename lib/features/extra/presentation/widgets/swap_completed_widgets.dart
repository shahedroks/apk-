import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/chat_strings.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';

class SwapCompletedTopBar extends StatelessWidget {
  const SwapCompletedTopBar({
    super.key,
    required this.onBack,
    required this.onMenu,
    required this.onProfile,
  });

  final VoidCallback onBack;
  final VoidCallback onMenu;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp),
            onPressed: onBack,
          ),
          Expanded(
            child: Text(
              ExtraStrings.swapCompleted,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
                letterSpacing: -0.45,
              ),
            ),
          ),
          IconButton(
            onPressed: onMenu,
            icon: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onProfile,
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Center(
                    child: ProfileAvatar(
                      radius: 16,
                      imageUrl: ProfileStrings.profileAvatarUrl,
                    ),
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

class SwapCompletedHeroBadge extends StatelessWidget {
  const SwapCompletedHeroBadge();

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
              color: AppColors.accentLime.withValues(alpha: 0.24),
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
                  painter: _SwapDashedRingPainter(),
                ),
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: const BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                  ),
                  child: RoundedCheckMark(
                    size: 28.w,
                    color: const Color(0xFF00241A),
                    strokeWidth: 3.w,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -4.w,
            bottom: -4.h,
            child: Container(
              width: 32.w,
              height: 32.w,
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
              child: Icon(Icons.eco_rounded, size: 14.sp, color: AppColors.accentGreen),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapDashedRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentLime.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
    const dash = 6.0;
    const gap = 5.0;
    _drawDashedCircle(canvas, rect, paint, dash, gap);
  }

  void _drawDashedCircle(Canvas canvas, Rect rect, Paint paint, double dash, double gap) {
    final path = Path()..addOval(rect);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dash;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SwapCompletedCelebrationHeader extends StatelessWidget {
  const SwapCompletedCelebrationHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SwapCompletedHeroBadge(),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.accentLime.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.verified_user_rounded, size: 14.sp, color: const Color(0xFF102000)),
              SizedBox(width: 4.w),
              Text(
                ExtraStrings.handshakeVerified,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF102000),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            ExtraStrings.swapSuccessTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle(fontSize: 28.sp).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.7,
              height: 1.29,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            ExtraStrings.swapSuccessBody,
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              height: 20 / 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class SwapCompletedExchangeRow extends StatelessWidget {
  const SwapCompletedExchangeRow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TradePhotoCard(
                tag: ExtraStrings.given,
                title: ExtraStrings.keyboardTradeTitle,
                subtitle: ExtraStrings.yourItem,
                imageUrl: ChatStrings.youOfferImageUrl,
              ),
            ),
            SizedBox(width: 48.w),
            Expanded(
              child: _TradePhotoCard(
                tag: ExtraStrings.received,
                title: ExtraStrings.turntableTradeTitle,
                subtitle: ExtraStrings.marcusChen,
                imageUrl: ChatStrings.partnerItemImageUrl,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ExtraStrings.direct,
              style: AppTextStyles.caption(fontSize: 8.sp).copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: AppColors.accentGreen,
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Icons.swap_horiz_rounded, size: 18.sp, color: const Color(0xFF457000)),
            ),
          ],
        ),
      ],
    );
  }
}

class _TradePhotoCard extends StatelessWidget {
  const _TradePhotoCard({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String tag;
  final String title;
  final String subtitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 120.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => const ColoredBox(color: AppColors.borderLight),
                  errorWidget: (_, _, _) => ColoredBox(
                    color: AppColors.infoBackground,
                    child: Icon(Icons.image_outlined, color: AppColors.textMuted),
                  ),
                ),
                Positioned(
                  left: 8.w,
                  top: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      tag,
                      style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.label(fontSize: 13.sp).copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class SwapEnvironmentalImpactCard extends StatelessWidget {
  const SwapEnvironmentalImpactCard();

  static const _metricBg = Color(0x801E392B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ExtraStrings.envImpact,
                  style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  ExtraStrings.verified,
                  style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _ImpactMetricRow(
            icon: Icons.eco_outlined,
            title: ExtraStrings.co2Diverted,
            subtitle: ExtraStrings.co2Sub,
          ),
          SizedBox(height: 12.h),
          _ImpactMetricRow(
            icon: Icons.delete_outline_rounded,
            title: ExtraStrings.landfill,
            subtitle: ExtraStrings.landfillSub,
          ),
          SizedBox(height: 12.h),
          _ImpactMetricRow(
            icon: Icons.payments_outlined,
            title: ExtraStrings.zeroCash,
            subtitle: ExtraStrings.zeroCashSub,
          ),
        ],
      ),
    );
  }
}

class _ImpactMetricRow extends StatelessWidget {
  const _ImpactMetricRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: SwapEnvironmentalImpactCard._metricBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Icon(icon, size: 18.sp, color: AppColors.primaryDark),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentLime,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.27,
                    color: const Color(0xFF85A391),
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

class SwapRatingCard extends StatelessWidget {
  const SwapRatingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
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
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ProfileAvatar(
                    radius: 24,
                    imageUrl: ChatStrings.partnerAvatarUrl,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            ExtraStrings.marcusChen,
                            style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.verified, size: 16.sp, color: AppColors.accentGreen),
                      ],
                    ),
                    Text(
                      ExtraStrings.marcusCompletedSwaps,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  ExtraStrings.coSwapperBadge,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            ExtraStrings.rateExperience,
            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(
              5,
              (_) => Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: Icon(Icons.star_rounded, size: 32.sp, color: AppColors.accentLime),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            ExtraStrings.rateTraits,
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              height: 1.35,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class SwapDigitalReceiptCard extends StatelessWidget {
  const SwapDigitalReceiptCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined, size: 16.sp, color: AppColors.textMuted),
              SizedBox(width: 8.w),
              Text(
                ExtraStrings.digitalReceipt,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _receiptLine('SWAP ID', 'SWP-92841'),
          _receiptLine('VERIFIED', 'Today, 4:12 PM'),
          _receiptLine('LOCATION', 'McCarren Park Plaza'),
          _receiptLine('BILATERAL CHECK', '✓ ✓'),
        ],
      ),
    );
  }

  Widget _receiptLine(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              label,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
