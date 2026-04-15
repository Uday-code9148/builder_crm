import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';

abstract class SupportRepository {
  FutureEitherFailure<List<SupportTicketEntity>> getTickets();
}
