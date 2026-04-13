import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/logout_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'sign_out_state.dart';

@injectable
class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOut;

  SignOutCubit(this._signOut) : super(const SignOutState());

  Future<void> signOut() async {
    AppLoadingDialog.show(message: 'Signing out...');
    final result = await _signOut(const NoParams());
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.showError(navigatorKey: MyApp.navigatorKey, message: failure.message),
      (_) {
        AppSnackbar.showSuccess(navigatorKey: MyApp.navigatorKey, message: 'Signed out successfully');
        emit(state.copyWith(canGoLogin: true));
      },
    );
  }
}
