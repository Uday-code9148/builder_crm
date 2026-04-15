import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';

class PaymentBreakdown extends Equatable {
  final String label;
  final String value;

  const PaymentBreakdown({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}

class PaymentItem extends Equatable {
  final String id;
  final String stage;
  final String subtitle;
  final PaymentStatus status;
  final String amount;
  final String amountLabel;
  final String dateLabel;
  final String actionLabel; // empty string = no action
  final List<PaymentBreakdown> breakdown;

  const PaymentItem({
    required this.id,
    required this.stage,
    required this.subtitle,
    required this.status,
    required this.amount,
    required this.amountLabel,
    required this.dateLabel,
    required this.actionLabel,
    this.breakdown = const [],
  });

  @override
  List<Object?> get props => [id, stage, subtitle, status, amount, amountLabel, dateLabel, actionLabel, breakdown];
}

class PaymentSummary extends Equatable {
  final String totalOutstanding;
  final String paid;
  final String nextDue;

  const PaymentSummary({required this.totalOutstanding, required this.paid, required this.nextDue});

  @override
  List<Object?> get props => [totalOutstanding, paid, nextDue];
}

class PaymentsData extends Equatable {
  final PaymentSummary summary;
  final List<PaymentItem> items;

  const PaymentsData({required this.summary, required this.items});

  @override
  List<Object?> get props => [summary, items];
}
