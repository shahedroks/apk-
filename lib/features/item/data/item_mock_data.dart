import 'package:flutter/material.dart';

import '../../../core/constants/profile_strings.dart';

class UserListingItem {
  const UserListingItem({
    required this.id,
    required this.title,
    required this.category,
    required this.condition,
    required this.status,
    required this.views,
    required this.inquiries,
    required this.listedAgo,
    required this.color,
    required this.estimatedValue,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final String condition;
  final String status;
  final int views;
  final int inquiries;
  final String listedAgo;
  final Color color;
  final String estimatedValue;
  final String? imageUrl;

  String get categoryConditionLine => '$category • $condition';
}

class ItemMockData {
  ItemMockData._();

  static const String defaultItemId = '4';

  static final List<UserListingItem> myActiveListings = [
    UserListingItem(
      id: 'mine-turntable',
      title: 'Vintage Vinyl Turntable',
      category: 'Electronics',
      condition: 'Like New',
      status: 'Active',
      views: 42,
      inquiries: 8,
      listedAgo: 'Listed 2d ago',
      color: Color(0xFF8B7355),
      estimatedValue: '~\$160',
      imageUrl: ProfileStrings.offerTurntableImageUrl,
    ),
    UserListingItem(
      id: 'mine-1',
      title: 'Keychron Q1 Pro Keyboard',
      category: 'Electronics',
      condition: 'Like New',
      status: 'Active',
      views: 24,
      inquiries: 5,
      listedAgo: 'Listed 5d ago',
      color: Color(0xFF5C6BC0),
      estimatedValue: '~\$170',
      imageUrl:
          'https://images.unsplash.com/photo-1587829745530-0ce173b4c7ff?w=400&h=400&fit=crop',
    ),
    UserListingItem(
      id: 'mine-3',
      title: 'Mid-Century Desk Lamp',
      category: 'Home',
      condition: 'Good Condition',
      status: 'Active',
      views: 18,
      inquiries: 2,
      listedAgo: 'Listed 1w ago',
      color: Color(0xFFD4A574),
      estimatedValue: '~\$85',
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=400&fit=crop',
    ),
  ];

  static final List<UserListingItem> offerOptions = [
    myActiveListings[1],
    myActiveListings[0],
    myActiveListings[2],
  ];
}
