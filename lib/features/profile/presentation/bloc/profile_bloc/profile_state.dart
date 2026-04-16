part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

@immutable
class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileViewModel? viewModel;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.viewModel,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileViewModel? viewModel,
    String? errorMessage,
  }) => ProfileState(
    status: status ?? this.status,
    viewModel: viewModel ?? this.viewModel,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, viewModel, errorMessage];
}
