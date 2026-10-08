import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../providers/login_ui_provider.dart';
import '../widgets/auth_mode_toggle.dart';
import '../widgets/swap_auth_extras.dart';
import '../widgets/swap_brand_header.dart';
import '../widgets/swap_primary_button.dart';
import '../widgets/swap_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'sara.miller@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  late final AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = AuthProvider();
    _authProvider.addListener(_onAuthChanged);
  }

  void _onAuthChanged() => setState(() {});

  @override
  void dispose() {
    _authProvider.removeListener(_onAuthChanged);
    _authProvider.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await _authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success && mounted) {
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(loginUiProvider);

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
              AppStrings.welcomeBack,
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle(fontSize: 22.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.welcomeSignInSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.subtitle(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            AuthModeToggle(
              mode: AuthMode.login,
              onLoginTap: () {},
              onSignUpTap: () => context.go(AppRouter.register),
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
                    label: AppStrings.emailAddress,
                    trailingLabel: AppStrings.directVerified,
                    controller: _emailController,
                    hintText: 'sara.miller@example.com',
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
                    obscureText: ui.obscurePassword,
                    validator: Validators.password,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => ref
                          .read(loginUiProvider.notifier)
                          .togglePasswordVisibility(),
                      icon: Icon(
                        ui.obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: Checkbox(
                              value: ui.rememberMe,
                              activeColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.textMuted),
                              onChanged: (value) => ref
                                  .read(loginUiProvider.notifier)
                                  .toggleRememberMe(value),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppStrings.rememberMe,
                            style: AppTextStyles.subtitle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () =>
                            context.push(AppRouter.forgotPassword),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_authProvider.error != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      _authProvider.error!,
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  SwapPrimaryButton(
                    label: AppStrings.logIn,
                    icon: Icons.arrow_forward_rounded,
                    isLoading: _authProvider.isLoading,
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
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${AppStrings.noAccount} ',
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRouter.register),
                  child: Text(
                    AppStrings.signUp,
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
