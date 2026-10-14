import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Lime SWAP IT mark used in the home header and Discover tab.
class SwapBrandMark extends StatelessWidget {
  const SwapBrandMark({super.key, this.size, this.dark = false});

  final double? size;
  /// Chats header: dark green tile with light swap icon.
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final box = size ?? 36.w;
    return Container(
      width: box,
      height: box,
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF0A2E22) : AppColors.accentLime,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.swap_horiz_rounded,
        size: (box * 0.58),
        color: dark ? Colors.white : AppColors.primaryDark,
      ),
    );
  }
}
