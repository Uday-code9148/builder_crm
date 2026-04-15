part of 'create_ticket_bloc.dart';

enum CreateTicketStatus { initial, submitting, success, failure }

@immutable
class CreateTicketState extends Equatable {
  final CreateTicketStatus status;
  final SelectableItem<TicketCategory>? category;
  final List<SelectableItem<TicketCategory>> categoryItems;
  final SupportTicketEntity? createdTicket;
  final String? error;

  const CreateTicketState({this.status = CreateTicketStatus.initial, this.category, this.categoryItems = const [], this.createdTicket, this.error});

  CreateTicketState copyWith({
    CreateTicketStatus? status,
    SelectableItem<TicketCategory>? category,
    List<SelectableItem<TicketCategory>>? categoryItems,
    SupportTicketEntity? createdTicket,
    String? error,
  }) {
    return CreateTicketState(
      status: status ?? this.status,
      category: category ?? this.category,
      categoryItems: categoryItems ?? this.categoryItems,
      createdTicket: createdTicket ?? this.createdTicket,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, category, categoryItems, createdTicket, error];
}
