import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';

enum TicketStatus {
  open(label: 'Open', color: ColorPalette.primaryTealFixed, timeIcon: Icons.calendar_today_rounded),
  inProgress(label: 'In Progress', color: ColorPalette.warningAmber, timeIcon: Icons.schedule_rounded),
  resolved(label: 'Resolved', color: ColorPalette.paidGreen, timeIcon: Icons.check_circle_outline_rounded);

  final String label;
  final Color color;
  final IconData timeIcon;

  const TicketStatus({required this.label, required this.color, required this.timeIcon});
}

