import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/features/profile/data/datasources/profile_datasource.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';

@LazySingleton(as: ProfileDataSource)
class ProfileMockDataSource implements ProfileDataSource {
  @override
  Future<ProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const ProfileEntity(
      phone: '+91 98765 43210',
      dateOfBirth: '15 Aug 1995',
      memberSince: '2023',
      ticketsRaised: 4,
      documentsCount: 12,
      property: PropertyDetailEntity(
        projectName: 'The Emerald Pavilion',
        unit: 'Unit 402',
        phase: 'Possession Phase',
        bookingDate: '12 Mar 2023',
      ),
    );
  }
}
