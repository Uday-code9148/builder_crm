import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/milestone_status.dart';
import 'package:temp_architecture_app_setup/features/updates/data/datasources/updates_datasource.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone_entity.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress_entity.dart';

@LazySingleton(as: UpdatesDataSource)
class UpdatesMockDataSource implements UpdatesDataSource {
  @override
  Future<ProjectProgressEntity> getProjectProgress() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const ProjectProgressEntity(
      projectName: 'The Emerald Pavilion',
      unit: 'Unit 402 • Phase II Construction',
      overallProgress: 0.65,
      lastUpdated: '2h ago',
      milestones: [
        MilestoneEntity(title: 'Foundation', subtitle: 'Completed March 12, 2024', progress: 1.0, status: MilestoneStatus.done),
        MilestoneEntity(title: 'Structure', subtitle: 'Completed April 28, 2024', progress: 1.0, status: MilestoneStatus.done),
        MilestoneEntity(title: 'MEP', subtitle: 'Mechanical, Electrical, Plumbing', progress: 1.0, status: MilestoneStatus.done),
        MilestoneEntity(title: 'Plastering', subtitle: 'In Progress', progress: 0.65, status: MilestoneStatus.inProgress),
        MilestoneEntity(title: 'Interior', subtitle: 'Scheduled for June 2024', progress: 0.0, status: MilestoneStatus.upcoming),
        MilestoneEntity(title: 'Handover', subtitle: 'Estimated August 2024', progress: 0.0, status: MilestoneStatus.upcoming),
      ],
    );
  }
}
