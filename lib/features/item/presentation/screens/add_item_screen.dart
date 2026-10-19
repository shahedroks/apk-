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
import '../../data/add_item_mock_data.dart';
import '../providers/add_item_providers.dart';
import '../providers/item_form_provider.dart';
import '../services/add_item_publish.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _titleController = TextEditingController(text: ItemStrings.defaultAddItemTitle);
  final _descController = TextEditingController();

  final _conditions = [
    ItemStrings.conditionBrandNew,
    'Like New',
    ItemStrings.conditionGood,
    ItemStrings.conditionFair,
  ];

  final _conditionExplainers = [
    ItemStrings.conditionBrandNewExplainer,
    ItemStrings.conditionLikeNewExplainer,
    ItemStrings.conditionGoodExplainer,
    ItemStrings.conditionFairExplainer,
  ];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _publishListing(BuildContext context) async {
    final wants = ref.read(wildcardSwapProvider)
        ? ItemStrings.wildcard
        : ItemStrings.wishlistTagsHint;
    try {
      await ref.read(addItemPublishProvider).publish(
            title: _titleController.text,
            description: _descController.text,
            wants: wants,
            conditionIndex: ref.read(addItemConditionProvider),
            conditionLabels: _conditions,
          );
      if (!context.mounted) return;
      context.push(AppRouter.addItemSuccess);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not publish: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final conditionIndex = ref.watch(addItemConditionProvider);
    final wildcard = ref.watch(wildcardSwapProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _TopBar(
            onShare: () => showMockSnackBar(context, 'Share draft (mock)'),
          ),
          _DraftStatusBar(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              children: [
                SizedBox(height: 16.h),
                _PhotosSection(),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(
                        label: ItemStrings.itemTitle,
                        required: true,
                        trailing: '${_titleController.text.length} / 80',
                      ),
                      SizedBox(height: 6.h),
                      _TitleField(controller: _titleController),
                      SizedBox(height: 4.h),
                      Text(
                        ItemStrings.itemTitleHelper,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(label: ItemStrings.category, required: true),
                      SizedBox(height: 6.h),
                      _CategorySelector(
                        onTap: () => showMockSnackBar(context, 'Category picker (mock)'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(label: 'Condition', required: true),
                      SizedBox(height: 8.h),
                      _ConditionGrid(
                        conditions: _conditions,
                        selectedIndex: conditionIndex,
                        onSelect: (i) => ref.read(addItemConditionProvider.notifier).state = i,
                      ),
                      SizedBox(height: 4.h),
                      _ConditionExplainer(text: _conditionExplainers[conditionIndex]),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(
                        label: ItemStrings.description,
                        required: true,
                        trailing: '${_descController.text.length}/500',
                      ),
                      SizedBox(height: 6.h),
                      TextField(
                        controller: _descController,
                        maxLines: 5,
                        maxLength: 500,
                        buildCounter: (_, {required currentLength, required isFocused, maxLength}) =>
                            null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.infoBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(16.w),
                        ),
                        style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(height: 1.6),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.eco_outlined, size: 15.sp, color: AppColors.accentGreen),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              ItemStrings.descriptionHelper,
                              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(label: ItemStrings.wishlistTags, required: true),
                      SizedBox(height: 2.h),
                      Text(
                        ItemStrings.wishlistTagsHint,
                        style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          ...AddItemMockData.wishlistTags.map(_WishlistTag.new),
                          _AddPreferenceChip(
                            onTap: () => showMockSnackBar(context, 'Add preference (mock)'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                        decoration: BoxDecoration(
                          color: AppColors.infoBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ItemStrings.wildcard,
                                    style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    ItemStrings.wildcardSub,
                                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: wildcard,
                              onChanged: (v) => ref.read(wildcardSwapProvider.notifier).state = v,
                              activeTrackColor: AppColors.accentLime,
                              activeThumbColor: Colors.white,
                              inactiveTrackColor: AppColors.borderLight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _FormSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelRow(label: ItemStrings.approxLocation, required: true),
                      SizedBox(height: 6.h),
                      Container(
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.infoBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14.sp, color: AppColors.accentGreen),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Williamsburg, Brooklyn, NY',
                                style: AppTextStyles.label(fontSize: 14.sp).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => showMockSnackBar(context, 'Change location (mock)'),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                ItemStrings.change,
                                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accentGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.lock_outline, size: 11.sp, color: AppColors.textMuted),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              'Exact address hidden until a swap is mutually accepted.',
                              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                _PublishActions(
                  onPublish: () => _publishListing(context),
                  onDraft: () => showMockSnackBar(context, 'Draft save not synced yet'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onShare});

  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.fromLTRB(8.w, top + 4.h, 12.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.8),
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
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16.sp),
            onPressed: () => context.pop(),
          ),
          Expanded(
            child: Text(
              ItemStrings.addItem,
              style: AppTextStyles.screenTitle(fontSize: 18.sp).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: onShare,
            icon: Icon(Icons.ios_share, size: 20.sp, color: AppColors.textSecondary),
          ),
          Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              color: Color(0xFF00241A),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, size: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _DraftStatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: AppColors.infoBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: AppColors.accentLime,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                ItemStrings.draftAutoSaved,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFDEE9FC),
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: Text(
              ItemStrings.step1of2,
              style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: const Color(0xFF00241A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0D0D3B2E),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.label,
    this.required = false,
    this.trailing,
  });

  final String label;
  final bool required;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: AppTextStyles.label(fontSize: 13.sp).copyWith(fontWeight: FontWeight.w600),
            ),
            if (required)
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFBA1A1A),
                ),
              ),
          ],
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}

class _PhotosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _FormSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ItemStrings.itemPhotos,
                          style: AppTextStyles.label(fontSize: 18.sp).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFBA1A1A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      ItemStrings.photosDragHint,
                      style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  ItemStrings.photosCountLabel,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00241A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 8.w;
              final cell = (constraints.maxWidth - gap) / 2;
              return SizedBox(
                height: cell * 2 + gap,
                child: Column(
                  children: [
                    Row(
                      children: [
                        _PhotoCell(
                          width: cell,
                          height: cell,
                          imageUrl: AddItemMockData.photoUrls[0],
                          cover: true,
                        ),
                        SizedBox(width: gap),
                        _PhotoCell(
                          width: cell,
                          height: cell,
                          imageUrl: AddItemMockData.photoUrls[1],
                          bottomLabel: ItemStrings.photoLabelSide,
                        ),
                      ],
                    ),
                    SizedBox(height: gap),
                    Row(
                      children: [
                        _PhotoCell(
                          width: cell,
                          height: cell,
                          imageUrl: AddItemMockData.photoUrls[2],
                          bottomLabel: ItemStrings.photoLabelSerial,
                        ),
                        SizedBox(width: gap),
                        _AddPhotoCell(width: cell, height: cell),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PhotoCell extends StatelessWidget {
  const _PhotoCell({
    required this.width,
    required this.height,
    required this.imageUrl,
    this.cover = false,
    this.bottomLabel,
  });

  final double width;
  final double height;
  final String imageUrl;
  final bool cover;
  final String? bottomLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
            if (cover)
              Positioned(
                left: 8.w,
                top: 8.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.accentLime,
                    borderRadius: BorderRadius.circular(999.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded, size: 10.sp, color: const Color(0xFF457000)),
                      SizedBox(width: 4.w),
                      Text(
                        ItemStrings.coverPhoto,
                        style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF457000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              right: 8.w,
              top: 8.h,
              child: _RemovePhotoButton(),
            ),
            if (bottomLabel != null)
              Positioned(
                left: 8.w,
                bottom: 8.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xBF00241A),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    bottomLabel!,
                    style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 8.w,
              bottom: 8.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xCC0D3B2E),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF79A694),
                        shape: BoxShape.circle,
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

class _RemovePhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xB300241A),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.close, size: 12.sp, color: Colors.white),
    );
  }
}

class _AddPhotoCell extends StatelessWidget {
  const _AddPhotoCell({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: () => showMockSnackBar(context, 'Add photo (mock)'),
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFDEE9FC),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add_a_photo_outlined, size: 20.sp, color: const Color(0xFF00241A)),
              ),
              SizedBox(height: 6.h),
              Text(
                ItemStrings.addPhoto,
                style: AppTextStyles.label(fontSize: 13.sp).copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  ItemStrings.photoLightingHint,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(fontSize: 10.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final valid = controller.text.trim().isNotEmpty;

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: controller,
          maxLength: 80,
          buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
          style: AppTextStyles.label(fontSize: 14.sp).copyWith(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.infoBackground,
            contentPadding: EdgeInsets.fromLTRB(16.w, 15.h, 40.w, 15.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (valid)
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(Icons.check_circle, size: 17.sp, color: AppColors.accentGreen),
          ),
      ],
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.infoBackground,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 48.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF00241A),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.photo_camera_outlined, size: 14.sp, color: Colors.white),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  ItemStrings.categoryPhotography,
                  style: AppTextStyles.label(fontSize: 14.sp).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp, color: AppColors.textSecondary),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionGrid extends StatelessWidget {
  const _ConditionGrid({
    required this.conditions,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> conditions;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _ConditionPill(label: conditions[0], selected: selectedIndex == 0, onTap: () => onSelect(0))),
            SizedBox(width: 4.w),
            Expanded(child: _ConditionPill(label: conditions[1], selected: selectedIndex == 1, onTap: () => onSelect(1))),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(child: _ConditionPill(label: conditions[2], selected: selectedIndex == 2, onTap: () => onSelect(2))),
            SizedBox(width: 4.w),
            Expanded(child: _ConditionPill(label: conditions[3], selected: selectedIndex == 3, onTap: () => onSelect(3))),
          ],
        ),
      ],
    );
  }
}

class _ConditionPill extends StatelessWidget {
  const _ConditionPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF00241A) : AppColors.infoBackground,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 34.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected) ...[
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.accentLime,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
              ],
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConditionExplainer extends StatelessWidget {
  const _ConditionExplainer({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final parts = text.split(': ');
    final title = parts.isNotEmpty ? parts.first : '';
    final body = parts.length > 1 ? parts.sublist(1).join(': ') : text;

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, size: 17.sp, color: AppColors.accentGreen),
          SizedBox(width: 8.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTextStyles.subtitle(fontSize: 14.sp).copyWith(height: 1.43),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WishlistTag extends StatelessWidget {
  const _WishlistTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.caption(fontSize: 11.sp).copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.close, size: 12.sp, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _AddPreferenceChip extends StatelessWidget {
  const _AddPreferenceChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFDEE9FC),
      borderRadius: BorderRadius.circular(999.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 10.sp, color: const Color(0xFF00241A)),
              SizedBox(width: 4.w),
              Text(
                ItemStrings.addPreference,
                style: AppTextStyles.caption(fontSize: 11.sp).copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00241A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PublishActions extends StatelessWidget {
  const _PublishActions({required this.onPublish, required this.onDraft});

  final VoidCallback onPublish;
  final VoidCallback onDraft;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.18),
          child: InkWell(
            onTap: onPublish,
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 48.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ItemStrings.publishItem,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.check_rounded, size: 12.sp, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Material(
          color: AppColors.infoBackground,
          borderRadius: BorderRadius.circular(8.r),
          child: InkWell(
            onTap: onDraft,
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 44.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_outlined, size: 14.sp, color: AppColors.textSecondary),
                  SizedBox(width: 6.w),
                  Text(
                    ItemStrings.saveDraft,
                    style: AppTextStyles.label(fontSize: 13.sp).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
