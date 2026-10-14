import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../data/match_mock_data.dart';
import '../widgets/match_detail_widgets.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({super.key, this.matchId});

  final String? matchId;

  @override
  Widget build(BuildContext context) {
    final detail = MatchMockData.detailFor(matchId);
    final metrics = MatchMockData.elenaMetrics;
    final firstName = detail.partnerName.split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            MatchDetailTopBar(
              onBack: () => context.pop(),
              onMenu: () => showMockSnackBar(context, 'Match options (mock)'),
              onProfile: () => context.push(AppRouter.profile),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                children: [
                  MatchCompatibilityHero(percent: detail.matchPercent),
                  SizedBox(height: 24.h),
                  MatchInspectionSection(detail: detail),
                  SizedBox(height: 16.h),
                  MatchPartnerBar(
                    name: detail.partnerName,
                    avatarUrl: detail.avatarUrl,
                    rating: detail.rating,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Text(
                        MatchStrings.compatibilityFactors,
                        style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        MatchStrings.metricsMetShort,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ...metrics.map((m) => MatchDetailFactorRow(metric: m)),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MatchDetailBottomBar(
        partnerFirstName: firstName,
        onPropose: () => context.push(AppRouter.swapInvitationSent),
        onMessage: () => context.push(AppRouter.chat('c2', name: detail.partnerName)),
        onDecline: () => context.pop(),
      ),
    );
  }
}
