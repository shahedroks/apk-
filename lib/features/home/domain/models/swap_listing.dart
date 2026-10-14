import 'package:flutter/material.dart';

enum ListingBadgeStyle {
  /// Dark pill — e.g. Like New, Mint (`rgba(0,36,26,0.7)`).
  conditionOverlay,
  /// Solid green category tag — e.g. Potted.
  categorySolid,
  /// White pill + lime dot for live listings.
  available,
}

class SwapListing {
  const SwapListing({
    required this.id,
    required this.title,
    required this.wants,
    required this.location,
    required this.postedAgo,
    required this.badge,
    required this.imageColor,
    this.imageUrl,
    this.swapDetail,
    this.badgeStyle = ListingBadgeStyle.conditionOverlay,
    this.isSaved = false,
    this.isAvailable = true,
  });

  final String id;
  final String title;
  final String wants;
  final String location;
  final String postedAgo;
  final String badge;
  final Color imageColor;
  final String? imageUrl;
  /// e.g. `Like New • Value ~$120` on swap cards.
  final String? swapDetail;
  final ListingBadgeStyle badgeStyle;
  final bool isSaved;
  final bool isAvailable;
}

class ChatThread {
  const ChatThread({
    required this.id,
    required this.userName,
    required this.message,
    required this.timeAgo,
    required this.itemTitle,
    required this.itemColor,
    this.avatarColor = const Color(0xFFDEE9FC),
    this.avatarUrl,
    this.itemImageUrl,
    this.isOnline = false,
    this.isVerified = false,
    this.unreadCount = 0,
  });

  final String id;
  final String userName;
  final String message;
  final String timeAgo;
  final String itemTitle;
  final Color itemColor;
  final Color avatarColor;
  final String? avatarUrl;
  final String? itemImageUrl;
  final bool isOnline;
  final bool isVerified;
  final int unreadCount;
}

enum SwapProgressStep { proposed, accepted, meetup, completed }

class ActiveSwap {
  const ActiveSwap({
    required this.id,
    required this.partnerName,
    required this.partnerRating,
    required this.isPro,
    required this.statusLabel,
    required this.youGive,
    required this.youGet,
    required this.completedSteps,
    required this.activeStep,
    this.needsReview = false,
    this.reviewStepLabel,
    this.stepDates = const [],
    this.stepSubtitles = const [],
    this.partnerSubtitle,
    this.partnerAvatarUrl,
  });

  final String id;
  final String partnerName;
  final double partnerRating;
  final bool isPro;
  final String statusLabel;
  final SwapListing youGive;
  final SwapListing youGet;
  final int completedSteps;
  final SwapProgressStep activeStep;
  final bool needsReview;
  final String? reviewStepLabel;
  final List<String> stepDates;
  final List<String?> stepSubtitles;
  final String? partnerSubtitle;
  final String? partnerAvatarUrl;
}
