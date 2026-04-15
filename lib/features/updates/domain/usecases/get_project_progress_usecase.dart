import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/repositories/updates_repository.dart';

@injectable
class GetProjectProgressUseCase extends UseCase<ProjectProgress, NoParams> {
  final UpdatesRepository _repository;

  GetProjectProgressUseCase(this._repository);

  @override
  FutureEitherFailure<ProjectProgress> call(NoParams params) => _repository.getProjectProgress();
}
