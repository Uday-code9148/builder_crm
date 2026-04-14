import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';

abstract class PaymentsDataSource {
  Future<PaymentsData> getPaymentsData();
}
