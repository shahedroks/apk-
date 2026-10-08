import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../data/match_mock_data.dart';
import '../widgets/match_widgets.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({super.key, this.matchId});

  final String? matchId;

  SwapMatchSummary get _match {
    return MatchMockData.matches.firstWhere(
      (m) => m.id == matchId,
      orElse: () => MatchMockData.elenaDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    final match = _match;
    final metrics = MatchMockData.elenaMetrics;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(MatchStrings.matchDetails, style: AppTextStyles.screenTitle(fontSize: 17.sp)),
        actions: [
          IconButton(
            onPressed: () => showMockSnackBar(context, 'Match options (mock)'),
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(onPressed: () => context.push(AppRouter.profile), icon: const Icon(Icons.person_outline)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MatchScoreRing(percent: match.matchPercent),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MatchStrings.highCompatibility,
                        style: AppTextStyles.overline(fontSize: 10.sp).copyWith(
                          color: AppColors.accentLime,
                        ),
                      ),
                      Text(
                        MatchStrings.exceptionalMatch,
                        style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        MatchStrings.exceptionalBody,
                        style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              _metaChip(Icons.near_me_outlined, MatchStrings.distance),
              _metaChip(Icons.location_on_outlined, MatchStrings.safeHub),
              _metaChip(Icons.verified_outlined, MatchStrings.verifiedZone, lime: true),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(MatchStrings.inspectionView, style: AppTextStyles.label(fontSize: 15.sp)),
              const Spacer(),
              Icon(Icons.sync, size: 16.sp, color: AppColors.textMuted),
              SizedBox(width: 4.w),
              Text(MatchStrings.equitableValue, style: AppTextStyles.caption(fontSize: 11.sp)),
            ],
          ),
          SizedBox(height: 10.h),
          _InspectionCard(match: match),
          SizedBox(height: 12.h),
          _SwapperBar(name: match.partnerName),
          SizedBox(height: 20.h),
          Text(
            '${MatchStrings.compatibilityFactors} ${MatchStrings.metricsMet}',
            style: AppTextStyles.label(fontSize: 14.sp),
          ),
          SizedBox(height: 12.h),
          ...metrics.map((m) => CompatibilityFactorRow(metric: m)),
          SizedBox(height: 80.h),
        ],
      ),
      bottomNavigationBar: _BottomActions(partnerName: match.partnerName.split(' ').first),
    );
  }

  Widget _metaChip(IconData icon, String label, {bool lime = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: lime ? AppColors.accentLime.withValues(alpha: 0.35) : AppColors.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.primary),
          SizedBox(width: 4.w),
          Text(label, style: AppTextStyles.caption(fontSize: 11.sp)),
        ],
      ),
    );
  }
}

class _InspectionCard extends StatelessWidget {
  const _InspectionCard({required this.match});

  final SwapMatchSummary match;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _itemCol('Your Offer', match.youOfferTitle, match.youColor, 'Good Condition', '\$140 - \$160')),
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Icon(Icons.swap_horiz, color: AppColors.accentLime, size: 28.sp),
          ),
          Expanded(
            child: _itemCol('Requested', match.theyOfferTitle, match.theyColor, 'Rooted Cutting', '\$150 - \$170'),
          ),
        ],
      ),
    );
  }

  Widget _itemCol(
    String label,
    String title,
    Color color,
    String badge,
    String tier,
  ) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: ColoredBox(
            color: color,
            child: SizedBox(width: double.infinity, height: 100.h),
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColors.infoBackground,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(badge, style: AppTextStyles.caption(fontSize: 9.sp)),
        ),
        SizedBox(height: 4.h),
        Text(title, textAlign: TextAlign.center, style: AppTextStyles.label(fontSize: 12.sp)),
        Text('Tier $tier', style: AppTextStyles.caption(fontSize: 10.sp)),
        Text('Seeking: swaps', style: AppTextStyles.caption(fontSize: 9.sp)),
      ],
    );
  }
}

class _SwapperBar extends StatelessWidget {
  const _SwapperBar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(child: Text(name.substring(0, 1))),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTextStyles.label(fontSize: 14.sp)),
                    SizedBox(width: 4.w),
                    Icon(Icons.verified, size: 16.sp, color: AppColors.accentGreen),
                  ],
                ),
                Text(MatchStrings.topSwapper, style: AppTextStyles.caption(fontSize: 11.sp)),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, size: 16.sp, color: AppColors.accentLime),
              Text('5.0', style: AppTextStyles.label(fontSize: 13.sp)),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.partnerName});

  final String partnerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwapPrimaryButton(
              label: MatchStrings.proposeOneTap,
              icon: Icons.eco_outlined,
              onPressed: () => context.push('${AppRouter.proposeSwap}?itemId=4'),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(AppRouter.chat('c1', name: partnerName)),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: Text('${MatchStrings.message} $partnerName'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.infoBackground,
                      minimumSize: Size(0, 44.h),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(MatchStrings.declineMatch),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
