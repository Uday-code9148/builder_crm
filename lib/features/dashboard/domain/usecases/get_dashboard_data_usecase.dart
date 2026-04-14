import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/repositories/dashboard_repository.dart';

@injectable
class GetDashboardDataUseCase extends UseCase<DashboardData, NoParams> {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  @override
  FutureEitherFailure<DashboardData> call(NoParams params) =>
      _repository.getDashboardData();
}
