import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';

class SupportTicket extends Equatable {
  final String id;
  final TicketCategory category;
  final String title;
  final String preview;
  final TicketStatus status;
  final String timeLabel;
  final bool isUrgent; // drives red time label color

  const SupportTicket({
    required this.id,
    required this.category,
    required this.title,
    required this.preview,
    required this.status,
    required this.timeLabel,
    this.isUrgent = false,
  });

  @override
  List<Object?> get props => [id, category, title, preview, status, timeLabel, isUrgent];
}
