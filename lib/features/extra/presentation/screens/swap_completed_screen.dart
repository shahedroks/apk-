import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../../profile/presentation/widgets/profile_widgets.dart';

class SwapCompletedScreen extends StatelessWidget {
  const SwapCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(ExtraStrings.swapCompleted, style: AppTextStyles.screenTitle(fontSize: 16.sp)),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRouter.profile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, size: 44.sp, color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user_outlined, size: 16.sp, color: AppColors.accentGreen),
                SizedBox(width: 6.w),
                Text(ExtraStrings.handshakeVerified, style: AppTextStyles.caption(fontSize: 11.sp)),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            ExtraStrings.swapSuccessTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle(fontSize: 20.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            ExtraStrings.swapSuccessBody,
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle(fontSize: 14.sp),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(child: _tradeCard('Keychron Q1 Pro', ExtraStrings.given, ExtraStrings.yourItem, const Color(0xFF5C6BC0))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(ExtraStrings.direct, style: AppTextStyles.caption(fontSize: 8.sp)),
                    ),
                    Icon(Icons.swap_horiz, color: AppColors.primary),
                  ],
                ),
              ),
              Expanded(child: _tradeCard('AT-LP60X Player', ExtraStrings.received, ExtraStrings.marcusChen, const Color(0xFF37474F))),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      ExtraStrings.envImpact,
                      style: AppTextStyles.label(fontSize: 15.sp).copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(ExtraStrings.verified, style: AppTextStyles.caption(fontSize: 9.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _impactRow(Icons.cloud_outlined, ExtraStrings.co2Diverted, ExtraStrings.co2Sub),
                _impactRow(Icons.delete_outline, ExtraStrings.landfill, ExtraStrings.landfillSub),
                _impactRow(Icons.attach_money, ExtraStrings.zeroCash, ExtraStrings.zeroCashSub),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const ProfileAvatar(radius: 22),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ExtraStrings.marcusChen, style: AppTextStyles.label(fontSize: 14.sp)),
                    Text('Co-Swapper', style: AppTextStyles.caption(fontSize: 11.sp)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(ExtraStrings.rateExperience, style: AppTextStyles.subtitle(fontSize: 13.sp)),
          Row(
            children: List.generate(5, (_) => Icon(Icons.star_border, color: AppColors.accentLime, size: 28.sp)),
          ),
          Text(ExtraStrings.rateTraits, style: AppTextStyles.caption(fontSize: 11.sp)),
          SizedBox(height: 16.h),
          _receiptCard(),
          SizedBox(height: 20.h),
          SwapPrimaryButton(
            label: ExtraStrings.rateReview,
            onPressed: () => context.push(AppRouter.reviews),
          ),
          SizedBox(height: 10.h),
          SwapPrimaryButton(
            label: ExtraStrings.shareImpact,
            icon: Icons.ios_share,
            onPressed: () => showMockSnackBar(context, 'Impact story shared (mock)'),
          ),
          TextButton(
            onPressed: () => context.go(AppRouter.home),
            child: Text(ExtraStrings.returnHome),
          ),
        ],
      ),
    );
  }

  Widget _tradeCard(String title, String tag, String sub, Color color) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: ColoredBox(color: color, child: SizedBox(height: 90.h, width: double.infinity)),
            ),
            Positioned(
              left: 8.w,
              top: 8.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                color: AppColors.surface.withValues(alpha: 0.9),
                child: Text(tag, style: AppTextStyles.caption(fontSize: 9.sp)),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(title, textAlign: TextAlign.center, style: AppTextStyles.label(fontSize: 12.sp)),
        Text(sub, style: AppTextStyles.caption(fontSize: 10.sp)),
      ],
    );
  }

  Widget _impactRow(IconData icon, String title, String sub) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentLime, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.label(fontSize: 14.sp).copyWith(color: AppColors.accentLime)),
                Text(sub, style: AppTextStyles.caption(fontSize: 11.sp).copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _receiptCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ExtraStrings.digitalReceipt, style: AppTextStyles.label(fontSize: 14.sp)),
          SizedBox(height: 8.h),
          Text('SWAP ID: SWP-92841', style: AppTextStyles.caption(fontSize: 11.sp)),
          Text('VERIFIED: Today, 4:12 PM', style: AppTextStyles.caption(fontSize: 11.sp)),
          Text('LOCATION: McCarren Park Plaza', style: AppTextStyles.caption(fontSize: 11.sp)),
          Text('BILATERAL CHECK: ✓ ✓', style: AppTextStyles.caption(fontSize: 11.sp)),
        ],
      ),
    );
  }
}
