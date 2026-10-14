import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/extra_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../widgets/swap_completed_widgets.dart';

class SwapCompletedScreen extends StatelessWidget {
  const SwapCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SwapCompletedTopBar(
              onBack: () => context.pop(),
              onMenu: () => showMockSnackBar(context, 'Options (mock)'),
              onProfile: () => context.push(AppRouter.profile),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                children: [
                  const SwapCompletedCelebrationHeader(),
                  SizedBox(height: 24.h),
                  const SwapCompletedExchangeRow(),
                  SizedBox(height: 24.h),
                  const SwapEnvironmentalImpactCard(),
                  SizedBox(height: 24.h),
                  const SwapRatingCard(),
                  SizedBox(height: 16.h),
                  const SwapDigitalReceiptCard(),
                  SizedBox(height: 24.h),
                  SwapPrimaryButton(
                    label: ExtraStrings.rateReview,
                    onPressed: () => context.push(AppRouter.reviews),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: OutlinedButton.icon(
                      onPressed: () => showMockSnackBar(context, 'Impact story shared (mock)'),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.borderLight,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      icon: Icon(Icons.ios_share, size: 16.sp, color: AppColors.primaryDark),
                      label: Text(
                        ExtraStrings.shareImpact,
                        style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: TextButton(
                      onPressed: () => context.go(AppRouter.home),
                      child: Text(
                        ExtraStrings.returnHome,
                        style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
