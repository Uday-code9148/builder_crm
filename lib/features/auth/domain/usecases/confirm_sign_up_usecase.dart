import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ConfirmSignUpUseCase extends UseCase<void, ConfirmSignUpModel> {
  final AuthRepository _repository;

  ConfirmSignUpUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(ConfirmSignUpModel params) => _repository.confirmSignUp(params);
}
