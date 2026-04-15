import 'package:injectable/injectable.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_category.dart';
import 'package:temp_architecture_app_setup/core/enums/doc_status.dart';
import 'package:temp_architecture_app_setup/core/resources/image_resources/image_resources.dart';
import 'package:temp_architecture_app_setup/features/documents/data/datasources/documents_datasource.dart';
import 'package:temp_architecture_app_setup/features/documents/domain/entity/document_entities.dart';

@LazySingleton(as: DocumentsDataSource)
class DocumentsMockDataSource implements DocumentsDataSource {
  @override
  Future<DocumentsDataEntity> getDocumentsData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const DocumentsDataEntity(
      legalDocs: [
        DocumentItemEntity(
          id: 'DOC-001',
          iconAsset: ImageResources.icPurchaseAgreement,
          title: 'Purchase Agreement_V4.pdf',
          subtitle: 'Updated: Oct 24, 2023 · 2.4 MB',
          category: DocCategory.legal,
          fileUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
        ),
        DocumentItemEntity(
          id: 'DOC-002',
          iconAsset: ImageResources.icTitleDeedDraft,
          title: 'Title Deed_Draft.pdf',
          subtitle: 'Updated: Sep 12, 2023 · 1.1 MB',
          category: DocCategory.legal,
          fileUrl: 'https://www.africau.edu/images/default/sample.pdf',
        ),
      ],
      paymentDocs: [
        DocumentItemEntity(
          id: 'DOC-003',
          iconAsset: ImageResources.icInitialDepositReceipt,
          title: 'Initial Deposit Receipt #4920',
          subtitle: '',
          category: DocCategory.paymentFinance,
          status: DocStatus.verified,
          fileUrl: 'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=1200',
        ),
        DocumentItemEntity(
          id: 'DOC-004',
          iconAsset: ImageResources.icStructuralEscrow,
          title: 'Structural Escrow Release Schedule',
          subtitle: '',
          category: DocCategory.paymentFinance,
          status: DocStatus.pending,
          fileUrl: 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=1200',
        ),
      ],
      certificates: [
        CertDocumentEntity(
          id: 'CERT-001',
          iconAsset: ImageResources.icEnvironmentalImpact,
          title: 'Environmental Impact Report',
          subtitle: 'Certified by Urban Planning Dept.',
          accentTokenName: 'secondaryPurple',
          fileUrl: 'https://www.orimi.com/pdf-test.pdf',
        ),
        CertDocumentEntity(
          id: 'CERT-002',
          iconAsset: ImageResources.icEnergyRating,
          title: 'Energy Rating Certificate',
          subtitle: 'A+ Sustainability Grade',
          accentTokenName: 'primaryTeal',
          fileUrl: 'https://images.unsplash.com/photo-1517048676732-d65bc937f952?w=1200',
        ),
        CertDocumentEntity(
          id: 'CERT-003',
          iconAsset: ImageResources.icSafetyInspection,
          title: 'Safety Inspection Log',
          subtitle: 'Last inspected: Oct 10, 2023',
          accentTokenName: 'tertiaryTeal',
          fileUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
        ),
      ],
    );
  }
}
