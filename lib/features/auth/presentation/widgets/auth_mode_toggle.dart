import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';

enum AuthMode { login, signUp }

class AuthModeToggle extends StatelessWidget {
  const AuthModeToggle({
    super.key,
    required this.mode,
    required this.onLoginTap,
    required this.onSignUpTap,
  });

  final AuthMode mode;
  final VoidCallback onLoginTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.toggleTrack,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(
              label: AppStrings.logIn,
              icon: Icons.login_rounded,
              selected: mode == AuthMode.login,
              onTap: onLoginTap,
            ),
          ),
          Expanded(
            child: _Segment(
              label: AppStrings.signUp,
              icon: Icons.person_add_alt_1_rounded,
              selected: mode == AuthMode.signUp,
              onTap: onSignUpTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  color: selected ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
