import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/repositories/payments_repository.dart';

@injectable
class GetPaymentsUseCase extends UseCase<PaymentsDataEntity, NoParams> {
  final PaymentsRepository _repository;

  GetPaymentsUseCase(this._repository);

  @override
  FutureEitherFailure<PaymentsDataEntity> call(NoParams params) =>
      _repository.getPaymentsData();
}
