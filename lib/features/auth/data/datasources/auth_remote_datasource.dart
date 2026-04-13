import 'package:temp_architecture_app_setup/features/auth/data/models/responce_models/user_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(SignInModel model);
  Future<void> signUp(SignUpModel model);
  Future<void> confirmSignUp(ConfirmSignUpModel model);
  Future<void> resendSignUpCode(ResendSignUpCodeModel model);
  Future<void> forgotPassword(ForgotPasswordModel model);
  Future<void> confirmForgotPassword(ConfirmForgotPasswordModel model);
  Future<void> signOut();
  Future<UserModel?> fetchCurrentUser();
}
