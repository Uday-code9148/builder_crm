import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/exceptions.dart';
import 'package:temp_architecture_app_setup/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/responce_models/user_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> signIn(SignInModel model) async {
    final result = await Amplify.Auth.signIn(username: model.email, password: model.password);
    if (result.isSignedIn) return _buildCurrentUser();
    if (result.nextStep.signInStep == AuthSignInStep.confirmSignUp) {
      throw const NeedsConfirmationException();
    }
    throw StateError('Sign-in requires additional step: ${result.nextStep.signInStep}');
  }

  @override
  Future<void> signUp(SignUpModel model) async {
    final result = await Amplify.Auth.signUp(
      username: model.email,
      password: model.password,
      options: SignUpOptions(userAttributes: {AuthUserAttributeKey.email: model.email, AuthUserAttributeKey.name: ?model.name}),
    );
    if (!result.isSignUpComplete && result.nextStep.signUpStep != AuthSignUpStep.confirmSignUp) {
      throw StateError('Unexpected sign-up step: ${result.nextStep.signUpStep}');
    }
  }

  @override
  Future<void> confirmSignUp(ConfirmSignUpModel model) async {
    final result = await Amplify.Auth.confirmSignUp(username: model.email, confirmationCode: model.confirmationCode);
    if (!result.isSignUpComplete) {
      throw StateError('Confirm sign-up incomplete: ${result.nextStep.signUpStep}');
    }
  }

  @override
  Future<void> resendSignUpCode(ResendSignUpCodeModel model) async {
    await Amplify.Auth.resendSignUpCode(username: model.email);
  }

  @override
  Future<void> forgotPassword(ForgotPasswordModel model) async {
    final result = await Amplify.Auth.resetPassword(username: model.email);
    if (!result.isPasswordReset &&
        result.nextStep.updateStep != AuthResetPasswordStep.confirmResetPasswordWithCode) {
      throw StateError('Unexpected reset step: ${result.nextStep.updateStep}');
    }
  }

  @override
  Future<void> confirmForgotPassword(ConfirmForgotPasswordModel model) async {
    await Amplify.Auth.confirmResetPassword(
      username: model.email,
      newPassword: model.newPassword,
      confirmationCode: model.confirmationCode,
    );
  }

  @override
  Future<void> signOut() async {
    final result = await Amplify.Auth.signOut() as CognitoSignOutResult;
    switch (result) {
      case CognitoCompleteSignOut():
        break;
      case CognitoPartialSignOut():
        break;
      case CognitoFailedSignOut(:final exception):
        throw exception;
    }
  }

  @override
  Future<UserModel?> fetchCurrentUser() async {
    final session = await Amplify.Auth.fetchAuthSession();
    if (!session.isSignedIn) return null;
    return _buildCurrentUser();
  }

  Future<UserModel> _buildCurrentUser() async {
    final cognitoUser = await Amplify.Auth.getCurrentUser();
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final email = _attr(attributes, 'email') ?? cognitoUser.username;
    final name = _attr(attributes, 'name') ?? '';
    return UserModel(id: cognitoUser.userId, email: email, name: name);
  }

  String? _attr(List<AuthUserAttribute> attrs, String key) => attrs.where((a) => a.userAttributeKey.key == key).map((a) => a.value).firstOrNull;
}
