import '../../../core/constants/profile_strings.dart';

class ProposeSwapOfferOption {
  const ProposeSwapOfferOption({
    required this.id,
    required this.title,
    required this.conditionBadge,
    required this.categoryLabel,
    required this.estValueAmount,
    required this.visualizerTitle,
    required this.imageUrl,
    this.conditionBadgeOnDark = false,
  });

  final String id;
  final String title;
  final String conditionBadge;
  final String categoryLabel;
  final int estValueAmount;
  final String visualizerTitle;
  final String imageUrl;
  final bool conditionBadgeOnDark;

  String get estValueLabel => 'Est. Value \$$estValueAmount';

  String get valueTag => '\$$estValueAmount Val';
}

class ProposeSwapMockData {
  ProposeSwapMockData._();

  static const int targetValueAmount = 145;

  /// Same plant hero used on home listings (reliable on device).
  static const String targetImageUrl =
      'https://images.unsplash.com/photo-1618424187943-44642a3d0934?w=400&h=400&fit=crop';

  static const List<ProposeSwapOfferOption> offerOptions = [
    ProposeSwapOfferOption(
      id: 'olympus',
      title: 'Vintage Olympus 35mm Camera',
      conditionBadge: 'Like New',
      categoryLabel: 'Photography',
      estValueAmount: 140,
      visualizerTitle: 'Olympus 35mm',
      imageUrl:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=400&h=400&fit=crop',
      conditionBadgeOnDark: true,
    ),
    ProposeSwapOfferOption(
      id: 'turntable',
      title: 'Vintage Vinyl Turntable (LP60X)',
      conditionBadge: 'Like New',
      categoryLabel: 'Audio',
      estValueAmount: 160,
      visualizerTitle: 'Turntable LP60X',
      imageUrl: ProfileStrings.offerTurntableImageUrl,
    ),
    ProposeSwapOfferOption(
      id: 'grinder',
      title: 'Fellow Ode Brew Grinder',
      conditionBadge: 'Like New',
      categoryLabel: 'Kitchen',
      estValueAmount: 180,
      visualizerTitle: 'Ode Grinder',
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-a7569e29fb04?w=400&h=400&fit=crop',
    ),
  ];

  static String get targetVisualizerTitle => 'Monstera Albo';

  static String get targetValueTag => '\$$targetValueAmount Val';
}
