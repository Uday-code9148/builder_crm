part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final bool canGoLogin;

  const ResetPasswordState({this.canGoLogin = false});

  ResetPasswordState copyWith({bool? canGoLogin}) {
    return ResetPasswordState(canGoLogin: canGoLogin ?? this.canGoLogin);
  }

  @override
  List<Object?> get props => [canGoLogin];
}
