class AlertInfoEntity {
  final String? title;
  final String? subtitle;

  const AlertInfoEntity({this.title, this.subtitle});
}

class PaymentSnapshotEntity {
  final String? totalPaid;
  final String? nextDue;
  final String? balance;
  final double? progressPercent;

  const PaymentSnapshotEntity({this.totalPaid, this.nextDue, this.balance, this.progressPercent});
}

class ConstructionProgressEntity {
  final double? progressPercent;
  final String? phase;
  final String? projectName;
  final String? unit;

  const ConstructionProgressEntity({this.progressPercent, this.phase, this.projectName, this.unit});
}

class UnitInfoEntity {
  final String? configuration;
  final String? coverArea;
  final String? floorWing;

  const UnitInfoEntity({this.configuration, this.coverArea, this.floorWing});
}

class ActivityItemEntity {
  final String? iconAsset;
  final String? title;
  final String? subtitle;
  final String? timeLabel;

  const ActivityItemEntity({this.iconAsset, this.title, this.subtitle, this.timeLabel});
}

class DashboardDataEntity {
  final String? userName;
  final String? greeting;
  final AlertInfoEntity? alert;
  final PaymentSnapshotEntity? paymentSnapshot;
  final ConstructionProgressEntity? construction;
  final UnitInfoEntity? unitInfo;
  final List<ActivityItemEntity>? recentActivities;

  const DashboardDataEntity({
    this.userName,
    this.greeting,
    this.alert,
    this.paymentSnapshot,
    this.construction,
    this.unitInfo,
    this.recentActivities,
  });
}
