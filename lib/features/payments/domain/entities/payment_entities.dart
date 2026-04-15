import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';

class PaymentBreakdownEntity {
  final String? label;
  final String? value;

  const PaymentBreakdownEntity({this.label, this.value});
}

class PaymentItemEntity {
  final String? id;
  final String? stage;
  final String? subtitle;
  final PaymentStatus? status;
  final String? amount;
  final String? amountLabel;
  final String? dateLabel;
  final String? actionLabel; // empty string = no action
  final List<PaymentBreakdownEntity>? breakdown;

  const PaymentItemEntity({
    this.id,
    this.stage,
    this.subtitle,
    this.status,
    this.amount,
    this.amountLabel,
    this.dateLabel,
    this.actionLabel = '',
    this.breakdown = const [],
  });
}

class PaymentSummaryEntity {
  final String? totalOutstanding;
  final String? paid;
  final String? nextDue;

  const PaymentSummaryEntity({this.totalOutstanding, this.paid, this.nextDue});
}

class PaymentsDataEntity {
  final PaymentSummaryEntity? summary;
  final List<PaymentItemEntity>? items;

  const PaymentsDataEntity({this.summary, this.items});
}

