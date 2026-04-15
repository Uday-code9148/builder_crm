import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';

abstract class DashboardRepository {
  FutureEitherFailure<DashboardDataEntity> getDashboardData();
}
