import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/entities/user_entity.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@injectable
class CheckAuthStatusUseCase extends UseCase<UserEntity?, NoParams> {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  @override
  FutureEitherFailure<UserEntity?> call(NoParams params) => _repository.getCurrentUser();
}
