extension DoubleFormatting on double? {
  /// Returns `null` if this is `null`, otherwise strips trailing `.0`.
  String? toFormattedString() {
    if (this == null) return null;
    final s = toString();
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  /// Returns `'--'` if the value is null or non-positive.
  String toNonZeroString() {
    if (this == null || this! <= 0) return '--';
    return toString();
  }

  /// Formats a value with Indian (K/L/Cr) or international (K/M/B) notation.
  String convertCurrencyFormat({String? currency, String? currencySymbol}) {
    if (this == null || this! < 0) return '';
    final value = this!;
    final prefix = _resolvePrefix(currency, currencySymbol);
    const indian = ['INR', 'NPR', 'BDT', 'PKR', 'LKR'];
    final isIndian = currency == null || indian.contains(currency);

    if (isIndian) {
      final factors = [100000000000.0, 1000000000.0, 10000000.0, 100000.0, 1000.0];
      final labels = ['kharab', 'arab', 'cr', 'lac', 'k'];
      for (var i = 0; i < factors.length; i++) {
        if (value >= factors[i]) {
          return '$prefix${(value / factors[i]).toStringAsFixed(2)} ${labels[i]}';
        }
      }
    } else {
      final factors = [1000000000000.0, 1000000000.0, 1000000.0, 1000.0];
      final labels = ['T', 'B', 'M', 'K'];
      for (var i = 0; i < factors.length; i++) {
        if (value >= factors[i]) {
          return '$prefix${(value / factors[i]).toStringAsFixed(1)} ${labels[i]}';
        }
      }
    }
    return '$prefix${value.toStringAsFixed(1)}';
  }

  String _resolvePrefix(String? currency, String? symbol) {
    if (symbol != null && symbol.isNotEmpty) return '$symbol ';
    if (currency != null && currency.isNotEmpty) return '$currency ';
    return '';
  }

  /// Compact format: `1500` → `'1.5k'`, `2000000` → `'2.0M'`.
  String toCompactFormat({int decimals = 1, String defaultValue = '0'}) {
    if (this == null) return defaultValue;
    final v = this!.abs();
    if (v >= 1e9) return '${(v / 1e9).toStringAsFixed(decimals)}B';
    if (v >= 1e6) return '${(v / 1e6).toStringAsFixed(decimals)}M';
    if (v >= 1e3) return '${(v / 1e3).toStringAsFixed(decimals)}k';
    final s = v.toStringAsFixed(2);
    return s.replaceAll(RegExp(r'\.?0+$'), '');
  }

  /// Compact format with sign: `1500` → `'+1.5k'`.
  String toCompactFormatWithSign({int decimals = 1, String defaultValue = '0'}) {
    if (this == null) return defaultValue;
    final formatted = toCompactFormat(decimals: decimals, defaultValue: defaultValue);
    return this! >= 0 ? '+$formatted' : '-$formatted';
  }

  /// Returns `'+x%'` or `'-x%'`.
  String toSignedPercentage() {
    final v = this ?? 0;
    return '${v > 0 ? '+' : ''}$v%';
  }

  bool get isNullOrZero => this == null || this == 0.0;

  /// Human-readable budget word: `1500000` → `'INR 15.0 lac'`.
  String budgetToWord([String? currency]) {
    final selected = currency ?? '';
    if (this == null || this! <= 0) return this == 0 ? '$selected 0' : '';
    return convertCurrencyFormat(currency: selected.isEmpty ? null : selected);
  }
}
