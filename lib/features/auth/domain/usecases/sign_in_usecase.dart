import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/entities/user_entity.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignInUseCase extends UseCase<UserEntity, SignInModel> {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  @override
  FutureEitherFailure<UserEntity> call(SignInModel params) => _repository.signIn(params);
}
