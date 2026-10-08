import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../widgets/profile_widgets.dart';

class IncomingSwapOfferScreen extends StatelessWidget {
  const IncomingSwapOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            Row(
              children: [
                ProfileCircleButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    ProfileStrings.incomingSwapOffer,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle(fontSize: 17.sp),
                  ),
                ),
                ProfileCircleButton(
                  icon: Icons.more_vert,
                  backgroundColor: AppColors.surface,
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.mintGlow.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.accentLime.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.accentLime,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          ProfileStrings.incomingProposal,
                          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ProfileStrings.expires,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    ProfileStrings.receivedAgo,
                    style: AppTextStyles.subtitle(fontSize: 13.sp),
                  ),
                  Text(
                    ProfileStrings.directExchange,
                    style: AppTextStyles.caption(fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            _ProposerCard(),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.infoBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                ProfileStrings.fairValue,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            _TradeItemCard(
              label: ProfileStrings.theyOffer,
              title: 'Audio-Technica LP60X Turntable',
              tag: 'Audio',
              value: '~\$160',
              color: const Color(0xFF37474F),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.swap_vert_rounded,
                  color: AppColors.primaryDark,
                  size: 20.sp,
                ),
              ),
            ),
            _TradeItemCard(
              label: ProfileStrings.youGiveListing,
              title: 'Keychron Q1 Pro Mechanical Keyboard',
              tag: 'Tech',
              value: '~\$170',
              color: const Color(0xFF5C6BC0),
            ),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ProfileStrings.noteFrom,
                    style: AppTextStyles.overline(fontSize: 10.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    ProfileStrings.marcusNote,
                    style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '14m ago',
                    style: AppTextStyles.caption(fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  ProfileStrings.safeExchangeHub,
                  style: AppTextStyles.label(fontSize: 15.sp),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    ProfileStrings.cctvMonitored,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                height: 120.h,
                color: AppColors.infoBorder,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 48.sp,
                        color: AppColors.textMuted.withValues(alpha: 0.5),
                      ),
                    ),
                    Positioned(
                      bottom: 12.h,
                      left: 12.w,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ProfileStrings.meetupPlace,
                              style: AppTextStyles.label(fontSize: 13.sp),
                            ),
                            Text(
                              ProfileStrings.meetupDistance,
                              style: AppTextStyles.caption(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  Icon(Icons.event_outlined, color: AppColors.primary, size: 22.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProfileStrings.meetupWhen,
                          style: AppTextStyles.label(fontSize: 14.sp),
                        ),
                        Text(
                          ProfileStrings.meetupWindow,
                          style: AppTextStyles.caption(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SwapPrimaryButton(
              label: ProfileStrings.acceptSwap,
              icon: Icons.check_rounded,
              onPressed: () {
                showMockSnackBar(context, 'Swap accepted (mock data)');
                context.push(AppRouter.chat('c1', name: 'Marcus Chen'));
              },
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.push(AppRouter.chat('c1', name: 'Marcus Chen')),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 48.h),
                      backgroundColor: AppColors.infoBackground,
                      side: const BorderSide(color: AppColors.infoBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      ProfileStrings.messageMarcus,
                      style: AppTextStyles.label(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.push('${AppRouter.proposeSwap}?itemId=4'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 48.h),
                      backgroundColor: AppColors.infoBackground,
                      side: const BorderSide(color: AppColors.infoBorder),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      ProfileStrings.counterOffer,
                      style: AppTextStyles.label(fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => context.pop(),
              icon: Icon(Icons.close, size: 18.sp, color: AppColors.error),
              label: Text(
                ProfileStrings.declineOffer,
                style: TextStyle(color: AppColors.error, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProposerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          const ProfileAvatar(radius: 24),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      ProfileStrings.marcusChen,
                      style: AppTextStyles.label(fontSize: 14.sp),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.mintGlow,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        ProfileStrings.idVerified,
                        style: AppTextStyles.caption(fontSize: 9.sp).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  ProfileStrings.location,
                  style: AppTextStyles.caption(fontSize: 11.sp),
                ),
                Text(
                  ProfileStrings.ratingSwaps,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w700,
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

class _TradeItemCard extends StatelessWidget {
  const _TradeItemCard({
    required this.label,
    required this.title,
    required this.tag,
    required this.value,
    required this.color,
  });

  final String label;
  final String title;
  final String tag;
  final String value;
  final Color color;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: ColoredBox(
              color: color,
              child: SizedBox(
                width: 72.w,
                height: 72.w,
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(title, style: AppTextStyles.label(fontSize: 13.sp)),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    _pill(ProfileStrings.likeNew),
                    SizedBox(width: 6.w),
                    _pill(tag),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption(fontSize: 9.sp),
      ),
    );
  }
}
