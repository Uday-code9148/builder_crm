import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/core/enums/milestone_status.dart';

class Milestone extends Equatable {
  final String title;
  final String subtitle;
  final double progress; // 0.0 – 1.0
  final MilestoneStatus status;

  const Milestone({required this.title, required this.subtitle, required this.progress, required this.status});

  @override
  List<Object?> get props => [title, subtitle, progress, status];
}
