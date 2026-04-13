part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final bool canGoConfirm;
  final String? email;

  const SignUpState({this.canGoConfirm = false, this.email});

  SignUpState copyWith({bool? canGoConfirm, String? email}) {
    return SignUpState(canGoConfirm: canGoConfirm ?? this.canGoConfirm, email: email ?? this.email);
  }

  @override
  List<Object?> get props => [canGoConfirm, email];
}
