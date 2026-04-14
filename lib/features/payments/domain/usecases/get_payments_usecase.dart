import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/repositories/payments_repository.dart';

@injectable
class GetPaymentsUseCase extends UseCase<PaymentsData, NoParams> {
  final PaymentsRepository _repository;

  GetPaymentsUseCase(this._repository);

  @override
  FutureEitherFailure<PaymentsData> call(NoParams params) =>
      _repository.getPaymentsData();
}
