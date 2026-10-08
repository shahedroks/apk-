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
import '../providers/item_form_provider.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _conditions = ['Brand New', 'Like New', 'Good', 'Fair'];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conditionIndex = ref.watch(addItemConditionProvider);
    final wildcard = ref.watch(wildcardSwapProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(ItemStrings.addItem, style: AppTextStyles.screenTitle(fontSize: 17.sp)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text(
                ItemStrings.step1of2,
                style: AppTextStyles.caption(fontSize: 10.sp).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Text(ItemStrings.itemPhotos, style: AppTextStyles.label(fontSize: 14.sp)),
          SizedBox(height: 10.h),
          SizedBox(
            height: 100.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _PhotoThumb(cover: true),
                _PhotoThumb(),
                _AddPhotoPlaceholder(),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _label(ItemStrings.itemTitle),
          TextField(
            controller: _titleController,
            maxLength: 80,
            decoration: _inputDecoration(ItemStrings.itemTitleHint),
          ),
          SizedBox(height: 12.h),
          _label(ItemStrings.category),
          DropdownButtonFormField<String>(
            initialValue: 'Electronics',
            items: const [
              DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
              DropdownMenuItem(value: 'Home', child: Text('Home & Garden')),
              DropdownMenuItem(value: 'Books', child: Text('Books')),
            ],
            onChanged: (_) {},
            decoration: _inputDecoration('Select category'),
          ),
          SizedBox(height: 12.h),
          _label(ItemStrings.condition),
          Wrap(
            spacing: 8.w,
            children: List.generate(_conditions.length, (i) {
              final selected = i == conditionIndex;
              return ChoiceChip(
                label: Text(_conditions[i]),
                selected: selected,
                onSelected: (_) =>
                    ref.read(addItemConditionProvider.notifier).state = i,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.textPrimary,
                  fontSize: 12.sp,
                ),
              );
            }),
          ),
          if (conditionIndex == 1) ...[
            SizedBox(height: 8.h),
            Text(
              ItemStrings.conditionLikeNewDesc,
              style: AppTextStyles.caption(fontSize: 12.sp),
            ),
          ],
          SizedBox(height: 12.h),
          _label(ItemStrings.description),
          TextField(
            controller: _descController,
            maxLines: 4,
            maxLength: 500,
            decoration: _inputDecoration('Describe condition, accessories, quirks...'),
          ),
          SizedBox(height: 12.h),
          _label(ItemStrings.wishlistTags),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _tagChip('Mechanical keyboard'),
              _tagChip('Camera gear'),
              ActionChip(
                label: Text(ItemStrings.addPreference),
                onPressed: () => showMockSnackBar(context, 'Photo added (mock)'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(ItemStrings.wildcard, style: AppTextStyles.subtitle(fontSize: 14.sp)),
            value: wildcard,
            activeThumbColor: AppColors.surface,
            activeTrackColor: AppColors.primary,
            onChanged: (v) => ref.read(wildcardSwapProvider.notifier).state = v,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(ItemStrings.approxLocation, style: AppTextStyles.label(fontSize: 14.sp)),
            subtitle: Text('Williamsburg, Brooklyn, NY', style: AppTextStyles.caption(fontSize: 12.sp)),
            trailing: TextButton(
              onPressed: () => showMockSnackBar(context, 'Category updated (mock)'),
              child: Text(ItemStrings.change),
            ),
          ),
          SizedBox(height: 24.h),
          SwapPrimaryButton(
            label: ItemStrings.publishItem,
            icon: Icons.check_rounded,
            onPressed: () => context.push(AppRouter.addItemSuccess),
          ),
          TextButton(onPressed: () => context.pop(), child: Text(ItemStrings.saveDraft)),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(text, style: AppTextStyles.label(fontSize: 13.sp)),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
      );

  Widget _tagChip(String label) {
    return Chip(
      label: Text(label, style: AppTextStyles.caption(fontSize: 12.sp)),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: () {},
      backgroundColor: AppColors.infoBackground,
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({this.cover = false});

  final bool cover;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.infoBorder,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.image_outlined, color: AppColors.textMuted)),
          if (cover)
            Positioned(
              top: 6.h,
              left: 6.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                color: AppColors.accentLime,
                child: Text(
                  ItemStrings.coverPhoto,
                  style: AppTextStyles.caption(fontSize: 8.sp).copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          Positioned(
            top: 4.h,
            right: 4.w,
            child: Icon(Icons.cancel, size: 18.sp, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}

class _AddPhotoPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderLight, style: BorderStyle.solid),
        color: AppColors.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo_outlined, color: AppColors.primary),
          Text(ItemStrings.addPhoto, style: AppTextStyles.caption(fontSize: 10.sp)),
        ],
      ),
    );
  }
}
