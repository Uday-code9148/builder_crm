import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:temp_architecture_app_setup/core/base/base_stateless_widget.dart';
import 'package:temp_architecture_app_setup/core/enums/document_preview_type.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/app_colors.dart';
import 'package:temp_architecture_app_setup/core/resources/colors/color_palette.dart';
import 'package:temp_architecture_app_setup/core/resources/text_styles/app_text_styles.dart';
import 'package:temp_architecture_app_setup/core/utils/document_preview_utils.dart';

class DocumentDetailsPage extends BaseStatelessWidget {
  final String? title;
  final String? subtitle;
  final String? categoryLabel;
  final String? statusLabel;
  final String? fileUrl;

  const DocumentDetailsPage({super.key, this.title, this.subtitle, this.categoryLabel, this.fileUrl, this.statusLabel});

  @override
  Widget buildContent(BuildContext context) {
    final colors = context.colors;
    final resolvedTitle = title ?? 'Untitled Document';
    final resolvedSubtitle = subtitle ?? 'No description available';
    final resolvedCategoryLabel = categoryLabel ?? '--';

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text('Document Details', style: AppTextStyles.s14SemiBold.copyWith(color: colors.onSurface)),
        backgroundColor: colors.surface,
        surfaceTintColor: ColorPalette.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resolvedTitle, style: AppTextStyles.s16SemiBold.copyWith(color: colors.onSurface)),
                  const SizedBox(height: 6),
                  Text(resolvedSubtitle, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  _MetaRow(label: 'Category', value: resolvedCategoryLabel),
                  if (statusLabel != null) ...[const SizedBox(height: 8), _MetaRow(label: 'Status', value: statusLabel!)],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _DocumentPreview(title: title, fileUrl: fileUrl),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentPreview extends StatelessWidget {
  final String? title;
  final String? fileUrl;

  const _DocumentPreview({required this.title, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final safeUrl = fileUrl ?? '';
    final previewResolution = DocumentPreviewUtils.resolveDetailed(title: title, fileUrl: fileUrl);
    final previewType = previewResolution.type;

    if (previewType == DocumentPreviewType.unsupported || previewType == DocumentPreviewType.unavailable) {
      developer.log(
        '[DocumentPreview] type=$previewType reason=${previewResolution.reason}\n'
        'title="${title ?? ''}"\n'
        'url="$safeUrl"\n'
        'normalizedTitle="${previewResolution.normalizedTitle}"\n'
        'normalizedUrl="${previewResolution.normalizedUrl}"',
        name: 'DocumentDetailsPage',
      );
    }

    if (previewType == DocumentPreviewType.unavailable) {
      return _PreviewMessage(message: previewType.userMessage);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.2)),
        ),
        child: previewType == DocumentPreviewType.pdf
            ? SfPdfViewer.network(safeUrl)
            : previewType == DocumentPreviewType.image
            ? InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: Image.network(
                  safeUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (_, error, stackTrace) {
                    developer.log(
                      '[DocumentPreview] image load failed for "$safeUrl". error=$error',
                      name: 'DocumentDetailsPage',
                      error: error,
                      stackTrace: stackTrace,
                    );
                    return const _PreviewMessage(message: 'Unable to load image.');
                  },
                ),
              )
            : _PreviewMessage(message: previewType.userMessage),
      ),
    );
  }
}

class _PreviewMessage extends StatelessWidget {
  final String message;

  const _PreviewMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.s13Regular.copyWith(color: colors.onSurfaceVariant),
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetaRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: Text(label, style: AppTextStyles.s12Regular.copyWith(color: colors.onSurfaceDim)),
        ),
        Expanded(
          child: Text(value, style: AppTextStyles.s12Medium.copyWith(color: colors.onSurface)),
        ),
      ],
    );
  }
}
