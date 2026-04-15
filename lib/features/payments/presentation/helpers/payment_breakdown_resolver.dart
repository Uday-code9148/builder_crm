import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';

class PaymentBreakdownResolver {
  const PaymentBreakdownResolver._();

  static const List<PaymentBreakdown> _fallbackBreakdown = <PaymentBreakdown>[
    PaymentBreakdown(label: 'Principal Amount', value: '--'),
    PaymentBreakdown(label: 'GST (12%)', value: '--'),
    PaymentBreakdown(label: 'TDS (1%)', value: '--'),
  ];

  static List<PaymentBreakdown> resolve(PaymentItem item) {
    if (item.breakdown.isNotEmpty) {
      return item.breakdown;
    }
    return _fallbackBreakdown;
  }
}
