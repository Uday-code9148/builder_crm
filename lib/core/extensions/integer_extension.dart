extension IntegerExtension on int {
  /// Formats with Indian (cr/lac/k) or international (B/M/K) notation.
  String convertCurrencyFormat({String? currency}) {
    if (this < 0) return 'Negative values not supported';
    if (this == 0) return '--';

    const indian = ['INR', 'NPR', 'BDT', 'PKR', 'LKR'];
    final isIndian = currency == null || indian.contains(currency);
    final prefix = (currency != null && currency.isNotEmpty) ? '$currency ' : '';

    if (isIndian) {
      final factors = [10000000, 100000, 1000];
      final labels = ['cr', 'lac', 'k'];
      for (var i = 0; i < factors.length; i++) {
        if (this >= factors[i]) {
          return '$prefix${(this / factors[i]).toStringAsFixed(1)} ${labels[i]}';
        }
      }
    } else {
      final factors = [1000000000, 1000000, 1000];
      final labels = ['B', 'M', 'K'];
      for (var i = 0; i < factors.length; i++) {
        if (this >= factors[i]) {
          return '$prefix${(this / factors[i]).toStringAsFixed(1)} ${labels[i]}';
        }
      }
    }
    return '$prefix$this';
  }

  /// `1` → `'Jan'`, `12` → `'Dec'`.
  String get monthName {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    if (this < 1 || this > 12) return '';
    return months[this - 1];
  }
}
