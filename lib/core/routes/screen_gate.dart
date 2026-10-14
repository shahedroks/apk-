import 'package:flutter/material.dart';

import '../config/app_release_flags.dart';
import '../widgets/coming_soon_screen.dart';

typedef ScreenBuilder = Widget Function();

Widget gatedDesignBoardScreen({
  required ScreenBuilder builder,
  String? title,
}) {
  if (AppReleaseFlags.showDesignBoardScreens) {
    return builder();
  }
  return ComingSoonScreen(screenTitle: title);
}
