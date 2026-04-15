import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/data_status.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';
import 'package:temp_architecture_app_setup/features/support/domain/usecase/get_support_tickets_usecase.dart';

part 'support_event.dart';
part 'support_state.dart';

@injectable
class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final GetSupportTicketsUseCase _getTickets;

  SupportBloc(this._getTickets) : super(const SupportState()) {
    on<SupportLoadRequested>(_onLoad);
    on<SupportFilterChanged>(_onFilterChanged);
    on<SupportTicketAdded>(_onTicketAdded);
  }

  FutureOr<void> _onLoad(SupportLoadRequested event, Emitter<SupportState> emit) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getTickets(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: DataStatus.error, error: failure.message)),
      (tickets) => emit(state.copyWith(status: DataStatus.loaded, tickets: tickets)),
    );
  }

  FutureOr<void> _onFilterChanged(SupportFilterChanged event, Emitter<SupportState> emit) {
    emit(state.copyWith(activeFilter: event.filter, clearFilter: event.filter == null));
  }

  FutureOr<void> _onTicketAdded(SupportTicketAdded event, Emitter<SupportState> emit) {
    emit(state.copyWith(tickets: [event.ticket, ...state.tickets]));
  }
}
