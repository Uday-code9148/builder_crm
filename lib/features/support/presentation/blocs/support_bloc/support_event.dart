part of 'support_bloc.dart';

@immutable
sealed class SupportEvent {
  const SupportEvent();
}

class SupportLoadRequested extends SupportEvent {
  const SupportLoadRequested();
}

class SupportFilterChanged extends SupportEvent {
  final TicketStatus? filter; // null = All
  const SupportFilterChanged(this.filter) : super();
}
