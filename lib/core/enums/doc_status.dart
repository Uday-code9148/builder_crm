import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

enum DocStatus {
  verified(label: 'Verified', color: ColorPalette.primaryTealFixed),
  pending(label: 'Pending', color: ColorPalette.warningAmber),
  none(label: null, color: null);

  final String? label;
  final Color? color;

  const DocStatus({required this.label, required this.color});
}
