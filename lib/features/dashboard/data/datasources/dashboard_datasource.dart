import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';

abstract class DashboardDataSource {
  Future<DashboardDataEntity> getDashboardData();
}
