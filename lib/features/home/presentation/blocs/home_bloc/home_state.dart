part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final bool canGoLogin;

  const HomeState({this.canGoLogin = false});

  HomeState copyWith({bool? canGoLogin}) {
    return HomeState(canGoLogin: canGoLogin ?? this.canGoLogin);
  }

  @override
  List<Object?> get props => [canGoLogin];
}
