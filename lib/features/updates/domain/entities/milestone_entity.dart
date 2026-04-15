import 'package:temp_architecture_app_setup/core/enums/milestone_status.dart';

class MilestoneEntity {
  final String? title;
  final String? subtitle;
  final double? progress; // 0.0 – 1.0
  final MilestoneStatus? status;

  const MilestoneEntity({this.title, this.subtitle, this.progress, this.status});
}

