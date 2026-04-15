import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';

abstract class PaymentsDataSource {
  Future<PaymentsDataEntity> getPaymentsData();
}
