import 'package:flutter/material.dart';

import 'main_shell_screen.dart';

/// Entry route after login — hosts Discover / Saved / Swaps / Chats tabs.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainShellScreen();
  }
}
