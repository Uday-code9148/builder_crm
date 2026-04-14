import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/documents/data/datasources/documents_datasource.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document.dart';

@LazySingleton(as: DocumentsDataSource)
class DocumentsMockDataSource implements DocumentsDataSource {
  @override
  Future<DocumentsData> getDocumentsData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const DocumentsData(
      legalDocs: [
        DocumentItem(
          id: 'DOC-001',
          iconAsset: ImageResources.icPurchaseAgreement,
          title: 'Purchase Agreement_V4.pdf',
          subtitle: 'Updated: Oct 24, 2023 · 2.4 MB',
          category: DocCategory.legal,
        ),
        DocumentItem(
          id: 'DOC-002',
          iconAsset: ImageResources.icTitleDeedDraft,
          title: 'Title Deed_Draft.pdf',
          subtitle: 'Updated: Sep 12, 2023 · 1.1 MB',
          category: DocCategory.legal,
        ),
      ],
      paymentDocs: [
        DocumentItem(
          id: 'DOC-003',
          iconAsset: ImageResources.icInitialDepositReceipt,
          title: 'Initial Deposit Receipt #4920',
          subtitle: '',
          category: DocCategory.paymentFinance,
          status: DocStatus.verified,
        ),
        DocumentItem(
          id: 'DOC-004',
          iconAsset: ImageResources.icStructuralEscrow,
          title: 'Structural Escrow Release Schedule',
          subtitle: '',
          category: DocCategory.paymentFinance,
          status: DocStatus.pending,
        ),
      ],
      certificates: [
        CertDocument(
          id: 'CERT-001',
          iconAsset: ImageResources.icEnvironmentalImpact,
          title: 'Environmental Impact Report',
          subtitle: 'Certified by Urban Planning Dept.',
          accentTokenName: 'secondaryPurple',
        ),
        CertDocument(
          id: 'CERT-002',
          iconAsset: ImageResources.icEnergyRating,
          title: 'Energy Rating Certificate',
          subtitle: 'A+ Sustainability Grade',
          accentTokenName: 'primaryTeal',
        ),
        CertDocument(
          id: 'CERT-003',
          iconAsset: ImageResources.icSafetyInspection,
          title: 'Safety Inspection Log',
          subtitle: 'Last inspected: Oct 10, 2023',
          accentTokenName: 'tertiaryTeal',
        ),
      ],
    );
  }
}
