import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress.dart';

abstract class UpdatesDataSource {
  Future<ProjectProgress> getProjectProgress();
}
