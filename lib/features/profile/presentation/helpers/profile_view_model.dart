import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/entities/user_entity.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/entities/profile_entity.dart';

/// Presentation-ready model built once in [ProfileBloc].
/// All fields are pre-computed non-nullable strings —
/// the page never needs null checks or string formatting logic.
class ProfileViewModel {
  final String initials;
  final String displayName;
  final String displayEmail;
  final String displayPhone;
  final String displayDob;
  final String memberSince;
  final String ticketsCount;
  final String documentsCount;
  final String projectName;
  final String unit;
  final String phase;
  final String bookingDate;

  const ProfileViewModel({
    required this.initials,
    required this.displayName,
    required this.displayEmail,
    required this.displayPhone,
    required this.displayDob,
    required this.memberSince,
    required this.ticketsCount,
    required this.documentsCount,
    required this.projectName,
    required this.unit,
    required this.phase,
    required this.bookingDate,
  });

  /// Builds the view model by merging real auth data (name, email) over
  /// the mock/remote profile entity.
  factory ProfileViewModel.from(ProfileEntity profile, UserEntity? authUser) {
    final name = (authUser?.name?.isNotEmpty == true ? authUser!.name! : profile.name) ?? '';
    final email = (authUser?.email?.isNotEmpty == true ? authUser!.email! : profile.email) ?? '';

    return ProfileViewModel(
      initials: _initials(name),
      displayName: name.isNotEmpty ? name : '—',
      displayEmail: email.isNotEmpty ? email : '—',
      displayPhone: profile.phone ?? '—',
      displayDob: profile.dateOfBirth ?? '—',
      memberSince: profile.memberSince ?? '—',
      ticketsCount: '${profile.ticketsRaised ?? 0}',
      documentsCount: '${profile.documentsCount ?? 0}',
      projectName: profile.property?.projectName ?? AppDisplayConstants.projectName,
      unit: profile.property?.unit ?? '—',
      phase: profile.property?.phase ?? '—',
      bookingDate: profile.property?.bookingDate ?? '—',
    );
  }

  static String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
