import 'package:equatable/equatable.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_category.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_status.dart';

class DocumentItem extends Equatable {
  final String id;
  final String iconAsset;
  final String title;
  final String subtitle;
  final DocCategory category;
  final DocStatus status;
  final String? fileUrl;

  const DocumentItem({
    required this.id,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.category,
    this.status = DocStatus.none,
    this.fileUrl = '',
  });

  @override
  List<Object?> get props => [id, iconAsset, title, subtitle, category, status, fileUrl];
}

class CertDocument extends Equatable {
  final String id;
  final String iconAsset;
  final String title;
  final String subtitle;
  final String accentTokenName; // maps to ColorPalette in UI layer
  final String? fileUrl;

  const CertDocument({
    required this.id,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.accentTokenName,
    this.fileUrl = '',
  });

  @override
  List<Object?> get props => [id, iconAsset, title, subtitle, accentTokenName, fileUrl];
}

class DocumentsData extends Equatable {
  final List<DocumentItem> legalDocs;
  final List<DocumentItem> paymentDocs;
  final List<CertDocument> certificates;

  const DocumentsData({required this.legalDocs, required this.paymentDocs, required this.certificates});

  @override
  List<Object?> get props => [legalDocs, paymentDocs, certificates];
}
