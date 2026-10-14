/// Shared amounts for the subscription purchase mock flow (choose plan → pay → confirm).
class SubscriptionCheckoutMock {
  SubscriptionCheckoutMock._();

  static const double listYearlyPrice = 59.99;
  static const double promoYearlyPrice = 50.99;
  static const double earlyBirdDiscount = listYearlyPrice - promoYearlyPrice;

  static String formatMoney(double amount) =>
      '\$${amount.toStringAsFixed(2)}';

  static String get listYearlyLabel => formatMoney(listYearlyPrice);
  static String get promoYearlyLabel => formatMoney(promoYearlyPrice);
  static String get discountLabel => '-${formatMoney(earlyBirdDiscount)}';
}
