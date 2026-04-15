import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

enum TicketCategory {
  maintenance(label: 'MAINTENANCE', color: ColorPalette.pendingTeal),
  legal(label: 'LEGAL', color: ColorPalette.secondaryPurple),
  billing(label: 'BILLING', color: ColorPalette.paidGreen),
  security(label: 'SECURITY', color: ColorPalette.overdueRed);

  final String label;
  final Color color;

  const TicketCategory({required this.label, required this.color});
}
