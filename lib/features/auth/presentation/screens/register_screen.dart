import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/storage/auth_session.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_form_card.dart';
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await _authProvider.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!success || !mounted) return;
    await AuthSession.setLoggedIn(true);
    final profileSaved = await AuthSession.syncFirestoreProfile();
    if (!mounted) return;
    if (!profileSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created, but role was not saved yet. '
            'Publish Firestore rules in Firebase Console, then log in again.',
            style: AppTextStyles.subtitle(fontSize: 13.sp),
          ),
          backgroundColor: AppColors.primaryDark,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    context.go(AppRouter.home);
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
              style: AppTextStyles.screenTitle(fontSize: 24.sp).copyWith(
                color: AppColors.primary,
              ),
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
            AuthFormCard(
              child: Column(
                children: [
                  SwapTextField(
                    label: 'Full name',
                    controller: _nameController,
                    hintText: AppStrings.nameFieldHint,
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
                    hintText: AppStrings.emailFieldHint,
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
                    hintText: AppStrings.passwordFieldHint,
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
                  if (_authProvider.error != null) ...[
                    SizedBox(height: 12.h),
                    Text(
                      _authProvider.error!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  SwapPrimaryButton(
                    label: AppStrings.signUp,
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
                  '${AppStrings.haveAccount} ',
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRouter.login),
                  child: Text(
                    AppStrings.logIn,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      color: AppColors.link,
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
