import 'package:flutter/material.dart';

class SwapListing {
  const SwapListing({
    required this.id,
    required this.title,
    required this.wants,
    required this.location,
    required this.postedAgo,
    required this.badge,
    required this.imageColor,
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
}
