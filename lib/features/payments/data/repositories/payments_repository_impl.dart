import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/payments/data/datasources/payments_datasource.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/entities/payment_entities.dart';
import 'package:temp_architecture_app_setup/features/payments/domain/repositories/payments_repository.dart';

@Injectable(as: PaymentsRepository)
class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentsDataSource _dataSource;

  const PaymentsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, PaymentsDataEntity>> getPaymentsData() async {
    try {
      final data = await _dataSource.getPaymentsData();
      return Right(data);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
