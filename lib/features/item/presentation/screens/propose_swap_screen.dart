import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../auth/presentation/widgets/swap_primary_button.dart';
import '../../data/item_mock_data.dart';
import '../providers/item_form_provider.dart';

class ProposeSwapScreen extends ConsumerStatefulWidget {
  const ProposeSwapScreen({super.key, this.itemId});

  final String? itemId;

  @override
  ConsumerState<ProposeSwapScreen> createState() => _ProposeSwapScreenState();
}

class _ProposeSwapScreenState extends ConsumerState<ProposeSwapScreen> {
  final _noteController = TextEditingController(
    text:
        'Hi Elena! I love your Monstera cutting. My keyboard is in pristine condition — happy to swap this weekend!',
  );

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(proposeOfferIndexProvider);
    final offer = ItemMockData.offerOptions[selected];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(ItemStrings.proposeSwap, style: AppTextStyles.screenTitle(fontSize: 17.sp)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text(
                ItemStrings.step2of2,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _TargetCard(),
          SizedBox(height: 16.h),
          Text(ItemStrings.yourOffer, style: AppTextStyles.label(fontSize: 15.sp)),
          SizedBox(height: 10.h),
          ...List.generate(ItemMockData.offerOptions.length, (index) {
            final item = ItemMockData.offerOptions[index];
            final isSelected = index == selected;
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14.r),
                child: InkWell(
                  onTap: () => ref.read(proposeOfferIndexProvider.notifier).state = index,
                  borderRadius: BorderRadius.circular(14.r),
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected ? AppColors.primary : AppColors.textMuted,
                          size: 22.sp,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: ColoredBox(
                            color: item.color,
                            child: SizedBox(width: 48.w, height: 48.w),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: AppTextStyles.label(fontSize: 13.sp)),
                              Text(
                                '${item.estimatedValue} • ${item.status}',
                                style: AppTextStyles.caption(fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ItemStrings.youGive,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(color: Colors.white70),
                      ),
                      Text(
                        offer.title,
                        style: AppTextStyles.label(fontSize: 12.sp).copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.swap_horiz, color: AppColors.accentLime),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ItemStrings.youReceive,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(color: Colors.white70),
                      ),
                      Text(
                        ItemStrings.targetItem,
                        textAlign: TextAlign.end,
                        style: AppTextStyles.label(fontSize: 12.sp).copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Text(ItemStrings.exchangeMethod, style: AppTextStyles.label(fontSize: 15.sp)),
          SizedBox(height: 8.h),
          _MeetupOption(),
          SizedBox(height: 16.h),
          Text(ItemStrings.personalNote, style: AppTextStyles.label(fontSize: 14.sp)),
          SizedBox(height: 8.h),
          TextField(
            controller: _noteController,
            maxLines: 4,
            maxLength: 280,
            decoration: InputDecoration(
              hintText: ItemStrings.noteHint,
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.borderLight),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _PolicyCard(),
          SizedBox(height: 20.h),
          SwapPrimaryButton(
            label: ItemStrings.sendProposal,
            icon: Icons.send_rounded,
            onPressed: () => context.push(AppRouter.chat('c1', name: 'Marcus Chen')),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(ItemStrings.cancelReturn),
          ),
        ],
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ColoredBox(
              color: const Color(0xFF66BB6A),
              child: SizedBox(width: 44.w, height: 44.w),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ItemStrings.targetItem, style: AppTextStyles.label(fontSize: 14.sp)),
                Text(
                  'Owner: ${ItemStrings.targetOwner}',
                  style: AppTextStyles.caption(fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetupOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.mintGlow.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.accentLime),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(ItemStrings.safeHub, style: AppTextStyles.label(fontSize: 14.sp)),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.accentLime,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  ItemStrings.recommended,
                  style: AppTextStyles.caption(fontSize: 9.sp).copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(ItemStrings.safeHubBody, style: AppTextStyles.subtitle(fontSize: 13.sp)),
          TextButton(
            onPressed: () => showMockSnackBar(context, 'Meetup map (mock)'),
            child: const Text('View on map'),
          ),
        ],
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: AppColors.primary, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ItemStrings.noCashPolicy, style: AppTextStyles.label(fontSize: 13.sp)),
                Text(ItemStrings.noCashBody, style: AppTextStyles.caption(fontSize: 11.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
