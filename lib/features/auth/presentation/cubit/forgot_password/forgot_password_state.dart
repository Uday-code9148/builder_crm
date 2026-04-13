part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final bool canGoResetPassword;
  final String? email;

  const ForgotPasswordState({this.canGoResetPassword = false, this.email});

  ForgotPasswordState copyWith({bool? canGoResetPassword, String? email}) {
    return ForgotPasswordState(
      canGoResetPassword: canGoResetPassword ?? this.canGoResetPassword,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [canGoResetPassword, email];
}
