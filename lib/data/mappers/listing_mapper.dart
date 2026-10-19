import 'package:flutter/material.dart';

import '../../features/home/domain/models/swap_listing.dart';
import '../models/listing_item.dart';

class ListingMapper {
  ListingMapper._();

  static SwapListing toSwapListing(ListingItem item) {
    final badgeStyle = item.categoryName.toLowerCase().contains('plant') ||
            item.categoryName.toLowerCase().contains('garden')
        ? ListingBadgeStyle.categorySolid
        : ListingBadgeStyle.conditionOverlay;

    return SwapListing(
      id: item.id,
      title: item.title,
      wants: item.wants,
      location: item.location,
      postedAgo: _formatPostedAgo(item.createdAt),
      badge: item.condition.isNotEmpty ? item.condition : item.categoryName,
      imageColor: _colorFromId(item.id),
      imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : null,
      swapDetail: item.estimatedValue != null
          ? '${item.condition} • Value ${item.estimatedValue}'
          : item.condition,
      badgeStyle: badgeStyle,
      isSaved: false,
      isAvailable: item.status == 'approved',
    );
  }

  static String _formatPostedAgo(DateTime? createdAt) {
    if (createdAt == null) return 'Recently';
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  static Color _colorFromId(String id) {
    final hash = id.hashCode.abs();
    return Color(0xFF000000 | (hash & 0x00FFFFFF));
  }
}
