import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/entities/user.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';

abstract class AuthRepository {
  FutureEitherFailure<User> signIn(SignInModel model);
  FutureEitherFailure<void> signUp(SignUpModel model);
  FutureEitherFailure<void> confirmSignUp(ConfirmSignUpModel model);
  FutureEitherFailure<void> resendSignUpCode(ResendSignUpCodeModel model);
  FutureEitherFailure<void> forgotPassword(ForgotPasswordModel model);
  FutureEitherFailure<void> confirmForgotPassword(ConfirmForgotPasswordModel model);
  FutureEitherFailure<void> signOut();
  FutureEitherFailure<User?> getCurrentUser();
}
