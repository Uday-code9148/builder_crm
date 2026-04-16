import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileDataSource {
  Future<ProfileEntity> getProfile();
}
