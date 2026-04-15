import 'package:temp_architecture_app_setup/core/enums/document_preview_type.dart';

class DocumentPreviewResolution {
  final DocumentPreviewType type;
  final String reason;
  final String normalizedTitle;
  final String normalizedUrl;

  const DocumentPreviewResolution({required this.type, required this.reason, required this.normalizedTitle, required this.normalizedUrl});
}

class DocumentPreviewUtils {
  const DocumentPreviewUtils._();

  static DocumentPreviewType resolve({required String? title, required String? fileUrl}) {
    return resolveDetailed(title: title, fileUrl: fileUrl).type;
  }

  static DocumentPreviewResolution resolveDetailed({required String? title, required String? fileUrl}) {
    final safeTitle = (title ?? '').trim();
    final safeUrl = (fileUrl ?? '').trim();
    final lowerTitle = safeTitle.toLowerCase();
    final lowerUrl = safeUrl.toLowerCase();

    if (safeUrl.isEmpty) {
      return DocumentPreviewResolution(
        type: DocumentPreviewType.unavailable,
        reason: '${DocumentPreviewType.unavailable.defaultReason} URL is empty.',
        normalizedTitle: lowerTitle,
        normalizedUrl: lowerUrl,
      );
    }

    final hasPdfMatch = lowerTitle.endsWith('.pdf') || lowerUrl.contains('.pdf');
    if (hasPdfMatch) {
      return DocumentPreviewResolution(
        type: DocumentPreviewType.pdf,
        reason: '${DocumentPreviewType.pdf.defaultReason} Matched .pdf in title/url.',
        normalizedTitle: lowerTitle,
        normalizedUrl: lowerUrl,
      );
    }

    String? matchedImageExtension;
    for (final ext in _imageExtensions) {
      if (lowerTitle.endsWith(ext) || lowerUrl.contains(ext)) {
        matchedImageExtension = ext;
        break;
      }
    }
    if (matchedImageExtension != null) {
      return DocumentPreviewResolution(
        type: DocumentPreviewType.image,
        reason: '${DocumentPreviewType.image.defaultReason} Matched extension: $matchedImageExtension',
        normalizedTitle: lowerTitle,
        normalizedUrl: lowerUrl,
      );
    }

    final parsedUrl = Uri.tryParse(safeUrl);
    final isHttpUrl = parsedUrl != null && (parsedUrl.scheme == 'http' || parsedUrl.scheme == 'https');
    if (isHttpUrl) {
      return DocumentPreviewResolution(
        type: DocumentPreviewType.image,
        reason: '${DocumentPreviewType.image.defaultReason} No extension found; treating http/https URL as image preview fallback.',
        normalizedTitle: lowerTitle,
        normalizedUrl: lowerUrl,
      );
    }

    return DocumentPreviewResolution(
      type: DocumentPreviewType.unsupported,
      reason: '${DocumentPreviewType.unsupported.defaultReason} Supported: .pdf, ${_imageExtensions.join(', ')}',
      normalizedTitle: lowerTitle,
      normalizedUrl: lowerUrl,
    );
  }

  static const List<String> _imageExtensions = <String>['.png', '.jpg', '.jpeg', '.webp'];
}
