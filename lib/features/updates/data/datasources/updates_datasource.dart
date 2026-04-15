import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress_entity.dart';

abstract class UpdatesDataSource {
  Future<ProjectProgressEntity> getProjectProgress();
}
