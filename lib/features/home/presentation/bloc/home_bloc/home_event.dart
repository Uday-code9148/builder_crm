part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeTabChanged extends HomeEvent {
  final HomeTab tab;
  HomeTabChanged(this.tab);
}

class HomeSubPageChanged extends HomeEvent {
  final AppSubPage subPage;
  HomeSubPageChanged(this.subPage);
}

class HomeSubPageCleared extends HomeEvent {}
