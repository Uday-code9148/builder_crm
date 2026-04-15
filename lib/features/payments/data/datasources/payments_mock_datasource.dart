import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/payment_status.dart';
import 'package:temp_architecture_app_setup/features/payments/data/datasources/payments_datasource.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';

@LazySingleton(as: PaymentsDataSource)
class PaymentsMockDataSource implements PaymentsDataSource {
  @override
  Future<PaymentsData> getPaymentsData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const PaymentsData(
      summary: PaymentSummary(totalOutstanding: '₹45,50,000', paid: '₹1,25,00,000', nextDue: '₹15,00,000'),
      items: [
        PaymentItem(
          id: 'PAY-001',
          stage: 'Slab 08 Completion',
          subtitle: '8th Floor Structural Work',
          status: PaymentStatus.overdue,
          amount: '₹15,00,000',
          amountLabel: 'AMOUNT DUE',
          dateLabel: 'DUE 12 OCT 2023',
          actionLabel: 'View Details',
        ),
        PaymentItem(
          id: 'PAY-002',
          stage: 'Brickwork Level 04',
          subtitle: 'Internal & External Masonry',
          status: PaymentStatus.pending,
          amount: '₹12,50,000',
          amountLabel: 'AMOUNT DUE',
          dateLabel: 'DUE 28 NOV 2023',
          actionLabel: 'Pay Now',
          breakdown: [
            PaymentBreakdown(label: 'Principal Amount', value: '₹11,16,071'),
            PaymentBreakdown(label: 'GST (12%)', value: '₹1,33,929'),
            PaymentBreakdown(label: 'TDS (1%)', value: '- ₹11,160'),
          ],
        ),
        PaymentItem(
          id: 'PAY-003',
          stage: 'Foundation Completion',
          subtitle: 'Raft & Piling Work Finished',
          status: PaymentStatus.paid,
          amount: '₹18,00,000',
          amountLabel: 'AMOUNT PAID',
          dateLabel: '15 SEP 2023',
          actionLabel: 'Receipt',
        ),
        PaymentItem(
          id: 'PAY-004',
          stage: 'Finishing & Plaster',
          subtitle: 'Stage 12 of 15',
          status: PaymentStatus.upcoming,
          amount: '₹8,00,000',
          amountLabel: 'EST. AMOUNT',
          dateLabel: 'JAN 2024',
          actionLabel: '',
        ),
      ],
    );
  }
}
