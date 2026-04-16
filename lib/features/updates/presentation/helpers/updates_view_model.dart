import 'package:temp_architecture_app_setup/core/enums/milestone_status.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/milestone_entity.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress_entity.dart';

class MilestoneVM {
  final String title;
  final String subtitle;
  final double progress;
  final String progressPct;
  final MilestoneStatus status;
  final bool isDone;
  final bool isInProgress;
  final bool isUpcoming;

  const MilestoneVM({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressPct,
    required this.status,
    required this.isDone,
    required this.isInProgress,
    required this.isUpcoming,
  });

  factory MilestoneVM.from(MilestoneEntity milestone) {
    final status = milestone.status ?? MilestoneStatus.upcoming;
    final progress = milestone.progress ?? 0;
    return MilestoneVM(
      title: milestone.title ?? '--',
      subtitle: milestone.subtitle ?? '--',
      progress: progress,
      progressPct: '${(progress * 100).toInt()}%',
      status: status,
      isDone: status == MilestoneStatus.done,
      isInProgress: status == MilestoneStatus.inProgress,
      isUpcoming: status == MilestoneStatus.upcoming,
    );
  }
}

class UpdatesViewModel {
  final String projectName;
  final String unit;
  final double overallProgress;
  final String overallProgressPct;
  final String lastUpdatedLabel;
  final List<MilestoneVM> milestones;

  const UpdatesViewModel({
    required this.projectName,
    required this.unit,
    required this.overallProgress,
    required this.overallProgressPct,
    required this.lastUpdatedLabel,
    required this.milestones,
  });

  factory UpdatesViewModel.from(ProjectProgressEntity data) {
    final progress = data.overallProgress ?? 0;
    return UpdatesViewModel(
      projectName: data.projectName ?? '--',
      unit: data.unit ?? '--',
      overallProgress: progress,
      overallProgressPct: '${(progress * 100).toInt()}%',
      lastUpdatedLabel: data.lastUpdated ?? '--',
      milestones: (data.milestones ?? const <MilestoneEntity>[]).map(MilestoneVM.from).toList(),
    );
  }
}
