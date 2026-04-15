import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/error/failures.dart';
import 'package:temp_architecture_app_setup/features/documents/data/datasources/documents_datasource.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document_entities.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/repository/documents_repository.dart';

@Injectable(as: DocumentsRepository)
class DocumentsRepositoryImpl implements DocumentsRepository {
  final DocumentsDataSource _dataSource;

  const DocumentsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, DocumentsDataEntity>> getDocumentsData() async {
    try {
      final data = await _dataSource.getDocumentsData();
      return Right(data);
    } catch (e) {
      return Left(Failure.handleException(e));
    }
  }
}
