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
import '../widgets/auth_form_card.dart';
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
              style: AppTextStyles.screenTitle(fontSize: 24.sp).copyWith(
                color: AppColors.primary,
              ),
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
            AuthFormCard(
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
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: Checkbox(
                                value: ui.rememberMe,
                                activeColor: AppColors.primary,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                side: const BorderSide(color: AppColors.textMuted),
                                onChanged: (value) => ref
                                    .read(loginUiProvider.notifier)
                                    .toggleRememberMe(value),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(
                                AppStrings.rememberMe,
                                style: AppTextStyles.subtitle(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push(AppRouter.forgotPassword),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
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
                    iconAtEnd: true,
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
