import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

enum SnackbarType {
  success(icon: Icons.check_circle_outline, backgroundColor: ColorPalette.primaryGreen),
  warning(icon: Icons.warning_amber_outlined, backgroundColor: ColorPalette.yellow100Accent),
  error(icon: Icons.error_outline, backgroundColor: ColorPalette.fadedRed);

  final IconData icon;
  final Color backgroundColor;

  const SnackbarType({required this.icon, required this.backgroundColor});
}
