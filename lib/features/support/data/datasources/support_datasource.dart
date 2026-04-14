import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket.dart';

abstract class SupportDataSource {
  Future<List<SupportTicket>> getTickets();
}
