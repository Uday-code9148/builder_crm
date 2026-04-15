import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/repositories/dashboard_repository.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDataSource _dataSource;

  const DashboardRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, DashboardDataEntity>> getDashboardData() async {
    try {
      final data = await _dataSource.getDashboardData();
      return Right(data);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
