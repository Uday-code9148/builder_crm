import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

enum PaymentStatus {
  paid(label: 'PAID', color: ColorPalette.paidGreen),
  pending(label: 'PENDING', color: ColorPalette.pendingTeal),
  overdue(label: 'OVERDUE', color: ColorPalette.overdueRed),
  upcoming(label: 'UPCOMING', color: ColorPalette.upcomingGrey);

  final String label;
  final Color color;

  const PaymentStatus({required this.label, required this.color});
}
