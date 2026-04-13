part of 'sign_out_cubit.dart';

class SignOutState extends Equatable {
  final bool canGoLogin;

  const SignOutState({this.canGoLogin = false});

  SignOutState copyWith({bool? canGoLogin}) =>
      SignOutState(canGoLogin: canGoLogin ?? this.canGoLogin);

  @override
  List<Object?> get props => [canGoLogin];
}
