enum DocCategory {
  legal(label: 'Legal Document'),
  paymentFinance(label: 'Payment & Finance'),
  certificate(label: 'Certificate');

  final String label;

  const DocCategory({required this.label});
}
