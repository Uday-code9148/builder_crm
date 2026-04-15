import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/exceptions.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/core/network/rest_service_base.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/entities/user_entity.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/resend_sign_up_code_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_in_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/confirm_forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/forgot_password_model.dart';
import 'package:temp_architecture_app_setup/features/auth/data/models/request_models/sign_up_model.dart';
import 'package:temp_architecture_app_setup/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  const AuthRepositoryImpl(this._remote);

  @override
  FutureEitherFailure<UserEntity> signIn(SignInModel model) async {
    try {
      final user = await _remote.signIn(model);
      return Right(user);
    } on NeedsConfirmationException {
      return Left(ConfirmationRequiredFailure(model.email));
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> signUp(SignUpModel model) async {
    try {
      await _remote.signUp(model);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> confirmSignUp(ConfirmSignUpModel model) async {
    try {
      await _remote.confirmSignUp(model);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> resendSignUpCode(ResendSignUpCodeModel model) async {
    try {
      await _remote.resendSignUpCode(model);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> signOut() async {
    try {
      RestServiceBase.cancelAll();
      await _remote.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> forgotPassword(ForgotPasswordModel model) async {
    try {
      await _remote.forgotPassword(model);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<void> confirmForgotPassword(ConfirmForgotPasswordModel model) async {
    try {
      await _remote.confirmForgotPassword(model);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }

  @override
  FutureEitherFailure<UserEntity?> getCurrentUser() async {
    try {
      final user = await _remote.fetchCurrentUser();
      return Right(user);
    } on AuthException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
