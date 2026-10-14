import 'package:flutter/material.dart';

import '../../../core/constants/extra_strings.dart';

enum NotificationCardStyle { match, meetup, message, swapCompleted, eco }

class AppNotification {
  const AppNotification({
    required this.style,
    required this.body,
    required this.icon,
    required this.iconBackground,
    this.iconColor = const Color(0xFF00241A),
    this.iconOnDark = false,
    this.categoryChip,
    this.timeAgo,
    this.unread = false,
    this.showMatchIconBadge = false,
    this.senderName,
    this.messageLine,
    this.quote,
    this.action,
    this.onActionRoute,
    this.actionShowsArrow = true,
    this.actionShowsMapPin = false,
    this.starRating,
    this.ecoTier,
    this.ecoPoints,
  });

  final NotificationCardStyle style;
  final String body;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final bool iconOnDark;
  final String? categoryChip;
  final String? timeAgo;
  final bool unread;
  final bool showMatchIconBadge;
  final String? senderName;
  final String? messageLine;
  final String? quote;
  final String? action;
  final String? onActionRoute;
  final bool actionShowsArrow;
  final bool actionShowsMapPin;
  final int? starRating;
  final String? ecoTier;
  final String? ecoPoints;
}

class ReviewTrait {
  const ReviewTrait({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class ReviewItem {
  const ReviewItem({
    required this.userName,
    required this.rating,
    required this.timeAgo,
    required this.tradeGiven,
    required this.tradeReceived,
    required this.body,
    required this.traits,
    this.avatarUrl,
    this.attachmentImageUrl,
  });

  final String userName;
  final double rating;
  final String timeAgo;
  final String tradeGiven;
  final String tradeReceived;
  final String body;
  final List<ReviewTrait> traits;
  final String? avatarUrl;
  final String? attachmentImageUrl;
}

class ExtraMockData {
  ExtraMockData._();

  static const notificationFilterCounts = [5, null, null, null];

  static const notificationFilters = [
    ExtraStrings.filterAll,
    ExtraStrings.filterSwaps,
    ExtraStrings.filterMessages,
    ExtraStrings.filterSystem,
  ];

  static const todayNotifications = [
    AppNotification(
      style: NotificationCardStyle.match,
      categoryChip: ExtraStrings.chipMatch,
      timeAgo: '2m ago',
      body: ExtraStrings.notifMatchBody,
      icon: Icons.auto_awesome,
      iconBackground: const Color(0xFFEAF8D2),
      unread: true,
      showMatchIconBadge: true,
      action: ExtraStrings.actionViewMatch,
      onActionRoute: '/match/m1',
    ),
    AppNotification(
      style: NotificationCardStyle.meetup,
      categoryChip: ExtraStrings.chipMeetup,
      timeAgo: '1h ago',
      body: ExtraStrings.notifMeetupBody,
      icon: Icons.event_available_outlined,
      iconBackground: const Color(0xFF0D3B2E),
      iconColor: Colors.white,
      iconOnDark: true,
      unread: true,
      action: ExtraStrings.actionOpenMap,
      onActionRoute: '/incoming-swap-offer',
      actionShowsMapPin: true,
      actionShowsArrow: false,
    ),
    AppNotification(
      style: NotificationCardStyle.message,
      senderName: ExtraStrings.notifMessageSender,
      timeAgo: '12m ago',
      messageLine: ExtraStrings.notifMessageLine,
      quote: ExtraStrings.notifMessageQuote,
      body: '',
      icon: Icons.chat_bubble_outline_rounded,
      iconBackground: const Color(0xFFBEEDD9),
      onActionRoute: '/chat/c2?name=Elena',
    ),
  ];

  static const yesterdayNotifications = [
    AppNotification(
      style: NotificationCardStyle.swapCompleted,
      categoryChip: ExtraStrings.chipSwapDone,
      timeAgo: 'Yesterday',
      body: ExtraStrings.notifSwapBody,
      icon: Icons.verified_user_outlined,
      iconBackground: const Color(0xFFCAEAD6),
      iconColor: const Color(0xFF072317),
      starRating: 5,
      action: ExtraStrings.actionLeaveReview,
      onActionRoute: '/swap-completed',
      actionShowsArrow: false,
    ),
  ];

  static const weekNotifications = [
    AppNotification(
      style: NotificationCardStyle.eco,
      categoryChip: ExtraStrings.chipEcoUpdate,
      timeAgo: '3d ago',
      body: ExtraStrings.notifEcoBody,
      icon: Icons.eco_outlined,
      iconBackground: const Color(0x80ACF847),
      iconColor: const Color(0xFF304F00),
      ecoTier: ExtraStrings.notifEcoTier,
      ecoPoints: ExtraStrings.notifEcoPoints,
    ),
  ];

  static const reviewFilterCounts = [24, null, null];

  static const reviewFilters = [
    ExtraStrings.filterAllReviews,
    ExtraStrings.electronicsSwaps,
    ExtraStrings.plantsHome,
  ];

  static const ratingDistribution = <int, double>{
    5: 0.92,
    4: 0.08,
    3: 0,
    2: 0,
    1: 0,
  };

  static const reviews = [
    ReviewItem(
      userName: 'Elena Alvarez',
      rating: 5.0,
      timeAgo: '3 days ago',
      tradeGiven: 'Monstera cutting',
      tradeReceived: 'Keychron keyboard',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop&crop=faces',
      attachmentImageUrl:
          'https://images.unsplash.com/photo-1587829745530-0ce173b4c7ff?w=200&h=200&fit=crop',
      body:
          '“Super smooth swap at McCarren. Item was exactly as described and Marcus was on time.”',
      traits: [
        ReviewTrait(label: 'Punctual', icon: Icons.schedule),
        ReviewTrait(label: 'Accurate Description', icon: Icons.fact_check_outlined),
        ReviewTrait(label: 'Circular Champion', icon: Icons.eco_outlined),
      ],
    ),
    ReviewItem(
      userName: 'Jordan Lee',
      rating: 4.8,
      timeAgo: '1 week ago',
      tradeGiven: 'desk lamp',
      tradeReceived: 'ceramic planters',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=faces',
      body:
          '“Friendly communicator and flexible on meetup time. Would swap again!”',
      traits: [
        ReviewTrait(label: 'Responsive', icon: Icons.chat_bubble_outline),
        ReviewTrait(label: 'Friendly', icon: Icons.sentiment_satisfied_alt_outlined),
      ],
    ),
  ];

  static const desiredTradeChips = [
    ('35mm film rolls', Icons.camera_roll_outlined),
    ('Mechanical keyboards', Icons.keyboard_outlined),
    ('Rare Philodendron', Icons.local_florist_outlined),
    ('Espresso gear', Icons.coffee_outlined),
  ];

  static const publicListings = [
    PublicProfileListing(
      id: '4',
      title: 'Vintage Vinyl Turntable (LP60X)',
      condition: 'Like New',
      valueLabel: '~\$160 val',
      detailLine: 'Fully calibrated • Original needle',
      seekingLine: 'Seeking analog audio or plants',
      imageUrl:
          'https://images.unsplash.com/photo-1603048588665-791ca8aea0c3?w=800&h=500&fit=crop',
    ),
    PublicProfileListing(
      id: 'mine-1',
      title: 'Keychron Q1 Pro Keyboard',
      condition: 'Like New',
      valueLabel: '~\$170 val',
      detailLine: 'Hot-swap switches • Barely used',
      seekingLine: 'Seeking film cameras or plants',
      imageUrl:
          'https://images.unsplash.com/photo-1587829745530-0ce173b4c7ff?w=800&h=500&fit=crop',
    ),
    PublicProfileListing(
      id: 'mine-3',
      title: 'Mid-Century Desk Lamp',
      condition: 'Good Condition',
      valueLabel: '~\$85 val',
      detailLine: 'Working dimmer • Minor patina',
      seekingLine: 'Seeking planters or espresso gear',
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=800&h=500&fit=crop',
    ),
  ];
}

class PublicProfileListing {
  const PublicProfileListing({
    required this.id,
    required this.title,
    required this.condition,
    required this.valueLabel,
    required this.detailLine,
    required this.seekingLine,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String condition;
  final String valueLabel;
  final String detailLine;
  final String seekingLine;
  final String imageUrl;
}
