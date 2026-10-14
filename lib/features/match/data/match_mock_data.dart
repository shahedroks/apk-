import 'package:flutter/material.dart';

import '../../../core/constants/chat_strings.dart';
import '../../../core/constants/match_strings.dart';
import '../../../core/constants/profile_strings.dart';

class SwapMatchSummary {
  const SwapMatchSummary({
    required this.id,
    required this.partnerName,
    required this.isPro,
    required this.activeLabel,
    required this.matchPercent,
    required this.youOfferTitle,
    required this.theyOfferTitle,
    required this.reason,
    required this.secondaryAction,
    required this.reasonIcon,
    this.avatarUrl,
    this.youImageUrl,
    this.theyImageUrl,
    this.youColor = const Color(0xFFE6EEFF),
    this.theyColor = const Color(0xFFE6EEFF),
  });

  final String id;
  final String partnerName;
  final bool isPro;
  final String activeLabel;
  final int matchPercent;
  final String youOfferTitle;
  final String theyOfferTitle;
  final String reason;
  final String secondaryAction;
  final IconData reasonIcon;
  final String? avatarUrl;
  final String? youImageUrl;
  final String? theyImageUrl;
  final Color youColor;
  final Color theyColor;

  bool get isHighMatch => matchPercent >= 85;

  String get theyOffersLabel {
    final first = partnerName.split(' ').first.toUpperCase();
    return '$first OFFERS';
  }
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
      activeLabel: '',
      matchPercent: 92,
      youOfferTitle: 'Mechanical Keyboard',
      theyOfferTitle: 'Audio Pro Turntable',
      youImageUrl: ChatStrings.youOfferImageUrl,
      theyImageUrl: ChatStrings.partnerItemImageUrl,
      avatarUrl: ChatStrings.partnerAvatarUrl,
      reason:
          'He wants your keyboard & has what you requested in your profile!',
      reasonIcon: Icons.check_circle_outline,
      secondaryAction: MatchStrings.details,
    ),
    SwapMatchSummary(
      id: 'm2',
      partnerName: 'Elena Rostova',
      isPro: false,
      activeLabel: '1.8 mi away',
      matchPercent: 78,
      youOfferTitle: 'Ceramic Tea Set',
      theyOfferTitle: 'Monstera & Pot',
      youImageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop',
      theyImageUrl:
          'https://images.unsplash.com/photo-1614594975524-35f69a3e6c31?w=400&h=400&fit=crop',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop&crop=faces',
      reason: 'She is nearby and looking for home goods like your tea set.',
      reasonIcon: Icons.location_on_outlined,
      secondaryAction: MatchStrings.details,
    ),
    SwapMatchSummary(
      id: 'm3',
      partnerName: 'Julian Park',
      isPro: false,
      activeLabel: 'Active 2h ago',
      matchPercent: 71,
      youOfferTitle: 'Design Books Bundle',
      theyOfferTitle: 'Analog Synth Pedal',
      youImageUrl:
          'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=400&fit=crop',
      theyImageUrl:
          'https://images.unsplash.com/photo-1511379938549-c1f69419868d?w=400&h=400&fit=crop',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop&crop=faces',
      reason: 'Lower overlap — review wishlist tags to improve future matches.',
      reasonIcon: Icons.search,
      secondaryAction: MatchStrings.dismiss,
    ),
  ];

  static SwapMatchSummary get elenaDetail => matches[1];

  static MatchDetailSnapshot detailFor(String? matchId) {
    if (matchId == null || matchId == 'm2') {
      return MatchDetailSnapshot.elena;
    }
    if (matchId == 'm1') {
      return MatchDetailSnapshot.marcus;
    }
    final summary = matches.firstWhere(
      (m) => m.id == matchId,
      orElse: () => elenaDetail,
    );
    if (summary.id == 'm2') {
      return MatchDetailSnapshot.elena;
    }
    return MatchDetailSnapshot.fromSummary(summary);
  }

  static const List<CompatibilityMetric> elenaMetrics = [
    CompatibilityMetric(
      title: MatchStrings.categorySynergy,
      percent: 100,
      detail: 'Direct bilateral interest: Wishlist item matched directly',
      icon: Icons.favorite_border,
    ),
    CompatibilityMetric(
      title: MatchStrings.valueBalance,
      percent: 95,
      detail: 'Fair tier overlap on both sides of the exchange.',
      icon: Icons.balance,
    ),
    CompatibilityMetric(
      title: MatchStrings.proximity,
      percent: 98,
      detail: '0.8 mi • McCarren verified hub available.',
      icon: Icons.explore_outlined,
    ),
    CompatibilityMetric(
      title: MatchStrings.reliability,
      percent: 100,
      detail: '5.0 rating • 19 completed bilateral swaps.',
      icon: Icons.verified_user_outlined,
    ),
  ];
}

class MatchInspectionSide {
  const MatchInspectionSide({
    required this.sectionLabel,
    required this.cornerBadge,
    required this.conditionOnImage,
    required this.title,
    required this.category,
    required this.tierRange,
    required this.seeking,
    this.imageUrl,
    this.highlightSeeking = false,
    this.requestedStyle = false,
  });

  final String sectionLabel;
  final String cornerBadge;
  final String conditionOnImage;
  final String title;
  final String category;
  final String tierRange;
  final String seeking;
  final String? imageUrl;
  final bool highlightSeeking;
  final bool requestedStyle;
}

class MatchDetailSnapshot {
  const MatchDetailSnapshot({
    required this.matchPercent,
    required this.partnerName,
    required this.avatarUrl,
    required this.rating,
    required this.yourSide,
    required this.theirSide,
  });

  final int matchPercent;
  final String partnerName;
  final String avatarUrl;
  final double rating;
  final MatchInspectionSide yourSide;
  final MatchInspectionSide theirSide;

  static final marcus = MatchDetailSnapshot(
    matchPercent: 92,
    partnerName: 'Marcus Chen',
    avatarUrl: ChatStrings.partnerAvatarUrl,
    rating: 4.9,
    yourSide: MatchInspectionSide(
      sectionLabel: MatchStrings.yourOfferDetail,
      cornerBadge: MatchStrings.badgeYou,
      conditionOnImage: 'Like New',
      title: 'Keychron Q1 Pro Mechanical Keyboard',
      category: 'Electronics & Tech',
      tierRange: '\$160 - \$180',
      seeking: 'Turntable, Vinyl, Audio Gear',
      imageUrl: ChatStrings.youOfferImageUrl,
    ),
    theirSide: MatchInspectionSide(
      sectionLabel: MatchStrings.requestedOffer,
      cornerBadge: MatchStrings.badgeMatched,
      conditionOnImage: 'Like New',
      title: 'Audio-Technica LP60X Turntable',
      category: 'Electronics & Audio',
      tierRange: '\$150 - \$170',
      seeking: 'Mechanical Keyboard',
      imageUrl: ChatStrings.partnerItemImageUrl,
      highlightSeeking: true,
      requestedStyle: true,
    ),
  );

  static final elena = MatchDetailSnapshot(
    matchPercent: 94,
    partnerName: 'Elena Alvarez',
    avatarUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop&crop=faces',
    rating: 5.0,
    yourSide: MatchInspectionSide(
      sectionLabel: MatchStrings.yourOfferDetail,
      cornerBadge: MatchStrings.badgeYou,
      conditionOnImage: 'Good Condition',
      title: 'Olympus 35mm RC',
      category: 'Photography & Cameras',
      tierRange: '\$140 - \$160',
      seeking: 'Rare Plants, Synths',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop',
    ),
    theirSide: MatchInspectionSide(
      sectionLabel: MatchStrings.requestedOffer,
      cornerBadge: MatchStrings.badgeMatched,
      conditionOnImage: 'Rooted Cutting',
      title: 'Monstera Albo Node',
      category: 'Plants & Gardening',
      tierRange: '\$130 - \$150',
      seeking: '35mm Rangefinder',
      imageUrl:
          'https://images.unsplash.com/photo-1614594975524-35f69a3e6c31?w=400&h=400&fit=crop',
      highlightSeeking: true,
      requestedStyle: true,
    ),
  );

  static MatchDetailSnapshot fromSummary(SwapMatchSummary m) {
    return MatchDetailSnapshot(
      matchPercent: m.matchPercent,
      partnerName: m.partnerName,
      avatarUrl: m.avatarUrl ?? ProfileStrings.profileAvatarUrl,
      rating: 4.9,
      yourSide: MatchInspectionSide(
        sectionLabel: MatchStrings.yourOfferDetail,
        cornerBadge: MatchStrings.badgeYou,
        conditionOnImage: 'Like New',
        title: m.youOfferTitle,
        category: 'Your listing',
        tierRange: '—',
        seeking: 'Open offers',
        imageUrl: m.youImageUrl,
      ),
      theirSide: MatchInspectionSide(
        sectionLabel: MatchStrings.requestedOffer,
        cornerBadge: MatchStrings.badgeMatched,
        conditionOnImage: 'Verified',
        title: m.theyOfferTitle,
        category: 'Their listing',
        tierRange: '—',
        seeking: 'Wishlist match',
        imageUrl: m.theyImageUrl,
        requestedStyle: true,
      ),
    );
  }
}
