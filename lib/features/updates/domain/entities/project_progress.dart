import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone.dart';

class ProjectProgress extends Equatable {
  final String projectName;
  final String unit;
  final double overallProgress; // 0.0 – 1.0
  final String lastUpdated;
  final List<Milestone> milestones;

  const ProjectProgress({
    required this.projectName,
    required this.unit,
    required this.overallProgress,
    required this.lastUpdated,
    required this.milestones,
  });

  @override
  List<Object?> get props => [projectName, unit, overallProgress, lastUpdated, milestones];
}
