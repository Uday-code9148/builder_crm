import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';

abstract class SupportDataSource {
  Future<List<SupportTicketEntity>> getTickets();
}
