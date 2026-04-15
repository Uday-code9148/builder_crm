import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data.dart';

@LazySingleton(as: DashboardDataSource)
class DashboardMockDataSource implements DashboardDataSource {
  @override
  Future<DashboardData> getDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const DashboardData(
      userName: 'Rajesh',
      greeting: 'Good Morning, Rajesh',
      alert: AlertInfo(title: 'Action Required: Pending Payment', subtitle: 'Overdue amount of ₹15,00,000'),
      paymentSnapshot: PaymentSnapshot(totalPaid: '₹84,50,000', nextDue: '₹42,20,000', balance: '₹42,30,000', progressPercent: 0.65),
      construction: ConstructionProgress(progressPercent: 0.49, phase: 'Phase 2 – MEP Works', projectName: 'The Emerald Pavilion', unit: 'Unit 402'),
      unitInfo: UnitInfo(configuration: '3 BHK Luxury', coverArea: '1,840 sq.ft.', floorWing: '22W / A Wing'),
      recentActivities: [
        ActivityItem(
          iconAsset: ImageResources.icMaintainanceConfirmed,
          title: 'Maintenance Payment Confirmed',
          subtitle: 'The Possession Transfer Template accepted',
          timeLabel: 'Yesterday',
        ),
        ActivityItem(
          iconAsset: ImageResources.icNewDocUploaded,
          title: 'New Document Updated',
          subtitle: 'Purchase Agreement - Amendment uploaded',
          timeLabel: 'Yesterday',
        ),
        ActivityItem(
          iconAsset: ImageResources.icDemandLetterGenerated,
          title: 'Demand Letter Generated',
          subtitle: 'Payment due for Milestone Completion',
          timeLabel: '2 days ago',
        ),
      ],
    );
  }
}
