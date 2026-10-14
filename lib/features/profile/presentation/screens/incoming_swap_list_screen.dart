import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/profile_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../data/incoming_swap_mock_data.dart';
import '../../domain/incoming_swap_proposal.dart';
class IncomingSwapListScreen extends StatelessWidget {
  const IncomingSwapListScreen({super.key});

  static const _darkGreen = Color(0xFF0A2E22);

  @override
  Widget build(BuildContext context) {
    final proposals = IncomingSwapMockData.proposals;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withValues(alpha: 0.8),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ProfileStrings.incomingSwapOffersListTitle,
          style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45,
            color: _darkGreen,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        itemCount: proposals.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final proposal = proposals[index];
          return _IncomingSwapListTile(
            proposal: proposal,
            onTap: () => context.push(AppRouter.incomingSwapOffer(proposal.id)),
          );
        },
      ),
    );
  }
}

class _IncomingSwapListTile extends StatelessWidget {
  const _IncomingSwapListTile({
    required this.proposal,
    required this.onTap,
  });

  final IncomingSwapProposal proposal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentLime,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        ProfileStrings.incomingProposal,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.accentGreen,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.schedule, size: 13.sp, color: AppColors.textSecondary),
                    SizedBox(width: 4.w),
                    Text(
                      proposal.expiresLabel,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: proposal.avatarUrl,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            proposal.partnerName,
                            style: AppTextStyles.label(fontSize: 16.sp).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            proposal.receivedLabel,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 10.sp,
                      color: const Color(0xFFC0C8C3),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    _Thumb(imageUrl: proposal.theyOfferImageUrl),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Icon(
                        Icons.swap_horiz_rounded,
                        size: 18.sp,
                        color: AppColors.accentGreen,
                      ),
                    ),
                    _Thumb(imageUrl: proposal.youGiveImageUrl),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            proposal.theyOfferTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            proposal.youGiveTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48.w,
        height: 48.w,
        fit: BoxFit.cover,
        placeholder: (context, url) => ColoredBox(
          color: AppColors.infoBackground,
          child: SizedBox(width: 48.w, height: 48.w),
        ),
        errorWidget: (context, url, error) => ColoredBox(
          color: AppColors.infoBackground,
          child: SizedBox(width: 48.w, height: 48.w),
        ),
      ),
    );
  }
}
