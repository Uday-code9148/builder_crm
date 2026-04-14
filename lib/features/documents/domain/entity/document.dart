import 'package:equatable/equatable.dart';

enum DocCategory { legal, paymentFinance, certificate }

enum DocStatus { verified, pending, none }

class DocumentItem extends Equatable {
  final String id;
  final String iconAsset;
  final String title;
  final String subtitle;
  final DocCategory category;
  final DocStatus status;

  const DocumentItem({
    required this.id,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.category,
    this.status = DocStatus.none,
  });

  @override
  List<Object?> get props => [id, iconAsset, title, subtitle, category, status];
}

class CertDocument extends Equatable {
  final String id;
  final String iconAsset;
  final String title;
  final String subtitle;
  final String accentTokenName; // maps to ColorPalette in UI layer

  const CertDocument({
    required this.id,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.accentTokenName,
  });

  @override
  List<Object?> get props => [id, iconAsset, title, subtitle, accentTokenName];
}

class DocumentsData extends Equatable {
  final List<DocumentItem> legalDocs;
  final List<DocumentItem> paymentDocs;
  final List<CertDocument> certificates;

  const DocumentsData({
    required this.legalDocs,
    required this.paymentDocs,
    required this.certificates,
  });

  @override
  List<Object?> get props => [legalDocs, paymentDocs, certificates];
}
