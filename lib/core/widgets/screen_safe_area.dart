import 'package:flutter/material.dart';

/// Keeps screen content below the system status bar (and optional bottom insets).
///
/// Use [bottom: false] when a [BottomNavigationBar] or dock already applies
/// bottom safe padding.
class ScreenSafeArea extends StatelessWidget {
  const ScreenSafeArea({
    super.key,
    required this.child,
    this.bottom = true,
  });

  final Widget child;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: bottom,
      left: true,
      right: true,
      child: child,
    );
  }
}
