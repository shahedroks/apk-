import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/home_bottom_nav.dart';
import 'chats_list_screen.dart';
import 'discover_screen.dart';
import 'my_swaps_screen.dart';
import 'saved_items_screen.dart';

class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static int _stackIndexForTab(int tab) {
    switch (tab) {
      case 0:
      case 1:
        return tab;
      case 3:
        return 2;
      case 4:
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(homeTabIndexProvider);
    final bodyIndex = _stackIndexForTab(tab);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: bodyIndex,
        children: const [
          DiscoverScreen(),
          SavedItemsScreen(),
          MySwapsScreen(),
          ChatsListScreen(),
        ],
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
