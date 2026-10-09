import 'package:flutter/material.dart';

import '../domain/models/swap_listing.dart';

class HomeMockData {
  HomeMockData._();

  static const List<String> discoverCategories = [
    'All',
    'Electronics',
    'Home',
    'Books',
    'Clothes',
  ];

  static const List<String> savedCategories = [
    'All Saved (4)',
    'Electronics',
    'Home & Plant',
    'Books',
    'Clothes',
  ];

  static const int activeSwapsChatCount = 2;

  static final List<SwapListing> discoverItems = [
    SwapListing(
      id: '1',
      title: 'Vintage Vinyl Player',
      wants: 'Acoustic Guitar or Synth',
      location: 'Brooklyn, NY',
      postedAgo: '2h ago',
      badge: 'Like New',
      imageColor: Color(0xFF8B7355),
    ),
    SwapListing(
      id: '2',
      title: 'Snake Plant',
      wants: 'Ceramic Pots or Books',
      location: 'Queens, NY',
      postedAgo: '5h ago',
      badge: 'Potted',
      imageColor: Color(0xFF4A7C59),
    ),
    SwapListing(
      id: '3',
      title: 'Custom Mech Keyboard',
      wants: 'Turntable or Camera',
      location: 'Manhattan, NY',
      postedAgo: '1d ago',
      badge: 'Excellent',
      imageColor: Color(0xFF5C6BC0),
    ),
    SwapListing(
      id: '4',
      title: 'Audio Pro Turntable',
      wants: 'Keyboard or Monitor',
      location: 'Jersey City, NJ',
      postedAgo: '1d ago',
      badge: 'Mint',
      imageColor: Color(0xFF37474F),
    ),
  ];

  static final List<SwapListing> savedItems = [
    SwapListing(
      id: '5',
      title: 'Mid-Century Lamp',
      wants: 'Plant Stand or Art',
      location: 'Brooklyn, NY',
      postedAgo: '3h ago',
      badge: 'Available',
      imageColor: Color(0xFFD4A574),
      isSaved: true,
    ),
    SwapListing(
      id: '6',
      title: 'Film Camera Kit',
      wants: 'Lens or Tripod',
      location: 'Astoria, NY',
      postedAgo: '6h ago',
      badge: 'Available',
      imageColor: Color(0xFF78909C),
      isSaved: true,
    ),
    SwapListing(
      id: '7',
      title: 'Succulent Bundle',
      wants: 'Pots or Soil',
      location: 'Williamsburg, NY',
      postedAgo: '8h ago',
      badge: 'Available',
      imageColor: Color(0xFF66BB6A),
      isSaved: true,
    ),
    SwapListing(
      id: '8',
      title: 'Design Book Set',
      wants: 'Desk Lamp',
      location: 'Brooklyn, NY',
      postedAgo: '12h ago',
      badge: 'Available',
      imageColor: Color(0xFF8D6E63),
      isSaved: true,
    ),
  ];

  static final List<ChatThread> chats = [
    ChatThread(
      id: 'c1',
      userName: 'Marcus Chen',
      message: 'Can we meet near the park Saturday?',
      timeAgo: '2m ago',
      itemTitle: 'Vintage Turntable',
      itemColor: Color(0xFF37474F),
      avatarColor: Color(0xFFDEE9FC),
      isOnline: true,
      isVerified: true,
      unreadCount: 1,
    ),
    ChatThread(
      id: 'c2',
      userName: 'Priya N.',
      message: 'Love the lamp — still available?',
      timeAgo: '1h ago',
      itemTitle: 'Mid-Century Lamp',
      itemColor: Color(0xFFD4A574),
      avatarColor: Color(0xFFE8F5E9),
    ),
    ChatThread(
      id: 'c3',
      userName: 'Jordan Lee',
      message: 'Swap confirmed for Sunday!',
      timeAgo: '3h ago',
      itemTitle: 'Mech Keyboard',
      itemColor: Color(0xFF5C6BC0),
      avatarColor: Color(0xFFE3F2FD),
    ),
  ];

  static ActiveSwap get primarySwap => ActiveSwap(
        id: 's1',
        partnerName: 'Marcus Chen',
        partnerRating: 4.9,
        isPro: true,
        statusLabel: 'Meetup scheduled',
        youGive: discoverItems[2],
        youGet: discoverItems[3],
        completedSteps: 2,
        activeStep: SwapProgressStep.meetup,
        stepDates: ['Nov 6', 'Nov 7', 'Nov 8', '—'],
      );

  static ActiveSwap get reviewSwap => ActiveSwap(
        id: 's2',
        partnerName: 'Elena R.',
        partnerRating: 4.7,
        isPro: false,
        statusLabel: 'Proposal under review',
        youGive: savedItems[0],
        youGet: discoverItems[0],
        completedSteps: 0,
        activeStep: SwapProgressStep.proposed,
        needsReview: true,
        reviewStepLabel: 'Step 1 of 4',
        stepDates: ['—', '—', '—', '—'],
      );
}
