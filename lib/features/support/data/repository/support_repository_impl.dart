import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/support/data/datasources/support_datasource.dart';
import 'package:temp_architecture_app_setup/features/support/domain/entity/support_ticket_entity.dart';
import 'package:temp_architecture_app_setup/features/support/domain/repository/support_repository.dart';

@Injectable(as: SupportRepository)
class SupportRepositoryImpl implements SupportRepository {
  final SupportDataSource _dataSource;

  const SupportRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<SupportTicketEntity>>> getTickets() async {
    try {
      final tickets = await _dataSource.getTickets();
      return Right(tickets);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
