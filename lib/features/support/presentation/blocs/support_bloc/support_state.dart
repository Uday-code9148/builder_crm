part of 'support_bloc.dart';

@immutable
class SupportState extends Equatable {
  final DataStatus status;
  final List<SupportTicket> tickets;
  final TicketStatus? activeFilter;
  final String? error;

  const SupportState({this.status = DataStatus.initial, this.tickets = const [], this.activeFilter, this.error});

  SupportState copyWith({DataStatus? status, List<SupportTicket>? tickets, TicketStatus? activeFilter, bool clearFilter = false, String? error}) {
    return SupportState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      activeFilter: clearFilter ? null : (activeFilter ?? this.activeFilter),
      error: error ?? this.error,
    );
  }

  List<SupportTicket> get filteredTickets {
    if (activeFilter == null) return tickets;
    return tickets.where((t) => t.status == activeFilter).toList();
  }

  @override
  List<Object?> get props => [status, tickets, activeFilter, error];
}
