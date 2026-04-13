part of 'confirm_sign_up_cubit.dart';

class ConfirmSignUpState extends Equatable {
  final bool canGoLogin;

  const ConfirmSignUpState({this.canGoLogin = false});

  ConfirmSignUpState copyWith({bool? canGoLogin}) {
    return ConfirmSignUpState(canGoLogin: canGoLogin ?? this.canGoLogin);
  }

  @override
  List<Object?> get props => [canGoLogin];
}
