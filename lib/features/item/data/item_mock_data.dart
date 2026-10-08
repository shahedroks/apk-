import 'package:flutter/material.dart';

class UserListingItem {
  const UserListingItem({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.inquiries,
    required this.color,
    required this.estimatedValue,
  });

  final String id;
  final String title;
  final String category;
  final String status;
  final int inquiries;
  final Color color;
  final String estimatedValue;
}

class ItemMockData {
  ItemMockData._();

  static const String defaultItemId = '4';

  static final List<UserListingItem> myActiveListings = [
    UserListingItem(
      id: 'mine-1',
      title: 'Keychron Q1 Pro Keyboard',
      category: 'Electronics',
      status: 'Active',
      inquiries: 5,
      color: Color(0xFF5C6BC0),
      estimatedValue: '~\$170',
    ),
    UserListingItem(
      id: 'mine-2',
      title: 'Olympus 35mm Film Camera',
      category: 'Electronics',
      status: 'Active',
      inquiries: 2,
      color: Color(0xFF78909C),
      estimatedValue: '~\$140',
    ),
    UserListingItem(
      id: 'mine-3',
      title: 'Mid-Century Desk Lamp',
      category: 'Home',
      status: 'Active',
      inquiries: 1,
      color: Color(0xFFD4A574),
      estimatedValue: '~\$85',
    ),
  ];

  static final List<UserListingItem> offerOptions = [
    myActiveListings[0],
    myActiveListings[1],
    myActiveListings[2],
  ];
}
