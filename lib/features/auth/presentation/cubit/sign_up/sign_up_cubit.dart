import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_loading_dialog.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/app_snackbar.dart';
import 'package:temp_architecture_app_setup/core/enums/snackbar_type.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:temp_architecture_app_setup/main.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUp;

  SignUpCubit(this._signUp) : super(const SignUpState());

  Future<void> signUp({required String email, required String password, String? name}) async {
    AppLoadingDialog.show(message: 'Creating account...');
    final result = await _signUp(SignUpModel(email: email, password: password, name: name));
    AppLoadingDialog.hide();

    result.fold(
      (failure) => AppSnackbar.show(message: failure.message, navigatorKey: MyApp.navigatorKey, type: SnackbarType.error),
      (_) {
        AppSnackbar.show(message: 'Account created! Please verify your email.', navigatorKey: MyApp.navigatorKey, type: SnackbarType.success);
        emit(state.copyWith(canGoConfirm: true, email: email));
      },
    );
  }
}
