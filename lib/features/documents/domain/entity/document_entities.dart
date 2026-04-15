import 'package:temp_architecture_app_setup/core/enums/doc_category.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_status.dart';

class DocumentItemEntity {
  final String? id;
  final String? iconAsset;
  final String? title;
  final String? subtitle;
  final DocCategory? category;
  final DocStatus? status;
  final String? fileUrl;

  const DocumentItemEntity({
    this.id,
    this.iconAsset,
    this.title,
    this.subtitle,
    this.category,
    this.status = DocStatus.none,
    this.fileUrl = '',
  });
}

class CertDocumentEntity {
  final String? id;
  final String? iconAsset;
  final String? title;
  final String? subtitle;
  final String? accentTokenName; // maps to ColorPalette in UI layer
  final String? fileUrl;

  const CertDocumentEntity({
    this.id,
    this.iconAsset,
    this.title,
    this.subtitle,
    this.accentTokenName,
    this.fileUrl = '',
  });
}

class DocumentsDataEntity {
  final List<DocumentItemEntity>? legalDocs;
  final List<DocumentItemEntity>? paymentDocs;
  final List<CertDocumentEntity>? certificates;

  const DocumentsDataEntity({this.legalDocs, this.paymentDocs, this.certificates});
}

