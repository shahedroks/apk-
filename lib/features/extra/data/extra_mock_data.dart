import 'package:flutter/material.dart';

import '../../../core/constants/extra_strings.dart';

class AppNotification {
  const AppNotification({
    required this.title,
    required this.body,
    required this.icon,
    required this.iconBg,
    this.badge,
    this.action,
    this.onActionRoute,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color iconBg;
  final String? badge;
  final String? action;
  final String? onActionRoute;
}

class ReviewItem {
  const ReviewItem({
    required this.userName,
    required this.rating,
    required this.timeAgo,
    required this.tradeBadge,
    required this.body,
    required this.traits,
  });

  final String userName;
  final double rating;
  final String timeAgo;
  final String tradeBadge;
  final String body;
  final List<String> traits;
}

class ExtraMockData {
  ExtraMockData._();

  static const notificationFilters = [
    ExtraStrings.filterAll,
    ExtraStrings.filterSwaps,
    ExtraStrings.filterMessages,
    ExtraStrings.filterSystem,
  ];

  static const todayNotifications = [
    AppNotification(
      title: 'New High Match!',
      body: 'Marcus Chen is a 92% match for your keyboard listing.',
      icon: Icons.swap_horiz,
      iconBg: Color(0xFFACF847),
      badge: '92% Match',
      action: 'View match →',
      onActionRoute: '/match/m1',
    ),
    AppNotification(
      title: 'Meetup Scheduled',
      body: 'Swap meetup confirmed for Saturday — Domino Park.',
      icon: Icons.event,
      iconBg: Color(0xFFEFF4FF),
      action: 'Open Map',
      onActionRoute: '/incoming-swap-offer',
    ),
    AppNotification(
      title: 'Message from Elena',
      body: '“Still interested in the Monstera cutting?”',
      icon: Icons.chat_bubble_outline,
      iconBg: Color(0xFFDEE9FC),
      action: 'Reply',
      onActionRoute: '/chat/c2?name=Elena',
    ),
  ];

  static const yesterdayNotifications = [
    AppNotification(
      title: 'Swap Completed!',
      body: 'You and Marcus confirmed your trade. Rate your experience.',
      icon: Icons.verified_user,
      iconBg: Color(0xFFACF847),
      action: 'Leave a review',
      onActionRoute: '/swap-completed',
    ),
  ];

  static const weekNotifications = [
    AppNotification(
      title: 'Weekly Eco Impact',
      body: 'You diverted 3.4kg of CO₂ this week. Tier 2 Circular Pioneer +45 pts.',
      icon: Icons.eco_outlined,
      iconBg: Color(0xFFBEEDD9),
    ),
  ];

  static const reviewFilters = [
    ExtraStrings.allReviews,
    ExtraStrings.electronicsSwaps,
    ExtraStrings.plantsHome,
  ];

  static const reviews = [
    ReviewItem(
      userName: 'Elena Alvarez',
      rating: 5.0,
      timeAgo: '3 days ago',
      tradeBadge: 'Traded Monstera cutting for Keychron keyboard',
      body:
          'Super smooth swap at McCarren. Item was exactly as described and Marcus was on time.',
      traits: ['Punctual', 'Accurate Description', 'Circular Champion'],
    ),
    ReviewItem(
      userName: 'Jordan Lee',
      rating: 4.8,
      timeAgo: '1 week ago',
      tradeBadge: 'Traded desk lamp for ceramic planters',
      body: 'Friendly communicator and flexible on meetup time. Would swap again!',
      traits: ['Responsive', 'Friendly'],
    ),
  ];

  static const desiredTradeChips = [
    '35mm Film rolls',
    'Mechanical keyboards',
    'Mirrorless cameras',
    'Studio monitors',
  ];
}
