import 'package:temp_architecture_app_setup/features/documents/domain/entity/document.dart';

abstract class DocumentsDataSource {
  Future<DocumentsData> getDocumentsData();
}
