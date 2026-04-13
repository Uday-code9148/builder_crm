import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class ResendSignUpCodeUseCase extends UseCase<void, ResendSignUpCodeModel> {
  final AuthRepository _repository;

  ResendSignUpCodeUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(ResendSignUpCodeModel params) {
    return _repository.resendSignUpCode(params);
  }
}
