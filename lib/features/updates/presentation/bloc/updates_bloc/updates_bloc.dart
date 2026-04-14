import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/entities/project_progress.dart';
import 'package:temp_architecture_app_setup/features/updates/domain/usecases/get_project_progress_usecase.dart';

part 'updates_event.dart';
part 'updates_state.dart';

@injectable
class UpdatesBloc extends Bloc<UpdatesEvent, UpdatesState> {
  final GetProjectProgressUseCase _getProjectProgress;

  UpdatesBloc(this._getProjectProgress) : super(const UpdatesState()) {
    on<UpdatesLoadRequested>(_onLoad);
  }

  FutureOr<void> _onLoad(
    UpdatesLoadRequested event,
    Emitter<UpdatesState> emit,
  ) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getProjectProgress(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error, error: failure.message)),
      (data) => emit(state.copyWith(status: DataStatus.loaded, data: data)),
    );
  }
}
