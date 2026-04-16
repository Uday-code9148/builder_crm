import 'package:flutter/material.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_status.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document_entities.dart';

class DocItemVM {
  final String iconAsset;
  final String title;
  final String? subtitle;
  final String? categoryLabel;
  final Color? statusColor;
  final String? statusLabel;
  final String fileUrl;

  const DocItemVM({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.categoryLabel,
    required this.statusColor,
    required this.statusLabel,
    required this.fileUrl,
  });

  factory DocItemVM.from(DocumentItemEntity item) {
    final status = item.status ?? DocStatus.none;
    return DocItemVM(
      iconAsset: item.iconAsset ?? ImageResources.icDocuments,
      title: item.title ?? '--',
      subtitle: (item.subtitle?.isNotEmpty == true) ? item.subtitle : null,
      categoryLabel: item.category?.label,
      statusColor: status.color,
      statusLabel: status.label,
      fileUrl: item.fileUrl ?? '',
    );
  }
}

class CertDocVM {
  final String iconAsset;
  final String title;
  final String subtitle;
  final Color accent;
  final String fileUrl;

  const CertDocVM({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.fileUrl,
  });

  factory CertDocVM.from(CertDocumentEntity cert) => CertDocVM(
        iconAsset: cert.iconAsset ?? ImageResources.icDocuments,
        title: cert.title ?? '--',
        subtitle: cert.subtitle ?? '--',
        accent: _resolveAccent(cert.accentTokenName),
        fileUrl: cert.fileUrl ?? '',
      );

  static Color _resolveAccent(String? token) => switch (token) {
        'secondaryPurple' => ColorPalette.secondaryPurple,
        'tertiaryTeal' => ColorPalette.tertiaryTeal,
        _ => ColorPalette.primaryTealFixed,
      };
}

class DocumentsViewModel {
  final List<DocItemVM> legalDocs;
  final List<DocItemVM> paymentDocs;
  final List<CertDocVM> certificates;

  const DocumentsViewModel({
    required this.legalDocs,
    required this.paymentDocs,
    required this.certificates,
  });

  factory DocumentsViewModel.from(DocumentsDataEntity data) => DocumentsViewModel(
        legalDocs: (data.legalDocs ?? const <DocumentItemEntity>[]).map(DocItemVM.from).toList(),
        paymentDocs: (data.paymentDocs ?? const <DocumentItemEntity>[]).map(DocItemVM.from).toList(),
        certificates: (data.certificates ?? const <CertDocumentEntity>[]).map(CertDocVM.from).toList(),
      );
}
