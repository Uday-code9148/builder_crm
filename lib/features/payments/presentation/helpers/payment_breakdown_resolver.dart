import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';

class PaymentBreakdownResolver {
  const PaymentBreakdownResolver._();

  static const List<PaymentBreakdownEntity> _fallbackBreakdown = <PaymentBreakdownEntity>[
    PaymentBreakdownEntity(label: 'Principal Amount', value: '--'),
    PaymentBreakdownEntity(label: 'GST (12%)', value: '--'),
    PaymentBreakdownEntity(label: 'TDS (1%)', value: '--'),
  ];

  static List<PaymentBreakdownEntity> resolve(PaymentItemEntity item) {
    final breakdown = item.breakdown ?? const <PaymentBreakdownEntity>[];
    if (breakdown.isNotEmpty) {
      return breakdown;
    }
    return _fallbackBreakdown;
  }
}
