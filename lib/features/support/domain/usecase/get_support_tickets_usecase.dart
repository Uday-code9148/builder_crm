import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket.dart';
import 'package:temp_architecture_app_setup/features/support/domain/repository/support_repository.dart';

@injectable
class GetSupportTicketsUseCase extends UseCase<List<SupportTicket>, NoParams> {
  final SupportRepository _repository;

  GetSupportTicketsUseCase(this._repository);

  @override
  FutureEitherFailure<List<SupportTicket>> call(NoParams params) => _repository.getTickets();
}
