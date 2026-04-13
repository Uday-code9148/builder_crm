part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final bool canGoHome;
  final bool needsConfirmation;
  final String? confirmEmail;

  const SignInState({this.canGoHome = false, this.needsConfirmation = false, this.confirmEmail});

  SignInState copyWith({bool? canGoHome, bool? needsConfirmation, String? confirmEmail}) {
    return SignInState(
      canGoHome: canGoHome ?? this.canGoHome,
      needsConfirmation: needsConfirmation ?? this.needsConfirmation,
      confirmEmail: confirmEmail ?? this.confirmEmail,
    );
  }

  @override
  List<Object?> get props => [canGoHome, needsConfirmation, confirmEmail];
}
