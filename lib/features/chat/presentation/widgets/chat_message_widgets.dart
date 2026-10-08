import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/chat_strings.dart';
import '../../../../core/theme/text_styles.dart';

class ChatDateSeparator extends StatelessWidget {
  const ChatDateSeparator({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class IncomingChatBubble extends StatelessWidget {
  const IncomingChatBubble({
    super.key,
    required this.text,
    required this.time,
    this.showAvatar = true,
  });

  final String text;
  final String time;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showAvatar)
            Padding(
              padding: EdgeInsets.only(right: 4.w, bottom: 4.h),
              child: CircleAvatar(
                radius: 14.r,
                backgroundColor: AppColors.infoBorder,
                child: Icon(Icons.person, size: 16.sp, color: AppColors.primary),
              ),
            )
          else
            SizedBox(width: 32.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
              decoration: BoxDecoration(
                color: AppColors.infoBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(2.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        color: AppColors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    time,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutgoingChatBubble extends StatelessWidget {
  const OutgoingChatBubble({
    super.key,
    required this.text,
    required this.time,
    this.read = true,
  });

  final String text;
  final String time;
  final bool read;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(2.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        color: Colors.white,
                        height: 1.35,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      if (read) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.done_all,
                          size: 14.sp,
                          color: AppColors.accentLime,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SafeSwapSpotCard extends StatelessWidget {
  const SafeSwapSpotCard({super.key, this.onMapTap});

  final VoidCallback? onMapTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.infoBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.infoBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.mintGlow,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.verified_user_outlined,
                size: 20.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ChatStrings.safeSwapSpot,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    ChatStrings.dominoPark,
                    style: AppTextStyles.label(fontSize: 14.sp),
                  ),
                  Text(
                    ChatStrings.dominoParkSub,
                    style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onMapTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.surface,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                ChatStrings.map,
                style: AppTextStyles.label(fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatQuickReplyBar extends StatelessWidget {
  const ChatQuickReplyBar({
    super.key,
    required this.onChipTap,
  });

  final ValueChanged<String> onChipTap;

  static const List<String> chips = [
    ChatStrings.quickReply1,
    ChatStrings.quickReply2,
    ChatStrings.quickReply3,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: chips.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final label = chips[index];
          return ActionChip(
            label: Text(
              label,
              style: AppTextStyles.caption(fontSize: 12.sp).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColors.infoBackground,
            side: const BorderSide(color: AppColors.infoBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999.r),
            ),
            onPressed: () => onChipTap(label),
          );
        },
      ),
    );
  }
}

class ChatComposerBar extends StatelessWidget {
  const ChatComposerBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: ChatStrings.messageHint,
                  hintStyle: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.infoBackground,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
