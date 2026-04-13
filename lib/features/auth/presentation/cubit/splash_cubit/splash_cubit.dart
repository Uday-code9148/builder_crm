import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/check_auth_status_usecase.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final CheckAuthStatusUseCase _checkAuthStatus;

  SplashCubit(this._checkAuthStatus) : super(const SplashState());

  Future<void> checkAuthStatus() async {
    final result = await _checkAuthStatus(const NoParams());

    result.fold(
      (_) {
        emit(state.copyWith(canGoLogin: true));
      },
      (user) {
        user != null ? emit(state.copyWith(canGoHome: true)) : emit(state.copyWith(canGoLogin: true));
      },
    );
  }
}
