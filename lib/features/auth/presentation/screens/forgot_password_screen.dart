import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/swap_auth_extras.dart';
import '../widgets/swap_primary_button.dart';
import '../widgets/swap_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'eco.trader@swapit.com');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetLink() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    context.push('${AppRouter.checkEmail}?email=${Uri.encodeComponent(email)}');
  }

  @override
  Widget build(BuildContext context) {
    return SwapAuthScaffold(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _CircleBackButton(onTap: () => context.pop()),
                const Spacer(),
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  AppStrings.accountSecurity,
                  style: AppTextStyles.overline(fontSize: 10.sp),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(20.w),
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
                children: [
                  _EnvelopeIllustration(),
                  SizedBox(height: 16.h),
                  Text(
                    AppStrings.forgotPasswordTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle(fontSize: 20.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppStrings.forgotPasswordBody,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle(fontSize: 13.sp),
                  ),
                  SizedBox(height: 20.h),
                  SwapTextField(
                    label: AppStrings.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    helperText: AppStrings.registryHint,
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const SwapInfoBox(
                    title: AppStrings.fastRecovery,
                    body: AppStrings.fastRecoveryBody,
                  ),
                  SizedBox(height: 20.h),
                  SwapPrimaryButton(
                    label: AppStrings.sendResetLink,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _sendResetLink,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14.sp, color: AppColors.textMuted),
                SizedBox(width: 6.w),
                Flexible(
                  child: Text(
                    AppStrings.securedInfra,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(fontSize: 11.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.rememberPassword} ',
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRouter.login),
                  child: Text(
                    AppStrings.backToLogin,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      color: AppColors.accentGreen,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  const _CircleBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.borderLight,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _EnvelopeIllustration extends StatelessWidget {
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
              color: AppColors.mintGlow.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.accentLime,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: 36.sp,
              color: AppColors.primaryDark,
            ),
          ),
          Positioned(
            right: 72.w,
            bottom: 28.h,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.vpn_key_outlined, size: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
