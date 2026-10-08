import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../data/item_mock_data.dart';

class AddItemSuccessScreen extends StatelessWidget {
  const AddItemSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 88.w,
                height: 88.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded, size: 48.sp, color: AppColors.primaryDark),
              ),
              SizedBox(height: 20.h),
              Text(
                ItemStrings.successTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.screenTitle(fontSize: 24.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                ItemStrings.successBody,
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle(fontSize: 14.sp),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ColoredBox(
                        color: const Color(0xFF78909C),
                        child: SizedBox(width: 56.w, height: 56.w),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olympus 35mm Film Camera',
                            style: AppTextStyles.label(fontSize: 14.sp),
                          ),
                          Text('Electronics • Active', style: AppTextStyles.caption(fontSize: 11.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.infoBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ItemStrings.quickTip, style: AppTextStyles.label(fontSize: 13.sp)),
                    Text(ItemStrings.quickTipBody, style: AppTextStyles.caption(fontSize: 12.sp)),
                  ],
                ),
              ),
              const Spacer(),
              SwapPrimaryButton(
                label: ItemStrings.viewListing,
                onPressed: () => context.push(AppRouter.item(ItemMockData.defaultItemId)),
              ),
              TextButton(
                onPressed: () => context.go(AppRouter.home),
                child: Text(ItemStrings.backToDiscover),
              ),
              TextButton(
                onPressed: () => showMockSnackBar(context, 'Listing shared (mock)'),
                child: Text(ItemStrings.shareListing),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
