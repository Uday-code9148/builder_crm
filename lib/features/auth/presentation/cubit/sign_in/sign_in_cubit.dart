import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signIn;

  SignInCubit(this._signIn) : super(const SignInState());

  Future<void> signIn({required String email, required String password}) async {
    AppLoadingDialog.show(message: 'Signing in...');
    final result = await _signIn(SignInModel(email: email, password: password));
    AppLoadingDialog.hide();

    result.fold(
      (failure) {
        if (failure is ConfirmationRequiredFailure) {
          AppSnackbar.show(message: 'Please verify your account first.', navigatorKey: MyApp.navigatorKey, type: SnackbarType.warning);
          emit(state.copyWith(needsConfirmation: true, confirmEmail: failure.email));
        } else {
          AppSnackbar.show(message: failure.message, navigatorKey: MyApp.navigatorKey, type: SnackbarType.error);
        }
      },
      (_) {
        AppSnackbar.show(message: 'Logged in successfully', navigatorKey: MyApp.navigatorKey, type: SnackbarType.success);
        emit(state.copyWith(canGoHome: true));
      },
    );
  }
}
