import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data.dart';

abstract class DashboardDataSource {
  Future<DashboardData> getDashboardData();
}
