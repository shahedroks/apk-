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
import '../widgets/auth_security_header.dart';
import '../widgets/check_email_illustration.dart';
import '../widgets/swap_auth_extras.dart';
import '../widgets/swap_primary_button.dart';

class CheckEmailScreen extends ConsumerWidget {
  const CheckEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seconds = ref.watch(resendTimerProvider);

    return SwapAuthScaffold(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthSecurityHeader(onBack: () => context.pop()),
          SizedBox(height: 12.h),
          const CheckEmailIllustration(),
          SizedBox(height: 18.h),
          Text(
            AppStrings.checkEmailTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.screenTitle(fontSize: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.checkEmailSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle(fontSize: 14.sp),
          ),
          SizedBox(height: 14.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
            decoration: BoxDecoration(
              color: AppColors.infoBackground,
              borderRadius: BorderRadius.circular(999.r),
              border: Border.all(color: AppColors.infoBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '@ ',
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Flexible(
                  child: Text(
                    email,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
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
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 4,
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
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.schedule_outlined,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.oneTimeLink,
                        style: AppTextStyles.label(fontSize: 14.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppStrings.oneTimeLinkBody,
                        style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          const _NextStepsCard(),
          SizedBox(height: 20.h),
          SwapPrimaryButton(
            label: AppStrings.openEmailApp,
            icon: Icons.mail_outline_rounded,
            iconAtStart: true,
            onPressed: () => showMockSnackBar(context, 'Opening mail app (mock)'),
          ),
          SizedBox(height: 12.h),
          SwapSecondaryButton(
            label: AppStrings.backToLogin,
            icon: Icons.arrow_back_rounded,
            onPressed: () => context.go(AppRouter.login),
          ),
          SizedBox(height: 22.h),
          Text.rich(
            TextSpan(
              style: AppTextStyles.subtitle(fontSize: 12.sp),
              children: [
                TextSpan(text: '${AppStrings.didntReceive} '),
                TextSpan(text: '${AppStrings.checkSpam} '),
                if (seconds > 0)
                  TextSpan(
                    text: '${AppStrings.resend} in ${seconds}s',
                    style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: GestureDetector(
                      onTap: () => ref.read(resendTimerProvider.notifier).resend(),
                      child: Text(
                        AppStrings.resend,
                        style: AppTextStyles.label(fontSize: 12.sp).copyWith(
                          color: AppColors.link,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 15.sp,
                color: AppColors.accentGreen,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  AppStrings.securedBy,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class _NextStepsCard extends StatelessWidget {
  const _NextStepsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.nextSteps,
                style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
                  letterSpacing: 0.6,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  AppStrings.step1of3,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const _StepRow(
            number: 1,
            active: true,
            title: AppStrings.step1Title,
            body: AppStrings.step1Body,
            showLine: true,
          ),
          const _StepRow(
            number: 2,
            active: false,
            title: AppStrings.step2Title,
            body: AppStrings.step2Body,
            showLine: true,
          ),
          const _StepRow(
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
                width: 30.w,
                height: 30.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : AppColors.infoBackground,
                  shape: BoxShape.circle,
                  border: active
                      ? null
                      : Border.all(color: AppColors.infoBorder),
                ),
                child: Text(
                  '$number',
                  style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                    color: active ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w700,
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
              padding: EdgeInsets.only(bottom: showLine ? 18.h : 0, top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.label(fontSize: 14.sp)),
                  SizedBox(height: 4.h),
                  Text(
                    body,
                    style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                      color: AppColors.textSecondary,
                      height: 1.3,
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
