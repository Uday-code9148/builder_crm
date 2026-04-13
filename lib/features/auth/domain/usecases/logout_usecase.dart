import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  @override
  FutureEitherFailure<void> call(NoParams params) => _repository.signOut();
}
