import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';

@LazySingleton(as: DashboardDataSource)
class DashboardMockDataSource implements DashboardDataSource {
  @override
  Future<DashboardDataEntity> getDashboardData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const DashboardDataEntity(
      userName: 'Rajesh',
      greeting: 'Good Morning, Rajesh',
      alert: AlertInfoEntity(title: 'Action Required: Pending Payment', subtitle: 'Overdue amount of ₹15,00,000'),
      paymentSnapshot: PaymentSnapshotEntity(totalPaid: '₹84,50,000', nextDue: '₹42,20,000', balance: '₹42,30,000', progressPercent: 0.65),
      construction: ConstructionProgressEntity(progressPercent: 0.49, phase: 'Phase 2 – MEP Works', projectName: 'The Emerald Pavilion', unit: 'Unit 402'),
      unitInfo: UnitInfoEntity(configuration: '3 BHK Luxury', coverArea: '1,840 sq.ft.', floorWing: '22W / A Wing'),
      recentActivities: [
        ActivityItemEntity(
          iconAsset: ImageResources.icMaintainanceConfirmed,
          title: 'Maintenance Payment Confirmed',
          subtitle: 'The Possession Transfer Template accepted',
          timeLabel: 'Yesterday',
        ),
        ActivityItemEntity(
          iconAsset: ImageResources.icNewDocUploaded,
          title: 'New Document Updated',
          subtitle: 'Purchase Agreement - Amendment uploaded',
          timeLabel: 'Yesterday',
        ),
        ActivityItemEntity(
          iconAsset: ImageResources.icDemandLetterGenerated,
          title: 'Demand Letter Generated',
          subtitle: 'Payment due for MilestoneEntity Completion',
          timeLabel: '2 days ago',
        ),
      ],
    );
  }
}
