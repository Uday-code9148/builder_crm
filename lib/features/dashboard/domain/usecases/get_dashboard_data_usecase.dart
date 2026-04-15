import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/repositories/dashboard_repository.dart';

@injectable
class GetDashboardDataUseCase extends UseCase<DashboardDataEntity, NoParams> {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  @override
  FutureEitherFailure<DashboardDataEntity> call(NoParams params) => _repository.getDashboardData();
}
