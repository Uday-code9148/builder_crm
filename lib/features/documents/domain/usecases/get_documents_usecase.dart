import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document_entities.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/repository/documents_repository.dart';

@injectable
class GetDocumentsUseCase extends UseCase<DocumentsDataEntity, NoParams> {
  final DocumentsRepository _repository;

  GetDocumentsUseCase(this._repository);

  @override
  FutureEitherFailure<DocumentsDataEntity> call(NoParams params) => _repository.getDocumentsData();
}
