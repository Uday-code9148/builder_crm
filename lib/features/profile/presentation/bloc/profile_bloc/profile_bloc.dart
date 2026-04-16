import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:temp_architecture_app_setup/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:temp_architecture_app_setup/features/profile/presentation/helpers/profile_view_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfile;
  final CheckAuthStatusUseCase _getAuthUser;

  ProfileBloc(this._getProfile, this._getAuthUser) : super(const ProfileState()) {
    on<ProfileLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final profileResult = await _getProfile(const NoParams());
    final authResult = await _getAuthUser(const NoParams());

    profileResult.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, errorMessage: failure.message)),
      (profile) {
        final authUser = authResult.fold((_) => null, (u) => u);
        final viewModel = ProfileViewModel.from(profile, authUser);
        emit(state.copyWith(status: ProfileStatus.loaded, viewModel: viewModel));
      },
    );
  }
}
