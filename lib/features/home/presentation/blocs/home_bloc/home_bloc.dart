import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
  }

  FutureOr<void> _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {}
}
