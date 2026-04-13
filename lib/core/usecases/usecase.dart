import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';

typedef FutureEitherFailure<T> = Future<Either<Failure, T>>;

abstract class UseCase<Success, Params> {
  FutureEitherFailure<Success> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
