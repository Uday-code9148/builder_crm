import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress_entity.dart';

abstract class UpdatesRepository {
  FutureEitherFailure<ProjectProgressEntity> getProjectProgress();
}
