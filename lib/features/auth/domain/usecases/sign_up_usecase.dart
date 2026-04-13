import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignUpUseCase extends UseCase<void, SignUpModel> {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(SignUpModel params) => _repository.signUp(params);
}
