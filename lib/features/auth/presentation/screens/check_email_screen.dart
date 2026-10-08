import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../providers/resend_timer_provider.dart';
import '../widgets/swap_auth_extras.dart';
import '../widgets/swap_primary_button.dart';

class CheckEmailScreen extends ConsumerWidget {
  const CheckEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seconds = ref.watch(resendTimerProvider);

    return SwapAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 12.h),
          _CheckIllustration(),
          SizedBox(height: 20.h),
          Text(
            AppStrings.checkEmailTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle(fontSize: 22.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.checkEmailSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle(fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(color: AppColors.infoBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('@ ', style: AppTextStyles.label(fontSize: 14.sp)),
                Flexible(
                  child: Text(
                    email,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(14.w),
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
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.infoBackground,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.timer_outlined,
                    color: AppColors.primaryDark,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.oneTimeLink,
                        style: AppTextStyles.label(fontSize: 13.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppStrings.oneTimeLinkBody,
                        style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _NextStepsCard(),
          SizedBox(height: 20.h),
          SwapPrimaryButton(
            label: AppStrings.openEmailApp,
            icon: Icons.mail_outline,
            onPressed: () => showMockSnackBar(context, 'Opening mail app (mock)'),
          ),
          SizedBox(height: 12.h),
          SwapSecondaryButton(
            label: AppStrings.backToLogin,
            icon: Icons.arrow_back_rounded,
            onPressed: () => context.go(AppRouter.login),
          ),
          SizedBox(height: 20.h),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '${AppStrings.didntReceive} ',
                style: AppTextStyles.subtitle(fontSize: 12.sp),
              ),
              Text(
                AppStrings.checkSpam,
                style: AppTextStyles.subtitle(fontSize: 12.sp),
              ),
              if (seconds > 0)
                Text(
                  ' ${AppStrings.resend} in ${seconds}s',
                  style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                    color: AppColors.accentGreen,
                  ),
                )
              else
                GestureDetector(
                  onTap: () => ref.read(resendTimerProvider.notifier).resend(),
                  child: Text(
                    ' ${AppStrings.resend}',
                    style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                      color: AppColors.accentGreen,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user_outlined, size: 14.sp, color: AppColors.textMuted),
              SizedBox(width: 6.w),
              Text(
                AppStrings.securedBy,
                style: AppTextStyles.caption(fontSize: 11.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _CheckIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: AppColors.mintGlow.withValues(alpha: 0.45),
              shape: BoxShape.circle,
            ),
          ),
          Icon(
            Icons.mail_outline_rounded,
            size: 48.sp,
            color: AppColors.primaryDark,
          ),
          Positioned(
            right: MediaQuery.sizeOf(context).width * 0.28,
            bottom: 36.h,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: AppColors.accentLime,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 18.sp,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextStepsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.nextSteps,
                style: AppTextStyles.overline(fontSize: 10.sp),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  AppStrings.step1of3,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _StepRow(
            number: 1,
            active: true,
            title: AppStrings.step1Title,
            body: AppStrings.step1Body,
            showLine: true,
          ),
          _StepRow(
            number: 2,
            active: false,
            title: AppStrings.step2Title,
            body: AppStrings.step2Body,
            showLine: true,
          ),
          _StepRow(
            number: 3,
            active: false,
            title: AppStrings.step3Title,
            body: AppStrings.step3Body,
            showLine: false,
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.active,
    required this.title,
    required this.body,
    required this.showLine,
  });

  final int number;
  final bool active;
  final String title;
  final String body;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : AppColors.infoBorder,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                    color: active ? Colors.white : AppColors.textMuted,
                  ),
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: AppColors.infoBorder,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: showLine ? 16.h : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.label(fontSize: 13.sp)),
                  SizedBox(height: 2.h),
                  Text(
                    body,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      color: AppColors.textSecondary,
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
