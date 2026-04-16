import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';

class TicketVM {
  final String id;
  final String title;
  final String preview;
  final String timeLabel;
  final bool isUrgent;
  final TicketStatus status;
  final Color statusColor;
  final String statusLabel;
  final IconData timeIcon;
  final TicketCategory category;
  final Color categoryColor;
  final String categoryLabel;

  const TicketVM({
    required this.id,
    required this.title,
    required this.preview,
    required this.timeLabel,
    required this.isUrgent,
    required this.status,
    required this.statusColor,
    required this.statusLabel,
    required this.timeIcon,
    required this.category,
    required this.categoryColor,
    required this.categoryLabel,
  });

  factory TicketVM.from(SupportTicketEntity ticket) {
    final status = ticket.status ?? TicketStatus.open;
    final category = ticket.category ?? TicketCategory.legal;
    return TicketVM(
      id: ticket.id ?? '--',
      title: ticket.title ?? '--',
      preview: ticket.preview ?? '--',
      timeLabel: ticket.timeLabel ?? '--',
      isUrgent: ticket.isUrgent ?? false,
      status: status,
      statusColor: status.color,
      statusLabel: status.label,
      timeIcon: status.timeIcon,
      category: category,
      categoryColor: category.color,
      categoryLabel: category.label,
    );
  }
}

class SupportViewModel {
  final List<TicketVM> allTickets;
  const SupportViewModel({required this.allTickets});

  factory SupportViewModel.from(List<SupportTicketEntity> tickets) =>
      SupportViewModel(allTickets: tickets.map(TicketVM.from).toList());
}
