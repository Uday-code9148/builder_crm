enum DocumentPreviewType {
  pdf(defaultReason: 'Detected PDF content.', userMessage: 'Loading PDF preview...'),
  image(defaultReason: 'Detected image content.', userMessage: 'Loading image preview...'),
  unsupported(defaultReason: 'Unsupported document type.', userMessage: 'Preview not supported for this file type.'),
  unavailable(defaultReason: 'Document URL is not available.', userMessage: 'Document URL is not available.');

  final String defaultReason;
  final String userMessage;

  const DocumentPreviewType({required this.defaultReason, required this.userMessage});
}
