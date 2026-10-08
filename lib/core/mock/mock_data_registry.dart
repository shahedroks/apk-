/// Central index of static mock datasets used across the demo app.
///
/// All screens read from these files only — no live API or persistence.
class MockDataRegistry {
  MockDataRegistry._();

  static const String home = 'lib/features/home/data/home_mock_data.dart';
  static const String item = 'lib/features/item/data/item_mock_data.dart';
  static const String match = 'lib/features/match/data/match_mock_data.dart';
  static const String extra = 'lib/features/extra/data/extra_mock_data.dart';
  static const String subscription = 'lib/features/subscription/data/subscription_mock_data.dart';
}
