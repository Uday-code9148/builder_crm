import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/common/constants/app_display_constants.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:temp_architecture_app_setup/features/dashboard/presentation/helpers/dashboard_view_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase _getDashboardData;

  DashboardBloc(this._getDashboardData) : super(const DashboardState()) {
    on<DashboardLoadRequested>(_onLoad);
    on<DashboardPropertySelected>(_onPropertySelected);
  }

  void _onPropertySelected(DashboardPropertySelected event, Emitter<DashboardState> emit) {
    emit(state.copyWith(selectedTitle: event.title, selectedSubtitle: event.subtitle));
  }

  FutureOr<void> _onLoad(DashboardLoadRequested event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getDashboardData(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error, error: failure.message)),
      (data) => emit(state.copyWith(status: DataStatus.loaded, viewModel: DashboardViewModel.from(data))),
    );
  }
}
