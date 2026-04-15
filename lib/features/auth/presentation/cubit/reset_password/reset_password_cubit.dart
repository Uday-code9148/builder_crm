import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/enums/snackbar_type.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/confirm_forgot_password_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ConfirmForgotPasswordUseCase _confirmForgotPassword;

  ResetPasswordCubit(this._confirmForgotPassword) : super(const ResetPasswordState());

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    AppLoadingDialog.show(message: 'Resetting password...');
    final result = await _confirmForgotPassword(
      ConfirmForgotPasswordModel(email: email, newPassword: newPassword, confirmationCode: code),
    );
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.show(
        message: failure.message,
        navigatorKey: MyApp.navigatorKey,
        type: SnackbarType.error,
      ),
      (_) {
        AppSnackbar.show(
          message: 'Password reset successfully. Please sign in.',
          navigatorKey: MyApp.navigatorKey,
          type: SnackbarType.success,
        );
        emit(state.copyWith(canGoLogin: true));
      },
    );
  }
}
