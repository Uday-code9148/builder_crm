import 'package:temp_architecture_app_setup/features/documents/domain/entity/document_entities.dart';

abstract class DocumentsDataSource {
  Future<DocumentsDataEntity> getDocumentsData();
}
