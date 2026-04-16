import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  FutureEitherFailure<ProfileEntity> getProfile();
}
