import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone_entity.dart';

class ProjectProgressEntity {
  final String? projectName;
  final String? unit;
  final double? overallProgress; // 0.0 – 1.0
  final String? lastUpdated;
  final List<MilestoneEntity>? milestones;

  const ProjectProgressEntity({
    this.projectName,
    this.unit,
    this.overallProgress,
    this.lastUpdated,
    this.milestones,
  });
}

