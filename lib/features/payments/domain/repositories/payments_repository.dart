import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';

abstract class PaymentsRepository {
  FutureEitherFailure<PaymentsData> getPaymentsData();
}
