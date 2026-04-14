import 'package:equatable/equatable.dart';

class AlertInfo extends Equatable {
  final String title;
  final String subtitle;

  const AlertInfo({required this.title, required this.subtitle});

  @override
  List<Object?> get props => [title, subtitle];
}

class PaymentSnapshot extends Equatable {
  final String totalPaid;
  final String nextDue;
  final String balance;
  final double progressPercent; // 0.0 – 1.0

  const PaymentSnapshot({
    required this.totalPaid,
    required this.nextDue,
    required this.balance,
    required this.progressPercent,
  });

  @override
  List<Object?> get props => [totalPaid, nextDue, balance, progressPercent];
}

class ConstructionProgress extends Equatable {
  final double progressPercent; // 0.0 – 1.0
  final String phase;
  final String projectName;
  final String unit;

  const ConstructionProgress({
    required this.progressPercent,
    required this.phase,
    required this.projectName,
    required this.unit,
  });

  @override
  List<Object?> get props => [progressPercent, phase, projectName, unit];
}

class UnitInfo extends Equatable {
  final String configuration;
  final String coverArea;
  final String floorWing;

  const UnitInfo({
    required this.configuration,
    required this.coverArea,
    required this.floorWing,
  });

  @override
  List<Object?> get props => [configuration, coverArea, floorWing];
}

class ActivityItem extends Equatable {
  final String iconAsset; // SVG asset path
  final String title;
  final String subtitle;
  final String timeLabel;

  const ActivityItem({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
  });

  @override
  List<Object?> get props => [iconAsset, title, subtitle, timeLabel];
}

class DashboardData extends Equatable {
  final String userName;
  final String greeting;
  final AlertInfo? alert;
  final PaymentSnapshot paymentSnapshot;
  final ConstructionProgress construction;
  final UnitInfo unitInfo;
  final List<ActivityItem> recentActivities;

  const DashboardData({
    required this.userName,
    required this.greeting,
    this.alert,
    required this.paymentSnapshot,
    required this.construction,
    required this.unitInfo,
    required this.recentActivities,
  });

  @override
  List<Object?> get props => [
        userName,
        greeting,
        alert,
        paymentSnapshot,
        construction,
        unitInfo,
        recentActivities,
      ];
}
