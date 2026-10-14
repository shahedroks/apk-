import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/item_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/mock_actions.dart';
import '../../../home/presentation/widgets/swap_detail_cards.dart';
import '../../data/propose_swap_mock_data.dart';
import '../providers/item_form_provider.dart';

class ProposeSwapScreen extends ConsumerStatefulWidget {
  const ProposeSwapScreen({super.key, this.itemId});

  final String? itemId;

  @override
  ConsumerState<ProposeSwapScreen> createState() => _ProposeSwapScreenState();
}

class _ProposeSwapScreenState extends ConsumerState<ProposeSwapScreen> {
  static const _titleGreen = Color(0xFF00241A);

  final _noteController = TextEditingController(text: ItemStrings.defaultProposeNote);
  int _exchangeMethodIndex = 0;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(proposeOfferIndexProvider);
    final offer = ProposeSwapMockData.offerOptions[selected];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _TopBar(onMore: () => showMockSnackBar(context, 'Options (mock)')),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _ProgressHeader(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _YourOfferSection(
                        selected: selected,
                        onSelect: (i) => ref.read(proposeOfferIndexProvider.notifier).state = i,
                      ),
                      SizedBox(height: 24.h),
                      _AddListingButton(
                        onTap: () => context.push(AppRouter.addItem),
                      ),
                      SizedBox(height: 24.h),
                      _ExchangeVisualizer(
                        giveTitle: offer.visualizerTitle,
                        giveValue: offer.valueTag,
                        receiveTitle: ProposeSwapMockData.targetVisualizerTitle,
                        receiveValue: ProposeSwapMockData.targetValueTag,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        ItemStrings.preferredExchangeMethod,
                        style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: _titleGreen,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _ExchangeMethodOption(
                        selected: _exchangeMethodIndex == 0,
                        onTap: () => setState(() => _exchangeMethodIndex = 0),
                        child: _SafeHubContent(),
                      ),
                      SizedBox(height: 10.h),
                      _ExchangeMethodOption(
                        selected: _exchangeMethodIndex == 1,
                        onTap: () => setState(() => _exchangeMethodIndex = 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ItemStrings.porchHandshake,
                              style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              ItemStrings.porchHandshakeBody,
                              style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                                height: 1.43,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ItemStrings.personalNote,
                            style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                              fontWeight: FontWeight.w700,
                              color: _titleGreen,
                            ),
                          ),
                          Text(
                            ItemStrings.noteOptional,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _NoteCard(controller: _noteController),
                      SizedBox(height: 24.h),
                      _PolicyCard(),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _StickyBottom(
            onSend: () {
              final index = ref.read(proposeOfferIndexProvider);
              context.push('${AppRouter.swapInvitationSent}?offerIndex=$index');
            },
            onCancel: () => context.pop(),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onMore});

  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.fromLTRB(8.w, top + 4.h, 12.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          Expanded(
            child: Text(
              ItemStrings.proposeSwap,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.45,
                color: const Color(0xFF00241A),
              ),
            ),
          ),
          IconButton(
            onPressed: onMore,
            icon: Icon(Icons.more_vert, size: 22.sp, color: AppColors.textSecondary),
          ),
          Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: Color(0xFF00241A),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Icon(Icons.person, size: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      color: AppColors.infoBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ItemStrings.step1of2,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.55,
                  color: const Color(0xFF00241A),
                ),
              ),
              Text(
                ItemStrings.structureProposal,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: SizedBox(
              height: 6.h,
              child: Stack(
                children: [
                  const ColoredBox(color: AppColors.borderLight),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: const ColoredBox(color: AppColors.accentLime),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          _TargetRecipientCard(),
        ],
      ),
    );
  }
}

class _TargetRecipientCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: ProposeSwapMockData.targetImageUrl,
                  width: 48.w,
                  height: 48.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: RoundedCheckMark(
                    size: 7.w,
                    color: Colors.white,
                    strokeWidth: 1.2.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      ItemStrings.proposeToPrefix,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      ItemStrings.targetOwner,
                      style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.verified, size: 18.sp, color: AppColors.accentGreen),
                  ],
                ),
                Text(
                  ItemStrings.targetItem,
                  style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00241A),
                    height: 1.22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _YourOfferSection extends StatelessWidget {
  const _YourOfferSection({
    required this.selected,
    required this.onSelect,
  });

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ItemStrings.yourOffer,
              style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF00241A),
              ),
            ),
            Text(
              ItemStrings.selectOneItem,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...List.generate(ProposeSwapMockData.offerOptions.length, (index) {
          final item = ProposeSwapMockData.offerOptions[index];
          final isSelected = index == selected;
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _OfferOptionCard(
              item: item,
              isSelected: isSelected,
              onTap: () => onSelect(index),
            ),
          );
        }),
      ],
    );
  }
}

class _OfferOptionCard extends StatelessWidget {
  const _OfferOptionCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final ProposeSwapOfferOption item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      AppColors.mintGlow.withValues(alpha: 0.3),
                      AppColors.surface,
                    ],
                  )
                : null,
            color: isSelected ? null : AppColors.surface.withValues(alpha: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isSelected ? 0.1 : 0.05),
                blurRadius: isSelected ? 6 : 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: AppColors.borderLight,
                      child: SizedBox(width: 64.w, height: 64.w),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _ConditionPill(
                            label: item.conditionBadge,
                            onDark: item.conditionBadgeOnDark && isSelected,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            item.categoryLabel,
                            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.title,
                        style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                      Text(
                        item.estValueLabel,
                        style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: isSelected ? AppColors.accentGreen : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 28.w,
                    height: 28.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.accentGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: RoundedCheckMark(
                      size: 12.w,
                      color: Colors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                else
                  Container(
                    width: 25.w,
                    height: 25.w,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.circle_outlined, size: 12.sp, color: AppColors.textSecondary),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionPill extends StatelessWidget {
  const _ConditionPill({required this.label, required this.onDark});

  final String label;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: onDark ? const Color(0xFF00241A) : AppColors.borderLight,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
          fontWeight: FontWeight.w700,
          color: onDark ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _AddListingButton extends StatelessWidget {
  const _AddListingButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
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
          child: SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 18.sp, color: AppColors.accentGreen),
                SizedBox(width: 8.w),
                Text(
                  ItemStrings.addNewListingOffer,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00241A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExchangeVisualizer extends StatelessWidget {
  const _ExchangeVisualizer({
    required this.giveTitle,
    required this.giveValue,
    required this.receiveTitle,
    required this.receiveValue,
  });

  final String giveTitle;
  final String giveValue;
  final String receiveTitle;
  final String receiveValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ItemStrings.exchangeVisualizer,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.accentLime,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00241A),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.balance, size: 12.sp, color: AppColors.accentLime),
                    SizedBox(width: 4.w),
                    Text(
                      ItemStrings.balancedTrade,
                      style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentLime,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _VisualizerSide(
                      label: ItemStrings.youGive,
                      title: giveTitle,
                      value: giveValue,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: _VisualizerSide(
                      label: ItemStrings.youReceive,
                      title: receiveTitle,
                      value: receiveValue,
                    ),
                  ),
                ],
              ),
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    size: 18.sp,
                    color: const Color(0xFF457000),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VisualizerSide extends StatelessWidget {
  const _VisualizerSide({
    required this.label,
    required this.title,
    required this.value,
  });

  final String label;
  final String title;
  final String value;

  static const _labelColor = Color(0xFFA3D0BE);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0x9900241A),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: _labelColor,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.label(fontSize: 13.sp).copyWith(
              fontWeight: FontWeight.w600,
              height: 1.25,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: AppColors.accentLime,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExchangeMethodOption extends StatelessWidget {
  const _ExchangeMethodOption({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: selected
                ? LinearGradient(
                    colors: [
                      AppColors.accentLime.withValues(alpha: 0.2),
                      AppColors.surface,
                    ],
                  )
                : null,
            color: selected ? null : AppColors.surface.withValues(alpha: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: _RadioDot(selected: selected),
                ),
                SizedBox(width: 12.w),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 16.w,
      padding: EdgeInsets.all(selected ? 3.2.w : 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: selected ? AppColors.accentGreen : const Color(0xFF767676),
          width: 1,
        ),
      ),
      child: selected
          ? DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

class _SafeHubContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              ItemStrings.safeHub,
              style: AppTextStyles.label(fontSize: 14.sp).copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              height: 12.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accentGreen,
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                ItemStrings.recommended,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text.rich(
          TextSpan(
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(
              height: 1.43,
              color: AppColors.textSecondary,
            ),
            children: [
              const TextSpan(text: ItemStrings.safeHubBodyLead),
              TextSpan(
                text: ItemStrings.safeHubBodyPlace,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00241A),
                ),
              ),
              const TextSpan(text: ItemStrings.safeHubBodyTail),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 13.sp, color: AppColors.accentGreen),
            SizedBox(width: 6.w),
            Text(
              ItemStrings.safeHubDistanceLine,
              style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.accentGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NoteCard extends StatefulWidget {
  const _NoteCard({required this.controller});

  final TextEditingController controller;

  @override
  State<_NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<_NoteCard> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final length = widget.controller.text.length;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            maxLines: 3,
            maxLength: 280,
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(height: 1.43),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$length/280',
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
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
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFF00241A),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shield_outlined, size: 18.sp, color: AppColors.accentLime),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ItemStrings.noCashPolicy,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00241A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  ItemStrings.noCashBody,
                  style: AppTextStyles.subtitle(fontSize: 13.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.38,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyBottom extends StatelessWidget {
  const _StickyBottom({required this.onSend, required this.onCancel});

  final VoidCallback onSend;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Material(
              color: const Color(0xFF00241A),
              borderRadius: BorderRadius.circular(12.r),
              elevation: 2,
              child: InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ItemStrings.sendProposal,
                        style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.send_rounded, size: 14.sp, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: onCancel,
              child: Text(
                ItemStrings.cancelReturn,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
