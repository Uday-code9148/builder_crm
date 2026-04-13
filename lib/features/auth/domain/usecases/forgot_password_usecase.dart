import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ForgotPasswordUseCase extends UseCase<void, ForgotPasswordModel> {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(ForgotPasswordModel params) {
    return _repository.forgotPassword(params);
  }
}
