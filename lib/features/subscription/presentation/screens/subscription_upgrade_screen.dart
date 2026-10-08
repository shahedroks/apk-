import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/subscription_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../data/subscription_mock_data.dart';
import '../providers/subscription_ui_provider.dart';
import '../widgets/subscription_widgets.dart';

class SubscriptionUpgradeScreen extends ConsumerWidget {
  const SubscriptionUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billing = ref.watch(upgradeBillingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            const SubscriptionTopBar(title: '01 Subscription Upgrade'),
            const MembershipChip(label: '${SubscriptionStrings.currentPlanChip} · ${SubscriptionStrings.freeSwapper}'),
            SizedBox(height: 12.h),
            const DarkGradientHeroCard(
              topChip: SubscriptionStrings.circularMembership,
              title: SubscriptionStrings.upgradeHeroTitle,
              body: SubscriptionStrings.upgradeHeroBody,
            ),
            SizedBox(height: 20.h),
            BillingCadenceToggle(
              selectedIndex: billing,
              onChanged: (i) => ref.read(upgradeBillingProvider.notifier).state = i,
            ),
            SizedBox(height: 20.h),
            Text(SubscriptionStrings.premiumCorePerks, style: AppTextStyles.label(fontSize: 16.sp)),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(child: _perkCard(
                  Icons.speed_rounded,
                  SubscriptionStrings.unlimitedTradeVelocity,
                  SubscriptionStrings.unlimitedTradeVelocitySub,
                )),
                SizedBox(width: 10.w),
                Expanded(child: _perkCard(
                  Icons.handshake_outlined,
                  SubscriptionStrings.zeroFlatFriction,
                  SubscriptionStrings.zeroFlatFrictionSub,
                )),
              ],
            ),
            SizedBox(height: 20.h),
            Text(SubscriptionStrings.planComparison, style: AppTextStyles.label(fontSize: 16.sp)),
            SizedBox(height: 10.h),
            _comparisonTable(),
            SizedBox(height: 16.h),
            _testimonialCard(),
            SizedBox(height: 20.h),
            SwapPrimaryButton(
              label: SubscriptionStrings.upgradeCta,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.push(AppRouter.choosePlan),
            ),
            SizedBox(height: 8.h),
            Text(
              SubscriptionStrings.autoRenewNote,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption(fontSize: 11.sp),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _perkCard(IconData icon, String title, String sub) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22.sp),
          SizedBox(height: 8.h),
          Text(title, style: AppTextStyles.label(fontSize: 12.sp)),
          SizedBox(height: 4.h),
          Text(sub, style: AppTextStyles.caption(fontSize: 10.sp)),
        ],
      ),
    );
  }

  Widget _comparisonTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  child: Text(
                    SubscriptionStrings.colFree,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(fontSize: 11.sp),
                  ),
                ),
                Expanded(
                  child: Text(
                    SubscriptionStrings.colPremium,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          ...SubscriptionMockData.comparison.map(
            (row) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(row.label, style: AppTextStyles.subtitle(fontSize: 12.sp)),
                  ),
                  Expanded(
                    child: Text(
                      row.free,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption(fontSize: 11.sp),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.premium,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentGreen,
                      ),
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

  Widget _testimonialCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 20, backgroundColor: AppColors.infoBackground),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (_) => Icon(Icons.star_rounded, size: 14.sp, color: Colors.amber),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  SubscriptionStrings.testimonialQuote,
                  style: AppTextStyles.subtitle(fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  '— ${SubscriptionStrings.testimonialAuthor}',
                  style: AppTextStyles.caption(fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
