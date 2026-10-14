import '../../../core/constants/subscription_strings.dart';
import 'subscription_checkout_mock.dart';

class PlanFeature {
  const PlanFeature(
    this.text, {
    this.included = true,
    this.highlightPhrase,
    this.boldHighlight = false,
    this.emphasized = false,
  });

  final String text;
  final bool included;
  final String? highlightPhrase;
  final bool boldHighlight;
  final bool emphasized;
}

class PlanPerkHighlight {
  const PlanPerkHighlight({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}

enum ChoosePlanCardVariant { featuredYearly, monthly, freeCurrent }

class PlanTier {
  const PlanTier({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.variant,
    this.tagline,
    this.strikePrice,
    this.savingsLine,
    this.headerBadge,
    this.trailingHeaderBadge,
    this.perkHighlight,
  });

  final String id;
  final String name;
  final String price;
  final String period;
  final String? tagline;
  final List<PlanFeature> features;
  final String? strikePrice;
  final String? savingsLine;
  final String? headerBadge;
  final String? trailingHeaderBadge;
  final ChoosePlanCardVariant variant;
  final PlanPerkHighlight? perkHighlight;

  bool get isActive => variant == ChoosePlanCardVariant.freeCurrent;
  bool get highlighted => variant == ChoosePlanCardVariant.featuredYearly;
}

class ComparisonRow {
  const ComparisonRow(this.label, this.free, this.premium);

  final String label;
  final String free;
  final String premium;
}

class SubscriptionMockData {
  static const List<PlanFeature> yearlyFeatures = [
    PlanFeature('Unlimited active item listings'),
    PlanFeature('Extended 20-mile local discovery radius'),
    PlanFeature('Champion Badges', emphasized: true),
  ];

  static const List<PlanFeature> monthlyFeatures = [
    PlanFeature('Unlimited active listings'),
    PlanFeature('AI Smart Match'),
    PlanFeature('15 mi proximity radius'),
    PlanFeature('Standard support'),
  ];

  static const List<PlanFeature> freeFeatures = [
    PlanFeature('Up to 3 active listings', included: false),
    PlanFeature('Basic browse & chat', included: false),
    PlanFeature('5 mi proximity radius', included: false),
  ];

  static List<PlanTier> plans({required bool annual}) {
    return [
      PlanTier(
        id: 'yearly',
        name: SubscriptionStrings.premiumYearly,
        tagline: SubscriptionStrings.planYearlyTagline,
        price: annual
            ? SubscriptionCheckoutMock.promoYearlyLabel
            : SubscriptionCheckoutMock.listYearlyLabel,
        period: '/ year',
        strikePrice: annual ? SubscriptionStrings.yearlyRegularValue : null,
        savingsLine: annual ? SubscriptionStrings.yearlyBilledOnce : null,
        headerBadge: SubscriptionStrings.bestValueBadge,
        variant: ChoosePlanCardVariant.featuredYearly,
        perkHighlight: const PlanPerkHighlight(
          title: SubscriptionStrings.circularChampionFlairTitle,
          subtitle: SubscriptionStrings.circularChampionFlairSub,
        ),
        features: yearlyFeatures,
      ),
      PlanTier(
        id: 'monthly',
        name: SubscriptionStrings.premiumMonthly,
        tagline: SubscriptionStrings.planMonthlyTagline,
        price: '\$6.99',
        period: '/ month',
        headerBadge: SubscriptionStrings.monthlyFlexBadge,
        variant: ChoosePlanCardVariant.monthly,
        features: monthlyFeatures,
      ),
      PlanTier(
        id: 'free',
        name: SubscriptionStrings.freeSwapper,
        tagline: SubscriptionStrings.planFreeTagline,
        price: '\$0',
        period: '/ forever',
        headerBadge: SubscriptionStrings.freeBaseTierBadge,
        trailingHeaderBadge: SubscriptionStrings.freeActiveBadge,
        variant: ChoosePlanCardVariant.freeCurrent,
        features: freeFeatures,
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
