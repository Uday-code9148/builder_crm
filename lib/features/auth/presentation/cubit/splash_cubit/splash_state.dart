part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool canGoHome;
  final bool canGoLogin;

  const SplashState({this.canGoHome = false, this.canGoLogin = false});

  SplashState copyWith({bool? canGoHome, bool? canGoLogin}) => SplashState(
        canGoHome: canGoHome ?? this.canGoHome,
        canGoLogin: canGoLogin ?? this.canGoLogin,
      );

  @override
  List<Object?> get props => [canGoHome, canGoLogin];
}
