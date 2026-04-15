import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/enums/snackbar_type.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPassword;

  ForgotPasswordCubit(this._forgotPassword) : super(const ForgotPasswordState());

  Future<void> sendResetCode({required String email}) async {
    AppLoadingDialog.show(message: 'Sending reset code...');
    final result = await _forgotPassword(ForgotPasswordModel(email: email));
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.show(
        message: failure.message,
        navigatorKey: MyApp.navigatorKey,
        type: SnackbarType.error,
      ),
      (_) {
        AppSnackbar.show(
          message: 'Reset code sent to $email',
          navigatorKey: MyApp.navigatorKey,
          type: SnackbarType.success,
        );
        emit(state.copyWith(canGoResetPassword: true, email: email));
      },
    );
  }
}
