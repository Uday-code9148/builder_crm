import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/enums/snackbar_type.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/confirm_sign_up_usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/resend_sign_up_code_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'confirm_sign_up_state.dart';

@injectable
class ConfirmSignUpCubit extends Cubit<ConfirmSignUpState> {
  final ConfirmSignUpUseCase _confirmSignUp;
  final ResendSignUpCodeUseCase _resendCode;

  ConfirmSignUpCubit(this._confirmSignUp, this._resendCode) : super(const ConfirmSignUpState());

  Future<void> confirmSignUp({required String email, required String code}) async {
    AppLoadingDialog.show(message: 'Verifying account...');
    final result = await _confirmSignUp(ConfirmSignUpModel(email: email, confirmationCode: code));
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.show(message: failure.message, navigatorKey: MyApp.navigatorKey, type: SnackbarType.error),
      (_) {
        AppSnackbar.show(message: 'Account verified! You can now sign in.', navigatorKey: MyApp.navigatorKey, type: SnackbarType.success);
        emit(state.copyWith(canGoLogin: true));
      },
    );
  }

  Future<void> resendCode({required String email}) async {
    AppLoadingDialog.show(message: 'Resending code...');
    final result = await _resendCode(ResendSignUpCodeModel(email: email));
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.showError(navigatorKey: MyApp.navigatorKey, message: failure.message),
      (_) => AppSnackbar.showSuccess(navigatorKey: MyApp.navigatorKey, message: 'Verification code sent!'),
    );
  }
}
