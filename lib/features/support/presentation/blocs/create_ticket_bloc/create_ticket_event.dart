part of 'create_ticket_bloc.dart';

@immutable
sealed class CreateTicketEvent {
  const CreateTicketEvent();
}

class CreateTicketInitialEvent extends CreateTicketEvent {}

class CreateTicketSubmitted extends CreateTicketEvent {
  final String title;
  final String description;

  const CreateTicketSubmitted({required this.title, required this.description});
}

class CreateTicketResetRequested extends CreateTicketEvent {
  const CreateTicketResetRequested();
}

class CreateTicketCategoryChanged extends CreateTicketEvent {
  final SelectableItem<TicketCategory>? category;

  const CreateTicketCategoryChanged(this.category);
}
