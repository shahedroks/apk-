import 'package:flutter/material.dart';

import '../domain/models/saved_category_filter.dart';
import '../domain/models/swap_listing.dart';

class HomeMockData {
  HomeMockData._();

  static const List<String> discoverCategories = [
    'All',
    'Electronics',
    'Home',
    'Books',
    'Clothes',
    'Sports',
    'Music',
    'Art',
    'Toys',
    'Garden',
    'Tools',
  ];

  static const List<SavedCategoryFilter> savedCategoryFilters = [
    SavedCategoryFilter(label: 'All Saved', count: 4),
    SavedCategoryFilter(label: 'Electronics', count: 2),
    SavedCategoryFilter(label: 'Home & Plant', count: 1),
    SavedCategoryFilter(label: 'Books', count: 1),
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
      imageUrl:
          'https://images.unsplash.com/photo-1618424187943-44642a3d0934?w=400&h=400&fit=crop',
    ),
    SwapListing(
      id: '2',
      title: 'Monstera Deliciosa',
      wants: 'Ceramic Pots or Books',
      location: 'Queens, NY',
      postedAgo: '5h ago',
      badge: 'Potted',
      badgeStyle: ListingBadgeStyle.categorySolid,
      swapDetail: 'Healthy • Value ~\$55',
      imageColor: Color(0xFF4A7C59),
      imageUrl:
          'https://images.unsplash.com/photo-1614598805887-660977271048?w=400&h=400&fit=crop',
    ),
    SwapListing(
      id: '3',
      title: 'Custom Mech Keyboard',
      wants: 'Turntable or Camera',
      location: 'Manhattan, NY',
      postedAgo: '1d ago',
      badge: 'Excellent',
      swapDetail: 'Like New • Value ~\$120',
      imageColor: Color(0xFF5C6BC0),
      imageUrl:
          'https://images.unsplash.com/photo-1587829745530-0ce173b4c7ff?w=400&h=400&fit=crop',
    ),
    SwapListing(
      id: '4',
      title: 'Audio Pro Turntable',
      wants: 'Keyboard or Monitor',
      location: 'Jersey City, NJ',
      postedAgo: '1d ago',
      badge: 'Mint',
      swapDetail: 'Excellent • Value ~\$135',
      imageColor: Color(0xFF37474F),
      imageUrl:
          'https://images.unsplash.com/photo-1618424187943-44642a3d0934?w=400&h=400&fit=crop',
    ),
  ];

  static final List<SwapListing> savedItems = [
    SwapListing(
      id: '5',
      title: 'Olympus OM-1 35mm',
      wants: 'Vintage Lens or Film',
      location: 'Williamsburg, NY',
      postedAgo: '1d ago',
      badge: 'Available',
      badgeStyle: ListingBadgeStyle.available,
      imageColor: Color(0xFF78909C),
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop',
      isSaved: true,
    ),
    SwapListing(
      id: '6',
      title: 'Monstera Deliciosa',
      wants: 'Ceramic Pots or Books',
      location: 'Brooklyn, NY',
      postedAgo: '5h ago',
      badge: 'Available',
      badgeStyle: ListingBadgeStyle.available,
      imageColor: Color(0xFF4A7C59),
      imageUrl:
          'https://images.unsplash.com/photo-1614598805887-660977271048?w=400&h=400&fit=crop',
      isSaved: true,
    ),
    SwapListing(
      id: '7',
      title: 'Fellow Pour-Over Set',
      wants: 'Coffee Beans or Mugs',
      location: 'Queens, NY',
      postedAgo: '8h ago',
      badge: 'Available',
      badgeStyle: ListingBadgeStyle.available,
      imageColor: Color(0xFF37474F),
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-a7569e29fb04?w=400&h=400&fit=crop',
      isSaved: true,
    ),
    SwapListing(
      id: '8',
      title: 'Mid-century Brass Lamp',
      wants: 'Plant Stand or Art',
      location: 'Jersey City, NJ',
      postedAgo: '12h ago',
      badge: 'Available',
      badgeStyle: ListingBadgeStyle.available,
      imageColor: Color(0xFFD4A574),
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=400&fit=crop',
      isSaved: true,
    ),
  ];

  static final List<ChatThread> chats = [
    ChatThread(
      id: 'c1',
      userName: 'Marcus Chen',
      message: 'Sounds great! Are you available tomorrow?',
      timeAgo: '2m ago',
      itemTitle: 'Vintage Turntable',
      itemColor: Color(0xFF37474F),
      avatarColor: Color(0xFFDEE9FC),
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      itemImageUrl:
          'https://images.unsplash.com/photo-1618424187943-44642a3d0934?w=400&h=400&fit=crop',
      isOnline: true,
      isVerified: true,
      unreadCount: 1,
    ),
    ChatThread(
      id: 'c2',
      userName: 'Elena Rostova',
      message: 'I can pick up after 5pm if that works.',
      timeAgo: '45m ago',
      itemTitle: 'Ceramic Tea Set',
      itemColor: Color(0xFFBCAAA4),
      avatarColor: Color(0xFFDEE9FC),
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      itemImageUrl:
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
      isOnline: true,
    ),
    ChatThread(
      id: 'c3',
      userName: 'David Kim',
      message: 'Thanks — swap completed!',
      timeAgo: '2h ago',
      itemTitle: 'Custom Mech Keyboard',
      itemColor: Color(0xFF5C6BC0),
      avatarColor: Color(0xFFDEE9FC),
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop',
      itemImageUrl:
          'https://images.unsplash.com/photo-1587829745530-0ce173b4c7ff?w=400&h=400&fit=crop',
    ),
    ChatThread(
      id: 'c4',
      userName: 'Maya Patel',
      message: 'Is the plant still up for swap?',
      timeAgo: 'Yesterday',
      itemTitle: 'Monstera Deliciosa',
      itemColor: Color(0xFF558B2F),
      avatarColor: Color(0xFFDEE9FC),
      avatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      itemImageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=400&fit=crop',
      isOnline: true,
      isVerified: true,
    ),
  ];

  static ActiveSwap get primarySwap => ActiveSwap(
        id: 's1',
        partnerName: 'Marcus Chen',
        partnerRating: 4.9,
        isPro: true,
        statusLabel: 'Meetup scheduled',
        partnerSubtitle: 'Sat, Nov 11 • 2:00 PM',
        stepSubtitles: [
          'Offer initiated by Marcus',
          'Both parties agreed to bilateral terms',
          'Domino Park (North Plaza)',
          null,
        ],
        partnerAvatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
        youGive: discoverItems[2],
        youGet: discoverItems[3],
        completedSteps: 2,
        activeStep: SwapProgressStep.meetup,
        stepDates: ['Nov 8', 'Nov 9', 'Today', 'Pending'],
      );

  static ActiveSwap get reviewSwap => ActiveSwap(
        id: 's2',
        partnerName: 'Elena Rostova',
        partnerRating: 4.7,
        isPro: false,
        statusLabel: 'Awaiting confirmation',
        partnerSubtitle: 'Received 3 hours ago',
        youGive: SwapListing(
          id: '9',
          title: 'Ceramic Tea Set',
          wants: 'Plants or Books',
          location: 'Brooklyn, NY',
          postedAgo: '3h ago',
          badge: 'Available',
          badgeStyle: ListingBadgeStyle.available,
          swapDetail: 'Good • Value ~\$45',
          imageColor: Color(0xFFBCAAA4),
          imageUrl:
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
        ),
        youGet: discoverItems[1],
        completedSteps: 0,
        activeStep: SwapProgressStep.proposed,
        needsReview: true,
        reviewStepLabel: 'Step 1 of 4: Proposal under review',
        stepDates: ['—', '—', '—', '—'],
      );
}
