import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/repositories/profile_repository.dart';

@injectable
class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  @override
  FutureEitherFailure<ProfileEntity> call(NoParams params) => _repository.getProfile();
}
