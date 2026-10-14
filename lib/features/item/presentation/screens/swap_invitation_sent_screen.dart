import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../../home/presentation/providers/home_ui_provider.dart';
import '../../data/propose_swap_mock_data.dart';

class SwapInvitationSentScreen extends ConsumerWidget {
  const SwapInvitationSentScreen({super.key, this.offerIndex = 0});

  final int offerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ProposeSwapMockData.offerOptions[
        offerIndex.clamp(0, ProposeSwapMockData.offerOptions.length - 1)];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 32.h),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              const _InviteSuccessHeroSection(),
              SizedBox(height: 24.h),
              _ExchangeSummaryCard(
                offerTitle: offer.title,
                offerImageUrl: offer.imageUrl,
                targetTitle: ItemStrings.targetItem,
                targetImageUrl: ProposeSwapMockData.targetImageUrl,
              ),
              SizedBox(height: 16.h),
              const _StatusTipCard(),
              SizedBox(height: 24.h),
              SwapPrimaryButton(
                label: ItemStrings.messageRecipient,
                onPressed: () =>
                    context.push(AppRouter.chat('c1', name: ItemStrings.targetOwner)),
                icon: Icons.chat_bubble_outline_rounded,
                iconAtStart: true,
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(homeTabIndexProvider.notifier).state = 3;
                    context.go(AppRouter.home);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.borderLight, width: 1.5),
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    ItemStrings.trackInMySwaps,
                    style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
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

/// Hero + headline grouped so glow/confetti stay behind the icon only.
class _InviteSuccessHeroSection extends StatelessWidget {
  const _InviteSuccessHeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 148.h,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 132.w,
                height: 132.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accentLime.withValues(alpha: 0.38),
                      AppColors.accentLime.withValues(alpha: 0.08),
                      AppColors.accentLime.withValues(alpha: 0),
                    ],
                    stops: const [0.35, 0.65, 1],
                  ),
                ),
              ),
              _confettiDot(left: 48.w, top: 18.h, size: 4, color: AppColors.accentLime),
              _confettiDot(left: 280.w, top: 28.h, size: 5, color: const Color(0xFF91DB2A)),
              _confettiDot(left: 72.w, top: 100.h, size: 3, color: Colors.white),
              _confettiDot(left: 300.w, top: 88.h, size: 4, color: AppColors.mintGlow),
              const _InviteSuccessHeroBadge(),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          ItemStrings.inviteSuccessTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.screenTitle(fontSize: 26.sp).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.65,
            height: 1.25,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text.rich(
            TextSpan(
              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                height: 22 / 14,
                color: AppColors.textSecondary,
              ),
              children: [
                const TextSpan(text: ItemStrings.inviteSuccessBodyLead),
                TextSpan(
                  text: ItemStrings.targetOwner,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const TextSpan(text: ItemStrings.inviteSuccessBodyTail),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _confettiDot({
    required double left,
    required double top,
    required double size,
    required Color color,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(1.r),
        ),
      ),
    );
  }
}

class _InviteSuccessHeroBadge extends StatelessWidget {
  const _InviteSuccessHeroBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104.w,
      height: 104.w,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Transform.rotate(
              angle: -0.35,
              child: Icon(
                Icons.send_rounded,
                size: 36.sp,
                color: AppColors.accentLime,
              ),
            ),
          ),
          Positioned(
            right: 2.w,
            top: 6.h,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 2.5.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.swap_horiz_rounded, size: 15.sp, color: AppColors.accentLime),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExchangeSummaryCard extends StatelessWidget {
  const _ExchangeSummaryCard({
    required this.offerTitle,
    required this.offerImageUrl,
    required this.targetTitle,
    required this.targetImageUrl,
  });

  final String offerTitle;
  final String offerImageUrl;
  final String targetTitle;
  final String targetImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ItemStrings.inviteExchangeSummary,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      ItemStrings.inviteAwaitingResponse,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _ExchangeSideRow(
            label: ItemStrings.inviteYouOffered,
            title: offerTitle,
            imageUrl: offerImageUrl,
            labelColor: AppColors.accentGreen,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.swap_vert_rounded, size: 18.sp, color: AppColors.primaryDark),
              ),
            ),
          ),
          _ExchangeSideRow(
            label: ItemStrings.inviteYouRequested,
            title: targetTitle,
            imageUrl: targetImageUrl,
            labelColor: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }
}

class _ExchangeSideRow extends StatelessWidget {
  const _ExchangeSideRow({
    required this.label,
    required this.title,
    required this.imageUrl,
    this.labelColor,
  });

  final String label;
  final String title;
  final String imageUrl;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ExchangeThumbnail(imageUrl: imageUrl),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: labelColor ?? AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                title,
                style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExchangeThumbnail extends StatelessWidget {
  const _ExchangeThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 64.w,
        height: 64.w,
        color: AppColors.borderLight,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 64.w,
          height: 64.w,
          fit: BoxFit.cover,
          placeholder: (_, _) => Center(
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, _, _) => Icon(
            Icons.local_florist_outlined,
            size: 28.sp,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class _StatusTipCard extends StatelessWidget {
  const _StatusTipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFFD9E3F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.notifications_none_rounded, size: 20.sp, color: AppColors.accentGreen),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              ItemStrings.quickTipBody,
              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                height: 19 / 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
