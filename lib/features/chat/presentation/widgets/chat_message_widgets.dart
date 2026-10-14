import 'package:cached_network_image/cached_network_image.dart';
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
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE6EEFF),
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
    this.avatarUrl,
  });

  final String text;
  final String time;
  final bool showAvatar;
  final String? avatarUrl;

  static const Color _bubbleFill = Color(0xFFEFF4FF);
  static const Color _avatarRing = Color(0xFFDEE9FC);

  @override
  Widget build(BuildContext context) {
    final photoUrl = avatarUrl ?? ChatStrings.partnerAvatarUrl;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showAvatar)
            Padding(
              padding: EdgeInsets.only(right: 4.w, bottom: 4.h),
              child: ClipOval(
                child: SizedBox(
                  width: 28.w,
                  height: 28.w,
                  child: CachedNetworkImage(
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: _avatarRing,
                      child: Icon(
                        Icons.person_rounded,
                        size: 16.sp,
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: _avatarRing,
                      child: Icon(
                        Icons.person_rounded,
                        size: 16.sp,
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            SizedBox(width: 32.w),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: _bubbleFill,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF121C2A),
                      height: 23 / 14,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
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

  static const Color _timeOnGreen = Color(0xFF79A694);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(14.w, 13.h, 14.w, 14.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(2.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                    spreadRadius: -1,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 23 / 14,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: _timeOnGreen,
                        ),
                      ),
                      if (read) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.done_all_rounded,
                          size: 13.sp,
                          color: AppColors.accentLime,
                          weight: 700,
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
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFDEE9FC),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.mintGlow,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shield_outlined,
                size: 17.sp,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ChatStrings.safeSwapSpot,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryDark,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    ChatStrings.dominoPark,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF121C2A),
                    ),
                  ),
                  Text(
                    ChatStrings.dominoParkSub,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8.r),
                elevation: 0,
                child: InkWell(
                  onTap: onMapTap,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      ChatStrings.map,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
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
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: chips.length,
        separatorBuilder: (_, _) => SizedBox(width: 4.w),
        itemBuilder: (context, index) {
          final label = chips[index];
          return GestureDetector(
            onTap: () => onChipTap(label),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE6EEFF),
                borderRadius: BorderRadius.circular(999.r),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                  height: 1.2,
                ),
              ),
            ),
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
        color: AppColors.background.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: AppColors.borderLight.withValues(alpha: 0.6))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Material(
              color: AppColors.toggleTrack,
              borderRadius: BorderRadius.circular(12.r),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 20.sp,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  style: AppTextStyles.subtitle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: ChatStrings.messageHint,
                    hintStyle: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Material(
              color: AppColors.accentLime,
              shape: const CircleBorder(),
              elevation: 0,
              child: InkWell(
                onTap: onSend,
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.primaryDark,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
