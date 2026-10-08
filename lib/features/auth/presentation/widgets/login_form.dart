import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../providers/auth_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.authProvider,
    required this.onLoginSuccess,
  });

  final AuthProvider authProvider;
  final VoidCallback onLoginSuccess;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await widget.authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success && mounted) {
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _emailController,
            label: AppStrings.email,
            validator: Validators.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            label: AppStrings.password,
            validator: Validators.password,
            obscureText: true,
          ),
          if (widget.authProvider.error != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.authProvider.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 24),
          CustomButton(
            label: AppStrings.login,
            isLoading: widget.authProvider.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
