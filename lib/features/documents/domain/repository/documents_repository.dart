import 'package:temp_architecture_app_setup/core/usecases/usecase.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document.dart';

abstract class DocumentsRepository {
  FutureEitherFailure<DocumentsData> getDocumentsData();
}
