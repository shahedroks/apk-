import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/match_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../home/presentation/widgets/home_top_bar.dart';
import '../../data/match_mock_data.dart';
import '../providers/match_ui_provider.dart';
import '../widgets/match_widgets.dart';

class MyMatchesScreen extends ConsumerWidget {
  const MyMatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(matchFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          children: [
            HomeTopBar(
              title: MatchStrings.myMatches,
              onProfileTap: () => context.push(AppRouter.profile),
              onNotificationTap: () => context.push(AppRouter.notifications),
            ),
            SizedBox(height: 14.h),
            MatchSummaryBanner(
              onRecalculate: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recalculating matches...')),
                );
              },
            ),
            SizedBox(height: 14.h),
            MatchFilterChips(
              selectedIndex: filter,
              onSelected: (i) => ref.read(matchFilterProvider.notifier).state = i,
            ),
            SizedBox(height: 16.h),
            ...MatchMockData.matches.map(
              (match) => MatchCard(
                match: match,
                onDetails: () => context.push(AppRouter.match(match.id)),
                onPropose: () => context.push(
                  '${AppRouter.proposeSwap}?itemId=4',
                ),
                onSecondary: match.secondaryAction == MatchStrings.dismiss
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Dismissed ${match.partnerName}')),
                        );
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
