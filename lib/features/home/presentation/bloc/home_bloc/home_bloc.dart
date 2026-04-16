import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/app_sub_page.dart';
import 'package:temp_architecture_app_setup/core/enums/home_tab.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeTabChanged>(_onTabChanged);
    on<HomeSubPageChanged>(_onSubPageChanged);
    on<HomeSubPageCleared>(_onSubPageCleared);
  }

  void _onTabChanged(HomeTabChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(tab: event.tab, clearSubPage: true));
  }

  void _onSubPageChanged(HomeSubPageChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(subPage: event.subPage));
  }

  void _onSubPageCleared(HomeSubPageCleared event, Emitter<HomeState> emit) {
    emit(state.copyWith(clearSubPage: true));
  }
}
