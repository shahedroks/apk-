import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_form_card.dart';
import '../widgets/auth_security_header.dart';
import '../widgets/forgot_password_illustration.dart';
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
  final _emailController = TextEditingController();
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
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final success = await _authProvider.sendPasswordReset(email);
    if (!success || !mounted) return;
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
            AuthSecurityHeader(onBack: () => context.pop()),
            SizedBox(height: 16.h),
            AuthFormCard(
              child: Column(
                children: [
                  const ForgotPasswordIllustration(),
                  SizedBox(height: 12.h),
                  Text(
                    AppStrings.forgotPasswordTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle(fontSize: 22.sp).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppStrings.forgotPasswordBody,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                      height: 1.45,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SwapTextField(
                    label: AppStrings.email,
                    controller: _emailController,
                    hintText: AppStrings.emailFieldHint,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    helperText: AppStrings.registryHint,
                    fillColor: AppColors.infoBackground,
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      size: 20.sp,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const SwapInfoBox(
                    title: AppStrings.fastRecovery,
                    body: AppStrings.fastRecoveryBody,
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
                    label: AppStrings.sendResetLink,
                    icon: Icons.arrow_forward_rounded,
                    iconAtEnd: true,
                    isLoading: _authProvider.isLoading,
                    onPressed: _sendResetLink,
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 16.sp,
                  color: AppColors.accentGreen,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    AppStrings.securedInfra,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  size: 16.sp,
                  color: AppColors.textMuted,
                ),
                SizedBox(width: 6.w),
                Text(
                  '${AppStrings.rememberPassword} ',
                  style: AppTextStyles.subtitle(fontSize: 13.sp),
                ),
                GestureDetector(
                  onTap: () => context.go(AppRouter.login),
                  child: Text(
                    AppStrings.backToLogin,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      color: AppColors.link,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
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
