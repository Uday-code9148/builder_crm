import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/features/updates/data/datasources/updates_datasource.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress.dart';

@LazySingleton(as: UpdatesDataSource)
class UpdatesMockDataSource implements UpdatesDataSource {
  @override
  Future<ProjectProgress> getProjectProgress() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const ProjectProgress(
      projectName: 'The Emerald Pavilion',
      unit: 'Unit 402 • Phase II Construction',
      overallProgress: 0.65,
      lastUpdated: '2h ago',
      milestones: [
        Milestone(
          title: 'Foundation',
          subtitle: 'Completed March 12, 2024',
          progress: 1.0,
          status: MilestoneStatus.done,
        ),
        Milestone(
          title: 'Structure',
          subtitle: 'Completed April 28, 2024',
          progress: 1.0,
          status: MilestoneStatus.done,
        ),
        Milestone(
          title: 'MEP',
          subtitle: 'Mechanical, Electrical, Plumbing',
          progress: 1.0,
          status: MilestoneStatus.done,
        ),
        Milestone(
          title: 'Plastering',
          subtitle: 'In Progress',
          progress: 0.65,
          status: MilestoneStatus.inProgress,
        ),
        Milestone(
          title: 'Interior',
          subtitle: 'Scheduled for June 2024',
          progress: 0.0,
          status: MilestoneStatus.upcoming,
        ),
        Milestone(
          title: 'Handover',
          subtitle: 'Estimated August 2024',
          progress: 0.0,
          status: MilestoneStatus.upcoming,
        ),
      ],
    );
  }
}
