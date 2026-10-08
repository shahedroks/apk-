class PlanFeature {
  const PlanFeature(this.text, {this.included = true});

  final String text;
  final bool included;
}

class PlanTier {
  const PlanTier({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.strikePrice,
    this.badge,
    this.highlighted = false,
    this.isActive = false,
    this.extraHighlight,
  });

  final String id;
  final String name;
  final String price;
  final String period;
  final List<PlanFeature> features;
  final String? strikePrice;
  final String? badge;
  final bool highlighted;
  final bool isActive;
  final String? extraHighlight;
}

class ComparisonRow {
  const ComparisonRow(this.label, this.free, this.premium);

  final String label;
  final String free;
  final String premium;
}

class SubscriptionMockData {
  static const List<String> yearlyFeatures = [
    'Unlimited active listings',
    'AI Smart Match priority',
    '25 mi proximity radius',
    'Priority safe hub pickup',
    'Verified Champion badge',
  ];

  static const List<String> monthlyFeatures = [
    'Unlimited active listings',
    'AI Smart Match',
    '15 mi proximity radius',
    'Standard support',
  ];

  static const List<String> freeFeatures = [
    'Up to 3 active listings',
    'Basic browse & chat',
    '5 mi proximity radius',
  ];

  static List<PlanTier> plans({required bool annual}) {
    return [
      PlanTier(
        id: 'yearly',
        name: 'Premium Yearly',
        price: annual ? '\$50.99' : '\$59.99',
        period: '/ year',
        strikePrice: annual ? '\$67.99' : null,
        badge: 'BEST VALUE • SAVE 25%',
        highlighted: true,
        extraHighlight: 'Champion Badge on your public profile',
        features: yearlyFeatures.map((f) => PlanFeature(f)).toList(),
      ),
      PlanTier(
        id: 'monthly',
        name: 'Premium Monthly',
        price: '\$6.99',
        period: '/ month',
        features: monthlyFeatures.map((f) => PlanFeature(f)).toList(),
      ),
      PlanTier(
        id: 'free',
        name: 'Free Swapper',
        price: '\$0',
        period: '/ forever',
        isActive: true,
        features: freeFeatures.map((f) => PlanFeature(f, included: false)).toList(),
      ),
    ];
  }

  static const List<ComparisonRow> comparison = [
    ComparisonRow('Listing Volume', '3 max', 'Unlimited'),
    ComparisonRow('Smart Match', 'Basic', 'AI Priority'),
    ComparisonRow('Proximity Radius', '5 mi', '25 mi'),
    ComparisonRow('Support Care', 'Community', 'Priority'),
  ];

  static const List<String> confirmationPerks = [
    'Unlimited listings & stacks',
    'AI Smart Match priority',
    'Champion profile badge',
    '2 months free on yearly',
  ];
}
