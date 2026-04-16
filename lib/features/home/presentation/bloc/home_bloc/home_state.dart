part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {
  final HomeTab tab;
  final AppSubPage? subPage;

  const HomeState({this.tab = HomeTab.home, this.subPage});

  int get stackIndex => subPage == null ? tab.index : HomeTab.values.length + subPage!.index;

  HomeTab get activeNavTab => subPage?.parentTab ?? tab;

  HomeState copyWith({HomeTab? tab, AppSubPage? subPage, bool clearSubPage = false}) => HomeState(
    tab: tab ?? this.tab,
    subPage: clearSubPage ? null : subPage ?? this.subPage,
  );

  @override
  List<Object?> get props => [tab, subPage];
}
