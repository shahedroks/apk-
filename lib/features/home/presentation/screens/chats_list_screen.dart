import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/constants/home_strings.dart';
import '../../data/home_mock_data.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/category_chip_bar.dart';
import '../widgets/chat_thread_tile.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_top_bar.dart';

class ChatsListScreen extends ConsumerWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(chatFilterProvider);

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      children: [
        HomeTopBar(
          title: HomeStrings.chatsList,
          showBack: true,
          onBack: () => ref.read(homeTabIndexProvider.notifier).state = 0,
          onProfileTap: () => context.push(AppRouter.profile),
          onNotificationTap: () => context.push(AppRouter.notifications),
        ),
        SizedBox(height: 14.h),
        const HomeSearchBar(),
        SizedBox(height: 14.h),
        CategoryChipBar(
          labels: HomeMockData.chatFilters,
          selectedIndex: filter,
          onSelected: (i) => ref.read(chatFilterProvider.notifier).state = i,
        ),
        SizedBox(height: 14.h),
        ...HomeMockData.chats.map(
          (thread) => ChatThreadTile(
            thread: thread,
            onTap: () => context.push(
              AppRouter.chat(thread.id, name: thread.userName),
            ),
          ),
        ),
        if (HomeMockData.chats.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 48.h),
              child: Text(
                'No messages yet',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
              ),
            ),
          ),
      ],
    );
  }
}
