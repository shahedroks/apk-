import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_mode_toggle.dart';
import '../widgets/swap_auth_extras.dart';
import '../widgets/swap_brand_header.dart';
import '../widgets/swap_primary_button.dart';
import '../widgets/swap_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.go(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwapAuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.h),
            const Center(child: SwapBrandHeader()),
            SizedBox(height: 16.h),
            Text(
              AppStrings.createAccount,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle(fontSize: 22.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.signUpSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.subtitle(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            AuthModeToggle(
              mode: AuthMode.signUp,
              onLoginTap: () => context.go(AppRouter.login),
              onSignUpTap: () {},
            ),
            SizedBox(height: 16.h),
            Container(
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
              child: Column(
                children: [
                  SwapTextField(
                    label: 'Full name',
                    controller: _nameController,
                    hintText: 'Alex Chen',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Name is required' : null,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SwapTextField(
                    label: AppStrings.emailAddress,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SwapTextField(
                    label: AppStrings.password,
                    trailingLabel: AppStrings.passwordHint,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: Validators.password,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SwapPrimaryButton(
                    label: AppStrings.signUp,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const SwapDividerLabel(),
            SizedBox(height: 16.h),
            const SwapSocialButtons(),
            SizedBox(height: 20.h),
            const SwapStatsBanner(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${AppStrings.haveAccount} ',
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRouter.login),
                  child: Text(
                    AppStrings.logIn,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      color: AppColors.accentGreen,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
