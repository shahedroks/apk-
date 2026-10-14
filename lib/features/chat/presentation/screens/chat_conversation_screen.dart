import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/chat_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/chat_message_widgets.dart';
import '../widgets/chat_swap_status_card.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({
    super.key,
    this.threadId,
    this.partnerName,
  });

  final String? threadId;
  final String? partnerName;

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final _messageController = TextEditingController();
  final List<_LocalMessage> _extraMessages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage([String? preset]) {
    final text = (preset ?? _messageController.text).trim();
    if (text.isEmpty) return;
    setState(() {
      _extraMessages.add(
        _LocalMessage(text: text, outgoing: true, time: _formatNow()),
      );
      _messageController.clear();
    });
  }

  String _formatNow() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${now.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withValues(alpha: 0.85),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 44.w,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ChatStrings.chatConversation,
          style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.45,
            color: AppColors.primaryDark,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textSecondary),
            onPressed: () => showMockSnackBar(context, 'Chat options (mock)'),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
              children: [
                ChatSwapStatusCard(
                  onDetailsTap: () => context.push(AppRouter.incomingSwapOffer('1')),
                ),
                const ChatDateSeparator(label: ChatStrings.todaySeparator),
                const IncomingChatBubble(
                  text: ChatStrings.incoming1,
                  time: '1:47 PM',
                ),
                SafeSwapSpotCard(
                  onMapTap: () => showMockSnackBar(context, 'Opening Domino Park (mock map)'),
                ),
                const OutgoingChatBubble(
                  text: ChatStrings.outgoing1,
                  time: '1:52 PM',
                ),
                const IncomingChatBubble(
                  text: ChatStrings.incoming2,
                  time: '1:55 PM',
                ),
                ..._extraMessages.map(
                  (m) => m.outgoing
                      ? OutgoingChatBubble(text: m.text, time: m.time)
                      : IncomingChatBubble(
                          text: m.text,
                          time: m.time,
                          showAvatar: false,
                        ),
                ),
              ],
            ),
          ),
          ChatQuickReplyBar(onChipTap: _sendMessage),
          SizedBox(height: 6.h),
          ChatComposerBar(
            controller: _messageController,
            onSend: () => _sendMessage(),
          ),
        ],
      ),
    );
  }
}

class _LocalMessage {
  _LocalMessage({
    required this.text,
    required this.outgoing,
    required this.time,
  });

  final String text;
  final bool outgoing;
  final String time;
}
