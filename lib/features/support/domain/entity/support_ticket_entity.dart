import 'package:temp_architecture_app_setup/core/enums/ticket_category.dart';
import 'package:temp_architecture_app_setup/core/enums/ticket_status.dart';

class SupportTicketEntity {
  final String? id;
  final TicketCategory? category;
  final String? title;
  final String? preview;
  final TicketStatus? status;
  final String? timeLabel;
  final bool? isUrgent;

  const SupportTicketEntity({this.id, this.category, this.title, this.preview, this.status, this.timeLabel, this.isUrgent = false});
}
