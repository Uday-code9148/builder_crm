import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ConfirmForgotPasswordUseCase extends UseCase<void, ConfirmForgotPasswordModel> {
  final AuthRepository _repository;

  ConfirmForgotPasswordUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(ConfirmForgotPasswordModel params) {
    return _repository.confirmForgotPassword(params);
  }
}
