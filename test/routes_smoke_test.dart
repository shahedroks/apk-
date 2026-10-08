import 'package:flutter_test/flutter_test.dart';

import 'package:my_flutter_app/core/routes/app_router.dart';

void main() {
  test('AppRouter exposes a complete smoke-test route list', () {
    final locations = AppRouter.allSmokeTestLocations;
    expect(locations.length, greaterThan(20));
    expect(locations.toSet().length, locations.length);
    expect(locations, contains(AppRouter.home));
    expect(locations, contains(AppRouter.mySubscription));
    expect(locations, contains(AppRouter.swapCompleted));
  });

  test('Path helpers match go_router patterns', () {
    expect(AppRouter.item('4'), '/item/4');
    expect(AppRouter.match('m1'), '/match/m1');
    expect(
      AppRouter.chat('c1', name: 'Marcus Chen'),
      '/chat/c1?name=Marcus%20Chen',
    );
    expect(AppRouter.publicUser('marcus_c'), '/user/marcus_c');
  });
}
