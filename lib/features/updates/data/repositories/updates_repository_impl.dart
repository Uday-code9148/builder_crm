import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/updates/data/datasources/updates_datasource.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/repositories/updates_repository.dart';

@Injectable(as: UpdatesRepository)
class UpdatesRepositoryImpl implements UpdatesRepository {
  final UpdatesDataSource _dataSource;

  const UpdatesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ProjectProgress>> getProjectProgress() async {
    try {
      final data = await _dataSource.getProjectProgress();
      return Right(data);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
