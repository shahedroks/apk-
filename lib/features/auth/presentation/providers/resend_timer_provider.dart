import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendTimerNotifier extends Notifier<int> {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() => _timer?.cancel());
    start(48);
    return 48;
  }

  void start(int seconds) {
    _timer?.cancel();
    state = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        timer.cancel();
        state = 0;
      } else {
        state = state - 1;
      }
    });
  }

  void resend() => start(48);
}

final resendTimerProvider =
    NotifierProvider<ResendTimerNotifier, int>(ResendTimerNotifier.new);
