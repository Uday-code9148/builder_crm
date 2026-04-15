import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';

enum MilestoneStatus {
  done,
  inProgress,
  upcoming;

  Color nodeColor(AppColors colors) {
    switch (this) {
      case MilestoneStatus.done:
        return colors.primaryTeal;
      case MilestoneStatus.inProgress:
        return colors.warningAmber;
      case MilestoneStatus.upcoming:
        return colors.outlineVariant;
    }
  }
}
