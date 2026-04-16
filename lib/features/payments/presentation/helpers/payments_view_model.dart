import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';
import 'package:temp_architecture_app_setup/features/payments/presentation/helpers/payment_breakdown_resolver.dart';

class PaymentBreakdownVM {
  final String label;
  final String value;
  const PaymentBreakdownVM({required this.label, required this.value});
}

class PaymentItemVM {
  final String id;
  final String stage;
  final String subtitle;
  final String amount;
  final String amountLabel;
  final String dateLabel;
  final String actionLabel;
  final PaymentStatus status;
  final Color statusColor;
  final String statusLabel;
  final bool hasAction;
  final bool canOpenDetails;
  final List<PaymentBreakdownVM> breakdown;

  const PaymentItemVM({
    required this.id,
    required this.stage,
    required this.subtitle,
    required this.amount,
    required this.amountLabel,
    required this.dateLabel,
    required this.actionLabel,
    required this.status,
    required this.statusColor,
    required this.statusLabel,
    required this.hasAction,
    required this.canOpenDetails,
    required this.breakdown,
  });

  factory PaymentItemVM.from(PaymentItemEntity item) {
    final status = item.status ?? PaymentStatus.upcoming;
    final actionLabel = item.actionLabel ?? '';
    final hasAction = actionLabel.isNotEmpty;
    final canOpenDetails = hasAction || (item.breakdown?.isNotEmpty ?? false);
    final resolvedBreakdown = PaymentBreakdownResolver.resolve(item);
    return PaymentItemVM(
      id: item.id ?? '',
      stage: item.stage ?? '--',
      subtitle: item.subtitle ?? '--',
      amount: item.amount ?? '--',
      amountLabel: (item.amountLabel ?? '--').toUpperCase(),
      dateLabel: (item.dateLabel ?? '--').toUpperCase(),
      actionLabel: actionLabel,
      status: status,
      statusColor: status.color,
      statusLabel: status.label,
      hasAction: hasAction,
      canOpenDetails: canOpenDetails,
      breakdown: resolvedBreakdown
          .map((b) => PaymentBreakdownVM(label: b.label ?? '--', value: b.value ?? '--'))
          .toList(),
    );
  }
}

class PaymentSummaryVM {
  final String totalOutstanding;
  final String paid;
  final String nextDue;
  const PaymentSummaryVM({required this.totalOutstanding, required this.paid, required this.nextDue});
}

class PaymentsViewModel {
  final PaymentSummaryVM summary;
  final List<PaymentItemVM> allItems;

  const PaymentsViewModel({required this.summary, required this.allItems});

  factory PaymentsViewModel.from(PaymentsDataEntity data) {
    final s = data.summary;
    return PaymentsViewModel(
      summary: PaymentSummaryVM(
        totalOutstanding: s?.totalOutstanding ?? '--',
        paid: s?.paid ?? '--',
        nextDue: s?.nextDue ?? '--',
      ),
      allItems: (data.items ?? const <PaymentItemEntity>[]).map(PaymentItemVM.from).toList(),
    );
  }
}
