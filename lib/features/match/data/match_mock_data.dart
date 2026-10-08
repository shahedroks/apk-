import 'package:flutter/material.dart';

import '../../../core/constants/match_strings.dart';

class SwapMatchSummary {
  const SwapMatchSummary({
    required this.id,
    required this.partnerName,
    required this.isPro,
    required this.activeLabel,
    required this.matchPercent,
    required this.youOfferTitle,
    required this.theyOfferTitle,
    required this.youColor,
    required this.theyColor,
    required this.reason,
    required this.secondaryAction,
  });

  final String id;
  final String partnerName;
  final bool isPro;
  final String activeLabel;
  final int matchPercent;
  final String youOfferTitle;
  final String theyOfferTitle;
  final Color youColor;
  final Color theyColor;
  final String reason;
  final String secondaryAction;
}

class CompatibilityMetric {
  const CompatibilityMetric({
    required this.title,
    required this.percent,
    required this.detail,
    required this.icon,
  });

  final String title;
  final int percent;
  final String detail;
  final IconData icon;
}

class MatchMockData {
  MatchMockData._();

  static const String defaultMatchId = 'm1';

  static final List<SwapMatchSummary> matches = [
    SwapMatchSummary(
      id: 'm1',
      partnerName: 'Marcus Chen',
      isPro: true,
      activeLabel: 'Active 10m ago',
      matchPercent: 92,
      youOfferTitle: 'Custom Mech Keyboard',
      theyOfferTitle: 'Audio Pro Turntable',
      youColor: Color(0xFF5C6BC0),
      theyColor: Color(0xFF37474F),
      reason:
          'He wants your keyboard & has the turntable you requested in your wishlist.',
      secondaryAction: MatchStrings.details,
    ),
    SwapMatchSummary(
      id: 'm2',
      partnerName: 'Elena Alvarez',
      isPro: false,
      activeLabel: 'Active 1h ago',
      matchPercent: 94,
      youOfferTitle: 'Olympus 35mm RC',
      theyOfferTitle: 'Monstera Albo Cutting',
      youColor: Color(0xFF78909C),
      theyColor: Color(0xFF66BB6A),
      reason:
          'Perfect category synergy — photography gear for home & plant swaps.',
      secondaryAction: MatchStrings.details,
    ),
    SwapMatchSummary(
      id: 'm3',
      partnerName: 'Jordan Lee',
      isPro: false,
      activeLabel: 'Active 3h ago',
      matchPercent: 81,
      youOfferTitle: 'Desk Lamp',
      theyOfferTitle: 'Ceramic Planters Set',
      youColor: Color(0xFFD4A574),
      theyColor: Color(0xFF8D6E63),
      reason: 'Nearby swapper with complementary home goods preferences.',
      secondaryAction: MatchStrings.dismiss,
    ),
  ];

  static SwapMatchSummary get elenaDetail => matches[1];

  static const List<CompatibilityMetric> elenaMetrics = [
    CompatibilityMetric(
      title: MatchStrings.categorySynergy,
      percent: 100,
      detail: 'Photography ↔ Home & Plant crossover in your wishlist.',
      icon: Icons.favorite_border,
    ),
    CompatibilityMetric(
      title: MatchStrings.valueBalance,
      percent: 95,
      detail: 'Tier overlap \$140–\$160 on both sides.',
      icon: Icons.balance,
    ),
    CompatibilityMetric(
      title: MatchStrings.proximity,
      percent: 98,
      detail: '0.8 mi • McCarren verified hub available.',
      icon: Icons.near_me_outlined,
    ),
    CompatibilityMetric(
      title: MatchStrings.reliability,
      percent: 100,
      detail: '5.0 rating • 24 completed swaps.',
      icon: Icons.verified_user_outlined,
    ),
  ];
}
