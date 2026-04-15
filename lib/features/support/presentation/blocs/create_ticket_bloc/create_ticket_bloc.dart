import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_architecture_app_setup/core/common/widgets/selectable_item_bottom_sheet.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';

part 'create_ticket_event.dart';
part 'create_ticket_state.dart';

class CreateTicketBloc extends Bloc<CreateTicketEvent, CreateTicketState> {
  CreateTicketBloc() : super(CreateTicketState()) {
    on<CreateTicketInitialEvent>(_onCreateTicketInitialEvent);
    on<CreateTicketSubmitted>(_onSubmitted);
    on<CreateTicketResetRequested>((event, emit) => emit(CreateTicketState()));
    on<CreateTicketCategoryChanged>(_onCategoryChanged);
  }

  FutureOr<void> _onCreateTicketInitialEvent(CreateTicketInitialEvent event, Emitter<CreateTicketState> emit) {
    final initialSelectedCategory = SelectableItem<TicketCategory>(title: TicketCategory.maintenance.label, value: TicketCategory.maintenance);
    final categoryItems = TicketCategory.values.map((c) => SelectableItem<TicketCategory>(title: c.label, value: c)).toList(growable: false);
    emit(state.copyWith(category: initialSelectedCategory, categoryItems: categoryItems));
  }

  FutureOr<void> _onCategoryChanged(CreateTicketCategoryChanged event, Emitter<CreateTicketState> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _onSubmitted(CreateTicketSubmitted event, Emitter<CreateTicketState> emit) async {
    emit(state.copyWith(status: CreateTicketStatus.submitting, error: null));
    await Future<void>.delayed(const Duration(milliseconds: 2050));

    final now = DateTime.now();
    final idSuffix = (now.millisecondsSinceEpoch % 100000).toString().padLeft(5, '0');
    final created = SupportTicketEntity(
      id: '#TCK-$idSuffix',
      category: state.category?.value,
      title: event.title.trim(),
      preview: event.description.trim(),
      status: TicketStatus.open,
      timeLabel: 'Just now',
      isUrgent: false,
    );

    emit(state.copyWith(status: CreateTicketStatus.success, createdTicket: created));
  }
}
