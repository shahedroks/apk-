import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/home_strings.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../widgets/profile_widgets.dart';

class IncomingSwapOfferScreen extends StatelessWidget {
  const IncomingSwapOfferScreen({
    super.key,
    this.offerId,
    this.useReviewTitle = false,
  });

  final String? offerId;
  final bool useReviewTitle;

  static const _darkGreen = Color(0xFF0A2E22);
  static const _fairValueBg = Color(0xFFCAEAD6);
  static const _fairValueText = Color(0xFF042014);
  static const _verifiedBg = Color(0xFFBEEDD9);
  static const _verifiedText = Color(0xFF002117);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            _OfferHeader(
              title: useReviewTitle
                  ? HomeStrings.reviewOffer
                  : ProfileStrings.incomingSwapOffer,
              onBack: () => context.pop(),
            ),
            SizedBox(height: 16.h),
            _IncomingNotificationCard(),
            SizedBox(height: 16.h),
            _TradeBalanceCard(),
            SizedBox(height: 16.h),
            _NoteCard(),
            SizedBox(height: 16.h),
            _SafeExchangeCard(),
            SizedBox(height: 16.h),
            _ActionCenter(
              onAccept: () {
                showMockSnackBar(context, 'Swap accepted (mock data)');
                context.push(AppRouter.chat('c1', name: 'Marcus Chen'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferHeader extends StatelessWidget {
  const _OfferHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileCircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ProfileCircleButton(
          icon: Icons.more_vert,
          backgroundColor: AppColors.surface,
          onTap: () => showMockSnackBar(context, 'Offer options (mock)'),
        ),
        SizedBox(width: 8.w),
        const ProfileAvatar(
          radius: 18,
          imageUrl: ProfileStrings.profileAvatarUrl,
        ),
      ],
    );
  }
}

class _IncomingNotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      ProfileStrings.incomingProposal,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.schedule, size: 13.sp, color: AppColors.textSecondary),
              SizedBox(width: 4.w),
              Text(
                ProfileStrings.expires,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            ProfileStrings.receivedAndExchange,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          const _ProposerRow(),
        ],
      ),
    );
  }
}

class _ProposerRow extends StatelessWidget {
  const _ProposerRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const ProfileAvatar(
              radius: 24,
              imageUrl: ProfileStrings.profileAvatarUrl,
            ),
            Positioned(
              right: -4.w,
              bottom: -4.h,
              child: Container(
                width: 15.w,
                height: 15.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF00241A),
                  shape: BoxShape.circle,
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
        SizedBox(width: 8.w),
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
                      color: IncomingSwapOfferScreen._verifiedBg,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RoundedCheckMark(
                          size: 7.w,
                          color: IncomingSwapOfferScreen._verifiedText,
                          strokeWidth: 1.2.w,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          ProfileStrings.idVerified,
                          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                            fontWeight: FontWeight.w700,
                            color: IncomingSwapOfferScreen._verifiedText,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                ProfileStrings.offerProposerLocation,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Icon(Icons.star_rounded, size: 12.sp, color: AppColors.accentGreen),
                  SizedBox(width: 2.w),
                  Text(
                    ProfileStrings.offerRatingLine,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TradeBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                ProfileStrings.tradeBalanceMatrix,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: IncomingSwapOfferScreen._fairValueBg,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.balance,
                      size: 11.sp,
                      color: IncomingSwapOfferScreen._fairValueText,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      ProfileStrings.fairValue,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: IncomingSwapOfferScreen._fairValueText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  _TradeItemRow(
                    label: ProfileStrings.theyOfferFull,
                    labelColor: AppColors.accentGreen,
                    title: 'Audio-Technica LP60X Turntable',
                    conditionLine: 'Condition: ${ProfileStrings.likeNew}',
                    detail: ProfileStrings.turntableConditionDetail,
                    value: '~\$160',
                    imageUrl: ProfileStrings.offerTurntableImageUrl,
                    tag: 'Audio',
                  ),
                  SizedBox(height: 8.h),
                  _TradeItemRow(
                    label: ProfileStrings.youGiveFull,
                    labelColor: AppColors.textSecondary,
                    title: 'Keychron Q1 Pro Mechanical Keyboard',
                    conditionLine: 'Condition: ${ProfileStrings.likeNew}',
                    detail: ProfileStrings.keyboardConditionDetail,
                    value: '~\$170',
                    imageUrl: ProfileStrings.offerKeyboardImageUrl,
                    tag: 'Tech',
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 104.h,
                child: Center(
                  child: Container(
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
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      size: 16.sp,
                      color: AppColors.accentGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TradeItemRow extends StatelessWidget {
  const _TradeItemRow({
    required this.label,
    required this.labelColor,
    required this.title,
    required this.conditionLine,
    required this.detail,
    required this.value,
    required this.imageUrl,
    required this.tag,
  });

  final String label;
  final Color labelColor;
  final String title;
  final String conditionLine;
  final String detail;
  final String value;
  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ColoredBox(
                    color: AppColors.toggleTrack,
                    child: SizedBox(width: 80.w, height: 80.w),
                  ),
                  errorWidget: (context, url, error) => ColoredBox(
                    color: AppColors.toggleTrack,
                    child: SizedBox(width: 80.w, height: 80.w),
                  ),
                ),
              ),
              Positioned(
                left: 4.w,
                top: 4.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: IncomingSwapOfferScreen._darkGreen.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: labelColor,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
                Text(
                  conditionLine,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        detail,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Text(
                      value,
                      style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: IncomingSwapOfferScreen._darkGreen,
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

class _NoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.chat_bubble_outline, size: 15.sp, color: AppColors.textSecondary),
              SizedBox(width: 6.w),
              Text(
                ProfileStrings.noteFrom,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  ProfileStrings.marcusNote,
                  style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '14m ago',
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
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

class _SafeExchangeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, size: 16.sp, color: AppColors.accentGreen),
              SizedBox(width: 6.w),
              Text(
                ProfileStrings.safeExchangeHub,
                style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: IncomingSwapOfferScreen._fairValueBg,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  ProfileStrings.cctvMonitored,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: IncomingSwapOfferScreen._fairValueText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: ProfileStrings.offerMapImageUrl,
                  width: double.infinity,
                  height: 140.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 48.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.swap_horiz_rounded,
                        size: 18.sp,
                        color: IncomingSwapOfferScreen._darkGreen,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 12.w,
                  right: 12.w,
                  bottom: 12.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ProfileStrings.meetupPlace,
                            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          ProfileStrings.meetupDistance,
                          style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.event_outlined, size: 20.sp, color: IncomingSwapOfferScreen._darkGreen),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ProfileStrings.meetupWhen,
                        style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ProfileStrings.meetupWindow,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
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

class _ActionCenter extends StatelessWidget {
  const _ActionCenter({required this.onAccept});

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          elevation: 0,
          child: InkWell(
            onTap: onAccept,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 17.w,
                    height: 17.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: RoundedCheckMark(
                      size: 9.w,
                      color: AppColors.primary,
                      strokeWidth: 1.6.w,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    ProfileStrings.acceptSwap,
                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.chat_bubble_outline,
                label: ProfileStrings.messageMarcus,
                onTap: () => context.push(AppRouter.chat('c1', name: 'Marcus Chen')),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.tune_rounded,
                label: ProfileStrings.counterOffer,
                onTap: () => context.push('${AppRouter.proposeSwap}?itemId=4'),
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () => context.pop(),
          icon: Icon(Icons.close, size: 16.sp, color: const Color(0xFFBA1A1A)),
          label: Text(
            ProfileStrings.declineOffer,
            style: AppTextStyles.label(fontSize: 14.sp).copyWith(
              color: const Color(0xFFBA1A1A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16.sp, color: IncomingSwapOfferScreen._darkGreen),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: IncomingSwapOfferScreen._darkGreen,
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

Widget _whiteCard({required Widget child}) {
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
    child: child,
  );
}
