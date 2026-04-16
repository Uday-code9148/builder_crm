import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/profile/data/datasources/profile_datasource.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/repositories/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  const ProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final data = await _dataSource.getProfile();
      return Right(data);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
