import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/common_more_widget.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/entities/dashboard_data_entity.dart';

class DashboardAlertVM {
  final String title;
  final String subtitle;
  const DashboardAlertVM({required this.title, required this.subtitle});
}

class DashboardPaymentVM {
  final String totalPaid;
  final String nextDue;
  final String balance;
  final double progressPercent;
  const DashboardPaymentVM({
    required this.totalPaid,
    required this.nextDue,
    required this.balance,
    required this.progressPercent,
  });
}

class DashboardConstructionVM {
  final double progressPercent;
  final String progressLabel;
  const DashboardConstructionVM({required this.progressPercent, required this.progressLabel});
}

class DashboardUnitVM {
  final String configuration;
  final String coverArea;
  final String floorWing;
  const DashboardUnitVM({required this.configuration, required this.coverArea, required this.floorWing});
}

class DashboardActivityVM {
  final String iconAsset;
  final String title;
  final String subtitle;
  final String timeLabel;
  const DashboardActivityVM({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
  });
}

class DashboardViewModel {
  final String greeting;
  final DashboardAlertVM? alert;
  final DashboardPaymentVM paymentSnapshot;
  final DashboardConstructionVM construction;
  final DashboardUnitVM unitInfo;
  final List<DashboardActivityVM> activities;
  final List<AppMenuEntry> projectMenuItems;

  const DashboardViewModel({
    required this.greeting,
    required this.alert,
    required this.paymentSnapshot,
    required this.construction,
    required this.unitInfo,
    required this.activities,
    required this.projectMenuItems,
  });

  factory DashboardViewModel.from(DashboardDataEntity data) {
    final snap = data.paymentSnapshot;
    final con = data.construction;
    final unit = data.unitInfo;
    return DashboardViewModel(
      greeting: data.greeting ?? '--',
      alert: data.alert == null
          ? null
          : DashboardAlertVM(
              title: data.alert!.title ?? '--',
              subtitle: data.alert!.subtitle ?? '--',
            ),
      paymentSnapshot: DashboardPaymentVM(
        totalPaid: snap?.totalPaid ?? '--',
        nextDue: snap?.nextDue ?? '--',
        balance: snap?.balance ?? '--',
        progressPercent: snap?.progressPercent ?? 0,
      ),
      construction: DashboardConstructionVM(
        progressPercent: con?.progressPercent ?? 0,
        progressLabel: '${((con?.progressPercent ?? 0) * 100).toInt()}%',
      ),
      unitInfo: DashboardUnitVM(
        configuration: unit?.configuration ?? '--',
        coverArea: unit?.coverArea ?? '--',
        floorWing: unit?.floorWing ?? '--',
      ),
      activities: (data.recentActivities ?? const <ActivityItemEntity>[])
          .map(
            (a) => DashboardActivityVM(
              iconAsset: a.iconAsset ?? ImageResources.icUpdates,
              title: a.title ?? '--',
              subtitle: a.subtitle ?? '--',
              timeLabel: a.timeLabel ?? '--',
            ),
          )
          .toList(),
      projectMenuItems: _buildProjectMenu(data.projects ?? const []),
    );
  }

  static List<AppMenuEntry> _buildProjectMenu(List<ProjectEntryEntity> projects) {
    return [
      const AppMenuHeaderEntry('Switch Project'),
      ...projects.map(
        (p) => AppMenuItemEntry(
          icon: Icons.apartment_rounded,
          title: p.name,
          subtitle: '${p.unit} · ${p.statusLabel}',
        ),
      ),
      const AppMenuDividerEntry(),
      const AppMenuItemEntry(icon: Icons.add_circle_outline_rounded, title: 'Add New Property'),
    ];
  }
}
