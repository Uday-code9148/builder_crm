import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';

AppBar buildCuratorGlassAppBar({required BuildContext context, String title = AppDisplayConstants.appTitle, String? subtitle}) {
  final colors = context.colors;
  return AppBar(
    backgroundColor: ColorPalette.transparent,
    surfaceTintColor: ColorPalette.transparent,
    elevation: 0,
    toolbarHeight: 64,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    flexibleSpace: ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.92),
            border: Border(bottom: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.3), width: 1)),
          ),
        ),
      ),
    ),
    title: Row(
      children: [
        const SizedBox(width: 20),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: colors.primaryTealFixed,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: colors.onPrimaryTeal.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Icon(Icons.home_work_rounded, size: 18, color: colors.white),
        ),
        const SizedBox(width: 10),
        subtitle == null
            ? Text(title, style: AppTextStyles.s13SemiBold.copyWith(color: colors.onSurface))
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.s13SemiBold.copyWith(color: colors.onSurface)),
                  Text(subtitle, style: AppTextStyles.s10Regular.copyWith(color: colors.onSurfaceDim, letterSpacing: 1.2)),
                ],
              ),
        const Spacer(),
        Icon(Icons.swap_horiz_rounded, color: colors.onSurfaceVariant, size: 20),
        const SizedBox(width: 20),
      ],
    ),
  );
}
